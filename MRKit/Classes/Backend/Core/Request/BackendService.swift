//
//  BackendService.swift
//  MRKit
//
//  Created by Kirill Kunst on 05/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation
import RxSwift

class BackendService: Loggable {
    
    var defaultLoggingTag: LogTag {
        return .Service
    }
    
    fileprivate let conf: BackendConfiguration
    fileprivate let service: NetworkService!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    init(_ conf: BackendConfiguration) {
        self.conf = conf
        self.service = NetworkService()
    }
    
    func request(_ request: BackendAPIRequest) -> Observable<ResponseData> {
        
        var url = conf.baseURL.appendingPathComponent(request.apiVersion)
        url = url.appendingPathComponent(request.endpoint)
        let headers = request.headers
        
        var requestParams = request.parameters!
        if (request.authRequired) {
            requestParams["access_token"] = self.conf.accessToken! as AnyObject?
            requestParams["id_user"] = self.conf.currentUserId! as AnyObject?
        }
        
        return Observable.create { (subscriber) -> Disposable in
            self.service.request(url: url, method: request.method, params: requestParams, headers: headers).subscribe { (event) in
                switch event {
                case .completed:
                    subscriber.on(.completed)
                    break
                case .next(let data):
                    let json: AnyObject? = try! JSONSerialization.jsonObject(with: (data.0 as NSData) as Data, options: []) as AnyObject?
                    self.log(.debug, "Response: \(json)")
                    
                    let response = (json! as! [String: AnyObject])["response"]
                    let error = response!["error"] as! Bool
                    
                    if !error {
                        let result = response?["result"]
                        let res = ResponseData(statusCode: data.1, data: result as AnyObject, request: data.3, response: data.2)
                        subscriber.onNext(res)
                    } else {
                        subscriber.on(.error(AppError.unexpectedError(message: "Error message from server nil")))
                    }
                    break
                case .error(let errorType):
                    subscriber.on(.error(errorType))
                    break
                }
            }.addDisposableTo(self.disposeBag)
            return Disposables.create()
        }
    }
    
    func cancel() {
        service.cancel()
    }
}
