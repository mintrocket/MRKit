//
//  MRKitAccountStore.swift
//  MRKit
//
//  Created by Kirill Kunst on 21/10/2016.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation

public class AccessStore: KeychainStore {

    private static let accountItemsKey = "user_data_items"

    public var storableProperties: [String] = []

    public init(storeName: String, storableProperties: [String]) {
        super.init(storeName: storeName)
        self.storableProperties = storableProperties
    }
    
    required public init(storeName: String) {
        super.init(storeName: storeName)
    }

    public override func fetchAccount<T>(type: T.Type) -> T? where T : AccountType {
        if let user = super.fetchAccount(type: type) {
            if let user = self.loadStoredProperties(account: user) {
                self.log(.debug, "Successful account step 2 fetching")
                return user
            }
        }

        self.log(.debug, "Fail account step 2 fetching")
        return nil
    }

    public override func storeAccount<T>(account: T) where T : AccountType {
        self.storeProperties(account: account)
        super.storeAccount(account: account)
    }

    public override func clearAccount() {
        super.clearAccount()
        self.storedUserData = []
    }

    //MARK: - UserDefaults

    private func storeProperties<T>(account: T) {
        let properties = self.storableProperties
        if properties.count > 0 {
            if let account = account as? NSObject {
                self.storedUserData = account.dictionaryWithValues(forKeys: properties).map(StorableItem.init)
            }
        }
    }

    private var storedUserData: [StorableItem] {
        get {
            let userDefaults = UserDefaults.standard
            if let decoded  = userDefaults.object(forKey: AccessStore.accountItemsKey) as? Data,
                let decodedItems = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [StorableItem] {
                return decodedItems
            }

            return []
        }
        set {
            let userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(encodedData, forKey: AccessStore.accountItemsKey)
            userDefaults.synchronize()
        }
    }

    private func loadStoredProperties<T>(account: T) -> T? {
        var dic: [String : Any] = [:]
        let userData = storedUserData
        if userData.count > 0 {
            for item in userData {
                dic[item.key!] = item.value!
            }
            if let account = account as? NSObject {
                account.setValuesForKeys(dic)
                return account as? T
            }
        }
        return nil
    }
}

fileprivate class StorableItem: NSObject, NSCoding {
    var key: String?
    var value: Any?

    init(key: String, value: Any) {
        self.key = key
        self.value = value
    }

    required init(coder decoder: NSCoder) {
        super.init()
        self.key = decoder.decodeObject(forKey: "key") as? String
        self.value = decoder.decodeObject(forKey: "value")
    }

    public func encode(with coder: NSCoder) {
        coder.encode(key, forKey: "key")
        coder.encode(value, forKey: "value")
    }
}


