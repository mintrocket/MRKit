//
//  BackendError.swift
//  MRKit
//
//  Created by Kirill Kunst on 13/10/2016.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation


public enum AppError: Error, CustomStringConvertible, CustomDebugStringConvertible {
    
    private static let errorDomain: String = "MRKitErrorDomain"
    
    case networkError(code: Int)
    case unexpectedError(message: String)
    case otherNSError(nsError: NSError)
    
    public var description: String {
        switch self {
        case .networkError(let code):
            return "Error with code: \(code)"
        case .unexpectedError(let message):
            return "Unexpected error with message: \(message)"
        case .otherNSError(let nsError):
            return "\(nsError.localizedDescription)"
        }
    }
    
    public var debugDescription: String {
        switch self {
        case .networkError(let code):
            return "Network error: \n code: \(code)"
        case .unexpectedError(let message):
            return "Unexpected error with message: \(message)"
        case .otherNSError(let nsError):
            return "Error: \(nsError.domain), code: \(nsError.code), message: \(nsError.localizedDescription)"
        }
    }
    
    
    public static func nsError(code: Int, message: String) -> NSError {
        return NSError (domain: AppError.errorDomain, code: code, userInfo: [NSLocalizedDescriptionKey: message])
    }
    
}
