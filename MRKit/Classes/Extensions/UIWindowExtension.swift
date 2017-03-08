//
//  UIWindowExtension.swift
//  redarmy
//
//  Created by Kirill Kunst on 09/02/2017.
//  Copyright © 2017 MintRocket LLC. All rights reserved.
//

import Foundation
import UIKit

public extension UIWindow {
    
    public var visibleViewController: UIViewController? {
        return UIWindow.visibleViewControllerFrom(self.rootViewController)
    }
    
    public static func visibleViewControllerFrom(_ vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.visibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.visibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.visibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
    
}
