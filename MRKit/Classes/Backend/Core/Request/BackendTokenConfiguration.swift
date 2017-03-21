//
//  BackendTokenConfiguration.swift
//  MRKit
//
//  Created by Иван Морозов on 3/21/17.
//  Copyright © 2017 MintRocket. All rights reserved.
//

import Foundation

public enum BackendTokenConfigurationPlace {
    case headers
    case params
}

public final class BackendTokenConfiguration {
    public var key: String
    public var place: BackendTokenConfigurationPlace
    
    init(key: String = "token", place: BackendTokenConfigurationPlace = .params) {
        self.key = key
        self.place = place
    }
}
