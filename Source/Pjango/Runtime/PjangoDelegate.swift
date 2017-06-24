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
    
    func setUrls() -> [String: [PCUrlConfig]]?
    
    func registerPlugins() -> [PCPlugin]?
    
    func registerModels() -> [PCModel]?
    
    func setDB() -> PCDataBase?
    
    func setRequestFilter() -> [(HTTPRequestFilter, HTTPFilterPriority)]?
    
    func setResponseFilter() -> [(HTTPResponseFilter, HTTPFilterPriority)]?
}

public extension PjangoDelegate {
    
    func setSettings() { }
    
    func setUrls() -> [String: [PCUrlConfig]]? { return nil }

    func registerPlugins() -> [PCPlugin]? { return nil }
    
    func registerModels() -> [PCModel]? { return nil }
    
    func setDB() -> PCDataBase? { return nil }
    
    func setRequestFilter() -> [(HTTPRequestFilter, HTTPFilterPriority)]? {
        return [(PCLogFilter.init(), .high)]
    }
    
    func setResponseFilter() -> [(HTTPResponseFilter, HTTPFilterPriority)]? {
        return [(PCLogFilter.init(), .high)]
    }
    
}
