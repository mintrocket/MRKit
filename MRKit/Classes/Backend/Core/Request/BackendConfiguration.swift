//
//  BackendConfiguration.swift
//  MRKit
//
//  Created by Kirill Kunst on 05/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation

public final class BackendConfiguration {
    
    let baseURL: URL
    var accessToken: String?
    var currentUserId: String?
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    public static var shared: BackendConfiguration!
    
}
