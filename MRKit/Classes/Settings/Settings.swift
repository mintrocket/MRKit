//
//  Settings.swift
//  MRKit
//
//  Created by Kirill Kunst on 03.02.16.
//  Copyright © 2016 Mintrocket LLC All rights reserved.
//

import UIKit
import SwiftyUserDefaults

private let MRKitSettingsKeyAppVersion = DefaultsKey<String>("MRKitSettingsKeyAppVersion")
private let MRKitSettingsKeyLanguage = DefaultsKey<String?>("MRKitSettingsKeyLanguage")
private let MRKitSettingsKeyRunnedBefore = DefaultsKey<Bool>("MRKitSettingsKeyRunnedBefore")
private let MRKitSettingsKeyServiceRunning = DefaultsKey<Bool>("MRKitSettingsKeyServiceRunning")

/// App Settings
public class Settings: NSObject {
    
    public var appVersion: String {
        get {
            return Defaults[MRKitSettingsKeyAppVersion]
        }
        set {
            Defaults[MRKitSettingsKeyAppVersion] = newValue
        }
    }
    
    public var language: String? {
        get {
            return Defaults[MRKitSettingsKeyLanguage]
        }
        set {
            Defaults[MRKitSettingsKeyLanguage] = newValue
        }
    }
    
    public var runnedBefore: Bool {
        get {
            return Defaults[MRKitSettingsKeyRunnedBefore]
        }
        set {
             Defaults[MRKitSettingsKeyRunnedBefore] = newValue
        }
    }
    
    public var serviceRunning: Bool {
        get {
            return Defaults[MRKitSettingsKeyRunnedBefore]
        }
        set {
            Defaults[MRKitSettingsKeyRunnedBefore] = newValue
        }
    }
    
}
