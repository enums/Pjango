//
//  PCLog.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import PerfectLib
import Dispatch

internal let _pjango_core_log = PCLog.init(tag: "Pjango-Core")

internal var _pjang_core_log_queue = DispatchQueue.init(label: "pjango.log")

internal var _pjango_core_log_file: File?

public class PCLog {
    
    public var tag: String
    
    
    public init(tag: String) {
        self.tag = tag
    }
    
    public func info(_ msg: String) {
        _pjango_core_log_msg("[\(Date.init().stringValue)][\(tag)][INFO]: \(msg)")
    }
    
    public func debug(_ msg: String) {
        if PJANGO_LOG_DEBUG {
            _pjango_core_log_msg("[\(Date.init().stringValue)][\(tag)][DEBUG]: \(msg)")
        }
    }
    
    public func error(_ msg: String) {
        _pjango_core_log_msg("[\(Date.init().stringValue)][\(tag)][ERROR]: \(msg)")
    }
    
    public func error(_ err: Error) {
        _pjango_core_log_msg("[\(Date.init().stringValue)][\(tag)][ERROR]: \(err.localizedDescription)")
    }
    
    public func releaseLogFile() {
        _pjang_core_log_queue.async {
            guard let file = _pjango_core_log_file else {
                return
            }
            file.close()
            _pjango_core_log_file = nil
            self.info("Sucess on releasing log file.")
        }
    }
    
    public func openLogFile(_ path: String = PJANGO_LOG_PATH) {
        _pjang_core_log_queue.async {
            guard _pjango_core_log_file == nil else {
                self.error("Cannot open log file due to log file is not released!")
                return
            }
            let file = File.init(path)
            do {
                try file.open(.readWrite)
                _pjango_core_log_file = file
                self.info("Success on opening log file.")
            } catch {
                print("Cannot open log file! \(error)")
            }
        }
    }
    
    internal func _pjango_core_log_msg(_ msg: String) {
        print(msg)
        if PJANGO_LOG_TO_FILE {
            _pjang_core_log_queue.async {
                if _pjango_core_log_file == nil {
                    let file = File.init(PJANGO_LOG_PATH)
                    do {
                        try file.open(.readWrite)
                        _pjango_core_log_file = file
                    } catch {
                        print("Cannot open log file! \(error)")
                    }
                }
                guard let log = _pjango_core_log_file else {
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
