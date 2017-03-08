//
//  MRKitCache.swift
//  MRKit
//
//  Created by Kirill Kunst on 16/12/2016.
//  Copyright © 2016 Mintrocket LLC All rights reserved.
//

import Foundation
import Cache

public struct MRKitCache {
    
    public static var cache: HybridCache!
    public static var syncCache: SyncHybridCache!
    
    public static func initialize(cacheName: String) {
        self.cache = HybridCache(name: cacheName)
        self.syncCache = SyncHybridCache(self.cache)
    }
    
    public static func clear() {
        self.cache.clear()
        self.syncCache.clear()
    }
    
}
