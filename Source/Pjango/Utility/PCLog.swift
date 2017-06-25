//
//  PCLog.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import PerfectLib
import Dispatch

internal let _pjango_core_log = PCLog.init(tag: "Pjango-Core")

internal var _pjang_core_log_queue = DispatchQueue.init(label: "pjango.log")

internal var logFile: File?

public class PCLog {
    
    public var tag: String
    
    
    public init(tag: String) {
        self.tag = tag
    }
    
    public func info(_ msg: String) {
        _pjango_core_log_msg("[\(Date.init().stringValue)][\(tag)][INFO]: \(msg)")
    }
    
    public func debug(_ msg: String) {
        if DEBUG_LOG {
            _pjango_core_log_msg("[\(Date.init().stringValue)][\(tag)][DEBUG]: \(msg)")
        }
    }
    
    public func error(_ msg: String) {
        _pjango_core_log_msg("[\(Date.init().stringValue)][\(tag)][ERROR]: \(msg)")
    }
    
    public func error(_ err: Error) {
        _pjango_core_log_msg("[\(Date.init().stringValue)][\(tag)][ERROR]: \(err.localizedDescription)")
    }
    
    internal func _pjango_core_log_msg(_ msg: String) {
        print(msg)
        if LOG_TO_FILE {
            _pjang_core_log_queue.async {
                if logFile == nil {
                    let file = File.init(LOG_PATH)
                    do {
                        try file.open(.readWrite)
                        logFile = file
                    } catch {
                        print("Cannot open log file! \(error)")
                    }
                }
                guard let log = logFile else {
                    return
                }
                do {
                    try log.write(string: "\(msg)\n")
                } catch {
                    print("Write log file error! \(error)")
                }
            }
        }
    }
    
}
