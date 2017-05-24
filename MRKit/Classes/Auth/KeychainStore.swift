//
//  KeychainStore.swift
//  MRKit
//
//  Created by Иван Морозов on 5/24/17.
//  Copyright © 2017 MintRocket. All rights reserved.
//

import Foundation
import KeychainAccess

open class KeychainStore: AccountStore, Loggable {
    public var defaultLoggingTag: LogTag {
        return .Service
    }

    private static let accessTokenKey = "ACCESS_TOKEN"
    private static let loginKey = "LOGIN"

    public var storeName: String

    required public init(storeName: String) {
        self.storeName = storeName
    }

    open func fetchAccount<T>(type: T.Type) -> T? where T : AccountType {
        self.log(.debug, "Fetch account for service: \(storeName)")
        let keychain = self.keychain(service: storeName)
        let login = keychain[KeychainStore.loginKey]
        let accessToken = keychain[KeychainStore.accessTokenKey]

        if (login == nil || accessToken == nil) {
            self.log(.debug, "Fail account fetching")
            return nil
        }
        let user = type.init()
        user.login = login!
        user.accessToken = accessToken!

        return user
    }

    open func storeAccount<T>(account: T) where T : AccountType {
        let keychain = self.keychain(service: storeName)
        keychain[KeychainStore.loginKey] = account.login
        keychain[KeychainStore.accessTokenKey] = account.accessToken
        self.log(.debug, "Successful store account")
    }

    open func clearAccount() {
        try! self.keychain(service: storeName).removeAll()
    }


    private func keychain(service: String) -> Keychain {
        return Keychain(service: service)
    }
}
