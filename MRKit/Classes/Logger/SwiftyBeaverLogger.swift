//
//  SwiftyBeaverLogger.swift
//  MRKit
//
//  Created by Kirill Kunst on 06/08/16.
//  Copyright © 2016 MintRocket LLC. All rights reserved.
//

import UIKit
import SwiftyBeaver

class SwiftyBeaverLogger: LoggerType {
    
    fileprivate let loggerInstance = SwiftyBeaver.self
    
    init() {
        let console = ConsoleDestination()
        let file = FileDestination()
        loggerInstance.addDestination(console)
        loggerInstance.addDestination(file)
    }
    
    func log(_ level: LogLevel, tag: LogTag, className: String,_ message: String, _ path: String, _ function: String, line: Int) {
        switch level {
        case .debug:
            loggerInstance.debug("------- \n [\(tag.rawValue)][\(className)] \n -> \(message), \n function: \(function), \n line: \(line) \n")
            break
        case .error:
            loggerInstance.error("------- \n [\(tag.rawValue)][\(className)] \n -> \(message), \n function: \(function), \n line: \(line) \n")
            break
        case .info:
            loggerInstance.info("------- \n [\(tag.rawValue)][\(className)] \n -> \(message), \n function: \(function), \n line: \(line) \n")
            break
        case .warning:
            loggerInstance.warning("------- \n [\(tag.rawValue)][\(className)] \n -> \(message), \n function: \(function), \n line: \(line) \n)")
            break
        default:
            loggerInstance.verbose("------- \n [\(tag.rawValue)][\(className)] \n -> \(message), \n function: \(function), \n line: \(line) \n")
            break
        }
    }
}
