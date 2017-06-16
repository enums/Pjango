//
//  PCSettings.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/16.
//
//

import Foundation

fileprivate let _pcSettings = PCSettings.init()

final public class PCSettings {
    
    public static var shared: PCSettings {
        return _pcSettings
    }
    
    // Pjango
    public var workspacePath = ""
    public var debugLog = true
    
    //Django
    public var baseDir = ""
    public var templatesDir = ""
    
    public var staticUrl = ""

    fileprivate init() { }
    
    
}
