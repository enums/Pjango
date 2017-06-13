//
//  CommandLineLog.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation

public class CommandLineLog {
    
    public var tag: String
    
    public init(tag: String) {
        self.tag = tag
    }
    
    public func info(_ msg: String) {
        print("[\(Date.init().stringValue)][\(tag)][INFO]: \(msg)")
    }
    
    public func error(_ msg: String) {
        print("[\(Date.init().stringValue)][\(tag)][ERROR]: \(msg)")
    }
    
    public func error(_ err: Error) {
        print("[\(Date.init().stringValue)][\(tag)][ERROR]: \(err.localizedDescription)")
    }
}
