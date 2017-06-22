//
//  PjangoDelegate.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/20.
//
//

import Foundation
import PerfectHTTP

public protocol PjangoDelegate {
    
    func setSettings()
    
    func setUrls() -> [PCUrlConfig]
    
    func registerPlugins() -> [PCPlugin]
    
    func registerModels() -> [PCModel]
    
    func setDB() -> PCDataBase
    
    func setRequestFilter() -> [(HTTPRequestFilter, HTTPFilterPriority)]
    
    func setResponseFilter() -> [(HTTPResponseFilter, HTTPFilterPriority)]
}

public extension PjangoDelegate {
    
    func setSettings() { }
    
    func setUrls() -> [PCUrlConfig] { return [] }
    
    func registerPlugins() -> [PCPlugin] { return [] }
    
    func registerModels() -> [PCModel] { return [] }
    
    func setDB() -> PCDataBase { return PCDataBase.empty }
    
    func setRequestFilter() -> [(HTTPRequestFilter, HTTPFilterPriority)] {
        return [
            (PCLogFilter.init(), .high)
        ]
    }
    
    func setResponseFilter() -> [(HTTPResponseFilter, HTTPFilterPriority)] {
        return [
            (PCLogFilter.init(), .high),
            (PCNotFoundFilter.init(), .low)
        ]
    }
    
}
