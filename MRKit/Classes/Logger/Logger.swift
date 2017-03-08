//
//  File.swift
//  MRKit
//
//  Created by Kirill Kunst on 05/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import Foundation

public enum LogTag: String {
    case Observable
    case Model
    case ViewModel
    case View
    case Service
    case Presenter
}

public enum LogLevel: Int {
    case verbose = 0
    case debug = 1
    case info = 2
    case warning = 3
    case error = 4
}

public protocol Loggable {
    var defaultLoggingTag: LogTag { get }
    
    func log(_ level: LogLevel,_ message: String, _ path: String, _ function: String, line: Int)
    func log(_ level: LogLevel, tag: LogTag,_ message: String, _ path: String, _ function: String, line: Int)
}

public extension Loggable {
    func log(_ level: LogLevel, _ message: String, _ path: String = #file, _ function: String = #function, line: Int = #line) {
        log(level, tag: defaultLoggingTag, message, path, function, line: line)
    }
    func log(_ level: LogLevel, tag: LogTag,_ message: String, _ path: String = #file, _ function: String = #function, line: Int = #line) {
        Logger.sharedInstance.log(level, tag: tag, className: String(describing: type(of: self)), message, path, function, line: line)
    }
}

protocol LoggerType {
    func log(_ level: LogLevel, tag: LogTag, className: String,_ message: String, _ path: String, _ function: String, line: Int)
}

final class Logger {
    
    internal var activeLogger: LoggerType?
    internal var disabledSymbols = Set<String>()
    fileprivate(set) static var sharedInstance = Logger()
    
    /// Overrides shared instance, useful for testing
    static func setSharedInstance(_ logger: Logger) {
        sharedInstance = logger
    }
    
    func setupLogger(_ logger: LoggerType) {
        assert(activeLogger == nil, "Changing logger is disallowed to maintain consistency")
        activeLogger = logger
    }
    
    func ignoreClass(_ type: AnyClass) {
        disabledSymbols.insert(String(describing: type))
    }
    
    func ignoreTag(_ tag: LogTag) {
        disabledSymbols.insert(tag.rawValue)
    }
    
    func log(_ level: LogLevel, tag: LogTag, className: String,_ message: String, _ path: String, _ function: String, line: Int) {
        guard logAllowed(tag, className: className) else { return }
        activeLogger?.log(level, tag: tag, className: className, message, path, function, line: line)
    }
    
    fileprivate func logAllowed(_ tag: LogTag, className: String) -> Bool {
        return !disabledSymbols.contains(className) && !disabledSymbols.contains(tag.rawValue)
    }
    
}
