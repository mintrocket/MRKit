//
//  BackendAPIRequest.swift
//  MRKit
//
//  Created by Kirill Kunst on 05/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation
import Alamofire

///Request configuration protocol
protocol BackendAPIRequest {
    /// Path of request without baseUrl and version of API
    ///
    /// Example: "users/detail"
    var endpoint: String { get }
    
    /// Version of API
    ///
    /// Default: "v1"
    var apiVersion: String { get }
    
    /// Network method like GET, POST and etc
    var method: NetworkService.Method { get }
    
    /// Parameters passed to equest
    var parameters: [String: AnyObject]? { get }
    
    /// Headers passed to equest
    var headers: [String: String]? { get }
    
    /// Dictionary for transferring files to the server.
    ///
    /// Enables the multipart/form-data mode, if not nil or not empty.
    ///
    /// Default: nil
    var multiPartData: [String : NetworkService.MultiPartData]? { get }
    
    /// Indicates whether common headers should be passed to request
    /// from the configuration of BeckendService
    ///
    /// Default: false
    var commonHeadersRequired: Bool { get }
    
    /// Indicates whether common parameters should be passed to request
    /// from the configuration of BeckendService
    ///
    /// Default: false
    var commonParamsRequired: Bool { get }
}

extension BackendAPIRequest {
    var apiVersion: String {
        return "v1"
    }
    
    var commonHeadersRequired: Bool {
        return false
    }
    
    var commonParamsRequired: Bool {
        return false
    }
    
    var miltiPartData: [String : NetworkService.MultiPartData]? {
        return nil
    }
}
