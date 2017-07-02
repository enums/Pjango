//
//  PCFileDBConfig.swift
//  Pjango-Dev
//
//  Created by 郑宇琦 on 2017/7/2.
//
//

import Foundation

open class PCFileDBConfig: PCDataBaseConfig {
    
    public var schema = "default"
    public var path = ""
    
    public override init?(param: Dictionary<String, Any>) {
        super.init()
        guard let schema = param["SCHEMA"] as? String else {
            return nil
        }
        guard let path = param["PATH"] as? String else {
            return nil
        }
        self.schema = schema
        self.path = path
    }

    
}

