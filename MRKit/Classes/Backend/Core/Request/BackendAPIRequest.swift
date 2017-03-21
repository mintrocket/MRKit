//
//  BackendAPIRequest.swift
//  MRKit
//
//  Created by Kirill Kunst on 05/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation
import Alamofire

protocol BackendAPIRequest {
    var endpoint: String { get }
    var apiVersion: String { get }
    var method: NetworkService.Method { get }
    var parameters: [String: AnyObject]? { get }
    var headers: [String: String]? { get }
    var authRequired: Bool {get}
    var miltiPartData: [String : NetworkService.MultiPartData]? { get }
}

extension BackendAPIRequest {
    var apiVersion: String {
        return "v1"
    }
    
    var authRequired: Bool {
        return false
    }
    
    var miltiPartData: [String : NetworkService.MultiPartData]? {
        return nil
    }
}
