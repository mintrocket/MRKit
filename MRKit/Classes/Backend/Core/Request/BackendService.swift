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
        
        var headers = request.headers
        var requestParams = request.parameters
        
        if request.commonParamsRequired && requestParams != nil {
            if let commonParams = self.conf.commonParams {
                commonParams.forEach {
                    requestParams?[$0] = $1
                }
            }
        }
        
        if request.commonHeadersRequired && headers != nil {
            if let commonHeaders = self.conf.commonHeaders {
                commonHeaders.forEach {
                    headers?[$0] = $1
                }
            }
        }
        
        if request.miltiPartData?.isEmpty == false  {
            return multipartRequest(request,
                                    url: url,
                                    params: requestParams,
                                    headers: headers)
        } else {
            return defaultRequest(request,
                                  url: url,
                                  params: requestParams,
                                  headers: headers)
        }
        
    }
    
    fileprivate func defaultRequest(_ request: BackendAPIRequest,
                                    url: URL,
                                    params: [String : AnyObject]?,
                                    headers: [String : String]?) -> Observable<ResponseData> {
        return Observable.create { (subscriber) -> Disposable in
            self.service.request(url: url, method: request.method, params: params, headers: headers).subscribe { (event) in
                switch event {
                case .completed:
                    subscriber.on(.completed)
                    break
                case .next(let data):
                    let (response, error) = self.conf.converter.convert(response: data)
                    if error != nil {
                        subscriber.on(.error(error!))
                    } else if response != nil {
                        subscriber.onNext(response!)
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
    
    fileprivate func multipartRequest(_ request: BackendAPIRequest,
                                      url: URL,
                                      params: [String : AnyObject]?,
                                      headers: [String : String]?) -> Observable<ResponseData> {
        return Observable.create { (subscriber) -> Disposable in
            
            self.service.upload(data: request.miltiPartData!,
                                url: url,
                                method: request.method,
                                params: params,
                                headers: headers).subscribe { (event) in
                                    switch event {
                                    case .completed:
                                        subscriber.on(.completed)
                                        break
                                    case .next(let data):
                                        let (response, error) = self.conf.converter.convert(response: data)
                                        if response != nil {
                                            subscriber.onNext(response!)
                                        } else if error != nil {
                                            subscriber.on(.error(error!))
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

