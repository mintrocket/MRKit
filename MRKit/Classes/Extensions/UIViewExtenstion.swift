//
//  UIViewExtenstion.swift
//  MRKit
//
//  Created by Kirill Kunst on 27/12/2016.
//  Copyright © 2016 Mintrocket LLC All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var snapshotImage: UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    var doublesnapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 2.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
