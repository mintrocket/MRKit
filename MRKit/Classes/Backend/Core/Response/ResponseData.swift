//
//  ResponseData.swift
//  RedArmy
//
//  Created by Kirill Kunst on 24/01/2017.
//  Copyright © 2017 MintRocket LLC. All rights reserved.
//

import Foundation


public class ResponseData: CustomDebugStringConvertible, Equatable {
    
    public let statusCode: Int
    public let data: AnyObject
    public let request: URLRequest?
    public let response: URLResponse?
    
    public init(statusCode: Int, data: AnyObject, request: URLRequest? = nil, response: URLResponse? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
    
    /// A text description of the `Response`.
    public var description: String {
        return "Status Code: \(statusCode), Data Length: \(data.count)"
    }
    
    /// A text description of the `Response`. Suitable for debugging.
    public var debugDescription: String {
        return description
    }
    
    public static func == (lhs: ResponseData, rhs: ResponseData) -> Bool {
        return lhs.statusCode == rhs.statusCode
            && lhs.response == rhs.response
    }
    
}
