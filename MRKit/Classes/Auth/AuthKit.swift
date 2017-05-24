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
    init()
}

public protocol AccountStore {
    func fetchAccount<T: AccountType>(type: T.Type) -> T?
    func storeAccount<T: AccountType>(account: T)
    func clearAccount()
}

public enum AccountError: String, Error, CustomStringConvertible {
    case NoAccountsFound
    case NoAccessToken
    case AuthenticationFailed
    
    public var description: String {
        return "Error: \(self)"
    }
}
