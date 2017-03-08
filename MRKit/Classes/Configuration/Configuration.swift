//
//  Configuration.swift
//  MRKit
//
//  Created by Kirill Kunst on 26/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import UIKit

public enum AppMode: String {
    case debug
    case adhoc
    case release
}

public struct Configuration {
    
    public var appMode: AppMode!
    
    private static let configFilename = "AppConfiguration"
    private static let infoConfigKey = "AppConfig"
    
    public static var shared: Configuration!
    
    var configs: NSDictionary!
    
    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: Configuration.infoConfigKey)!
        let path = Bundle.main.path(forResource: Configuration.configFilename, ofType: "plist")!
        configs = NSDictionary(contentsOfFile: path)!.object(forKey: currentConfiguration) as! NSDictionary
        self.appMode = AppMode(rawValue: (currentConfiguration as! String).lowercased())
    }
    
    public func string(_ key: String) -> String {
        let value: String? = self.configs[key] as? String
        if (value == nil) {
            return ""
        }
        return value!
    }
    
    public func integer(_ key: String) -> Int {
        let value: Int? = self.configs[key] as? Int
        if (value == nil) {
            return 0
        }
        return value!
    }
    
    //MARK: - Console errors
    
    public func consoleErrorsAutolayour(enable: Bool) {
        UserDefaults.standard.set(enable, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
}
