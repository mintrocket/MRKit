//
//  BundleExtenstion.swift
//  redarmy
//
//  Created by Kirill Kunst on 03/02/2017.
//  Copyright © 2017 MintRocket LLC. All rights reserved.
//

import Foundation

extension Bundle {
    
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
}
