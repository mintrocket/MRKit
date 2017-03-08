//
//  ArrayExtension.swift
//  MRKit
//
//  Created by Kirill Kunst on 19/12/2016.
//  Copyright © 2016 Mintrocket LLC All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
    
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
}
