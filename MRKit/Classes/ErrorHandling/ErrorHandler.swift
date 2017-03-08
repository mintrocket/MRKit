//
//  ErrorHandler.swift
//  MRKit
//
//  Created by Kirill Kunst on 24/10/2016.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation

public protocol ErrorHandling {
    func handleError(error: Error)
}

public extension ErrorHandling {
    func handleError(error: Error) {
        ErrorHandler.sharedInstance.handleError(error: error)
    }
}

protocol ErrorHandleType {
    func handleError(error: Error)
}

final class ErrorHandler {
    
    internal var activeHandler: ErrorHandleType?
    fileprivate(set) static var sharedInstance = ErrorHandler()
    
    /// Overrides shared instance, useful for testing
    static func setSharedInstance(_ handler: ErrorHandler) {
        sharedInstance = handler
    }
    
    func setupHandler(_ handler: ErrorHandleType) {
        assert(activeHandler == nil, "Changing error handler is disallowed to maintain consistency")
        activeHandler = handler
    }

    func handleError(error: Error) {
        self.activeHandler?.handleError(error: error)
    }
    
}
