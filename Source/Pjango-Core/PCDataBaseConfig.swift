//
//  PCDataBaseConfig.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation

public enum PCDataBaseEnginType: String {
    case mysql = "mysql"
}

public struct PCDataBaseConfig {
    
    public var engine = PCDataBaseEnginType.mysql
    public var name = "default"
    public var user = "root"
    public var password = ""
    public var host = "127.0.0.1"
    public var port = UInt16(3306)
    
    public init() { }
    
    public init?(param: Dictionary<String, Any>) {
        guard let engine = param["ENGINE"] as? PCDataBaseEnginType else {
                return nil
        }
        guard let name = param["NAME"] as? String else {
            return nil
        }
        guard let user = param["USER"] as? String else {
            return nil
        }
        guard let password = param["PASSWORD"] as? String else {
            return nil
        }
        guard let host = param["HOST"] as? String else {
            return nil
        }
        guard let port = param["PORT"] as? UInt16 else {
            return nil
        }
        self.engine = engine
        self.name = name
        self.user = user
        self.password = password
        self.host = host
        self.port = port
    }
}
