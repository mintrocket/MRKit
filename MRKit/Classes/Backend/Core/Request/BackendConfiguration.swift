//
//  BackendConfiguration.swift
//  MRKit
//
//  Created by Kirill Kunst on 05/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation


///Configuration of BackendService
public final class BackendConfiguration {
    /// Url of API Server
    let baseURL: URL
    
    /// Server response converter
    var converter: BackendResponseConverter
    
    /// Headers passed to the server by default for all requests
    /// Example, you can pass token:
    /// - commonHeaders = ["token": "TOKEN_VALUE", ...]
    /// The need to send is determined by the BackendAPIRequest
    var commonHeaders: [String : String]?
    
    /// Parameters passed to the server by default for all requests
    /// Example, you can pass token:
    /// - commonHeaders = ["token": "TOKEN_VALUE", ...]
    /// The need to send is determined by the BackendAPIRequest
    var commonParams: [String : AnyObject]?
    
    /// Initialisation of BackendConfiguration
    /// - parameter baseURL: Url of API Server
    /// - parameter converter: Server response converter
    public init(baseURL: URL,
                converter: BackendResponseConverter) {
        self.baseURL = baseURL
        self.converter = converter
    }
    
    /// Shared instance
    public static var shared: BackendConfiguration!
}
