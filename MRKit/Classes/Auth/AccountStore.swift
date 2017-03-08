//
//  MRKitAccountStore.swift
//  MRKit
//
//  Created by Kirill Kunst on 21/10/2016.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation
import KeychainAccess
import SwiftyUserDefaults

private let UserDataKey = DefaultsKey<[String : Any]>("UserDataKey")

public class AccessStore: AccountStore, Loggable {

    
    public var defaultLoggingTag: LogTag {
        return .Service
    }
    
    static let accessTokenKey = "ACCESS_TOKEN"
    static let loginKey = "LOGIN"
    
    public var storeName: String
    public var type: AccountStoreType
    
    required public init(type: AccountStoreType, storeName: String) {
        self.storeName = storeName
        self.type = type
    }
    
    public func fetchAccount(type: AccountType.Type, service: String) -> AccountType? {
        self.log(.debug, "Fetch account for service: \(service)")
        let keychain = self.keychain(service: service)
        let login = keychain[AccessStore.loginKey]
        let accessToken = keychain[AccessStore.accessTokenKey]
        
        if (login == nil || accessToken == nil) {
            return nil
        }
        let user = type.init()
        user.login = login!
        user.accessToken = accessToken!
        switch self.type {
        case .Keychain:
            self.log(.debug, "Successful account fetching")
            return user
        case .UserDefaults:
            if let user = self.loadStoredProperties(account: user) {
                self.log(.debug, "Successful account fetching")
                return user
            }
            self.log(.debug, "Fail account fetching")
            return nil
        }
    }
    
    public func storeAccount(account: AccountType, service: String) {
        let keychain = self.keychain(service: service)
        keychain[AccessStore.loginKey] = account.login
        keychain[AccessStore.accessTokenKey] = account.accessToken
        switch self.type {
        case .Keychain:
            self.log(.debug, "Successful store account")
            break
        case .UserDefaults:
            self.storeProperties(account: account)
            self.log(.debug, "Successful store account")
            break
        }
    }
    
    public func clearAccount(service: String) {
        try! self.keychain(service: service).removeAll()
        self.storedUserData = [:]
    }
    
    
    public func keychain(service: String) -> Keychain {
        return Keychain(service: service)
    }
    
    //MARK: - UserDefaults
    
    private func storeProperties(account: AccountType) {
        let properties = account.getStorableProperties()
        if properties.count > 0 {
            self.storedUserData = account.dictionaryWithValues(forKeys: properties)
        }
    }
    
    private var storedUserData: [String : Any] {
        get {
            return Defaults[UserDataKey]
        }
        set {
            Defaults[UserDataKey] = newValue
        }
    }
    
    private func loadStoredProperties(account: AccountType) -> AccountType? {
        let userData = storedUserData
        if userData.count > 0 {
            account.setValuesForKeys(userData)
            return account
        }
        return nil
    }
}


