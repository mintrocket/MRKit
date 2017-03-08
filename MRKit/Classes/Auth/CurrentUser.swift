//
//  CurrentUser.swift
//  MRKit
//
//  Created by Kirill Kunst on 21/10/2016.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation

public class CurrentUser: NSObject, AccountType {
    
    public var login: String = ""
    public var accessToken: String = ""
    
    override public required init() {
        super.init()
    }
    
    init(login: String, accessToken: String) {
        self.login = login
        self.accessToken = accessToken
    }
    
}
