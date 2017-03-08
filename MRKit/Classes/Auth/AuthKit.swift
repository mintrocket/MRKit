//
//  AuthKit.swift
//  MRKit
//
//  Created by Kirill Kunst on 21/10/2016.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation

public let AuthKitErrorDomain = "AuthKit"

public protocol AccountType: class {
    var login: String { get set }
    var accessToken: String { get set }
    func getStorableProperties() -> [String]
    func dictionaryWithValues(forKeys keys: [String]) -> [String : Any]
    func setValuesForKeys(_ keyedValues: [String : Any])
    init()
}

extension AccountType {
    public func getStorableProperties() -> [String] {
        return []
    }
}

public protocol AccountStore {
    var type: AccountStoreType { get set }
    
    init(type: AccountStoreType, storeName: String)
    
    func fetchAccount(type: AccountType.Type, service: String) -> AccountType?
    func storeAccount(account: AccountType, service: String)
    func clearAccount(service: String)
}

public enum AccountStoreType: String {
    case Keychain
    case UserDefaults
}

public enum AccountError: String, Error, CustomStringConvertible {
    case NoAccountsFound
    case NoAccessToken
    case AuthenticationFailed
    
    public var description: String {
        return "Error: \(self)"
    }
}
