//
//  NetworkService.swift
//  MRKit
//
//  Created by Kirill Kunst on 05/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

open class NetworkService: Loggable {
    
    
    public var defaultLoggingTag: LogTag {
        return .Service
    }
    
    fileprivate static let requestTimeout : Double = 10
    
    fileprivate var task: URLSessionTask?
    public var successCodes: CountableRange<Int> = 200..<299
    public var failureCodes: CountableRange<Int> = 400..<499
    
    fileprivate var manager: Alamofire.SessionManager!
    
    public enum Method: String {
        case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
    }
    
    init() {
        self.manager = Alamofire.SessionManager(configuration: self.configuration())
    }
    
    fileprivate func configuration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = NetworkService.requestTimeout
        configuration.timeoutIntervalForRequest = NetworkService.requestTimeout
        return configuration
    }

    
    func request(url: URL, method: Method,
                     params: [String: AnyObject]? = nil,
                     headers: [String: String]? = nil) ->  Observable<(Data, Int, HTTPURLResponse?, URLRequest?)> {
        
        let requestURL: URL?
        if (params != nil) {
            let parameterString = params!.stringFromHttpParameters()
            requestURL = URL(string:"\(url)?\(parameterString)")!
        } else {
            requestURL = url as URL
        }
        
        var request = URLRequest(url: requestURL!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: NetworkService.requestTimeout)
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        
        if (method != .GET && params != nil) {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: params!, options: [])
                request.httpBody = bodyData
                self.addJSONContentType(request: &request)
            } catch  {
                
            }
        }
        
        return Observable.create({ (observer) -> Disposable in
            let request = self.manager.request(request)
            self.log(.debug, "Request: \(request)")
            self.task = request.task
            request.response(completionHandler: { (response) in
                if (response.data != nil) {
                    observer.on(.next((response.data!,response.response!.statusCode, response.response, response.request)))
                    observer.on(.completed)
                } else {
                    if (response.error != nil) {
                        observer.on(.error(response.error!))
                    } else {
                        observer.on(.error(AppError.networkError(code: -500)))
                    }
                    
                }
            })
            return Disposables.create()
        })
    }
    
    func addJSONContentType(request: inout URLRequest) {
        if (request.allHTTPHeaderFields == nil) {
            request.allHTTPHeaderFields = [:]
        }
        request.allHTTPHeaderFields!["Content-type"] = "application/json"
        
    }
    
    func cancel() {
        task?.cancel()
    }
}
