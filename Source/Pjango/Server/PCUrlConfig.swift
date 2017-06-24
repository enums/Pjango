//
//  PCUrlConfig.swift
//  Pjango-Core
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import PerfectHTTP

public struct PCUrlConfig {
    
    public var url: String
    public var handle: RequestHandler
    public var host: String?
    public var name: String?
    
    public init(url: String, handle: @escaping RequestHandler, host: String? = nil, name: String? = nil) {
        self.url = url
        self.handle = handle
        self.host = host
        self.name = name
    }
    
}
