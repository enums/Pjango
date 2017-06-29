//
//  PCUrlConfig.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import PerfectHTTP

public struct PCUrlConfig {
    
    public var url: String
    public var handle: RequestHandler
    public var name: String?
    
    public init(url: String, handle: @escaping RequestHandler, name: String? = nil) {
        self.url = url
        self.handle = handle
        self.name = name
    }
    
}
