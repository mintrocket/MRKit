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
    var converter: BackendResponseConverter
    var accessTokenConfiguration: BackendTokenConfiguration
    
    public init(baseURL: URL,
                converter: BackendResponseConverter,
                accessTokenConfiguration: BackendTokenConfiguration = BackendTokenConfiguration()) {
        self.baseURL = baseURL
        self.converter = converter
        self.accessTokenConfiguration = accessTokenConfiguration
    }
    
    public static var shared: BackendConfiguration!
}
