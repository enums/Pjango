//
//  PCCommandLineLog.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation

internal let _pjango_core_log = PCCommandLineLog.init(tag: "Pjango-Core")

public class PCCommandLineLog {
    
    public var tag: String
    
    public init(tag: String) {
        self.tag = tag
    }
    
    public func info(_ msg: String) {
        print("[\(Date.init().stringValue)][\(tag)][INFO]: \(msg)")
    }
    
    public func debug(_ msg: String) {
        if DEBUG_LOG {
            print("[\(Date.init().stringValue)][\(tag)][DEBUG]: \(msg)")
        }
    }
    
    public func error(_ msg: String) {
        print("[\(Date.init().stringValue)][\(tag)][ERROR]: \(msg)")
    }
    
    public func error(_ err: Error) {
        print("[\(Date.init().stringValue)][\(tag)][ERROR]: \(err.localizedDescription)")
    }
}
