//
//  BackendResponseConverter.swift
//  MRKit
//
//  Created by Иван Морозов on 3/6/17.
//  Copyright © 2017 MintRocket. All rights reserved.
//

import Foundation

public protocol BackendResponseConverter: class {
    func convert(response data: NetworkService.NetworkResponse) -> (ResponseData?, Error?)
}

public class JsonResponseConverter: BackendResponseConverter, Loggable {
    public var defaultLoggingTag: LogTag {
        return .Service
    }
    
    public func convert(response data: NetworkService.NetworkResponse) -> (ResponseData?, Error?) {
        if (data.0 as NSData).length == 0 {
            return (nil, AppError.networkError(code: MRKitErrorCode.emptyResponse))
        }
        let json: AnyObject? = try? JSONSerialization.jsonObject(with: data.0, options: []) as AnyObject
        self.log(.debug, "Response: \(json)")
        if json == nil {
            return (nil,AppError.networkError(code: MRKitErrorCode.emptyResponse))
        }
        let response = json! as! [String: AnyObject]
        let res = ResponseData(statusCode: data.1, data: response as AnyObject, request: data.3, response: data.2)
        return (res, nil)
    }
}
