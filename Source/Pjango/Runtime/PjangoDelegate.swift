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
}

public extension PjangoDelegate {
    
    func setSettings() { }
    
    func setUrls() -> [String: [PCUrlConfig]]? { return nil }

    func registerPlugins() -> [PCPlugin]? { return nil }
    
    func registerModels() -> [PCModel]? { return nil }
    
    func setDB() -> PCDataBase? { return nil }
    
}
