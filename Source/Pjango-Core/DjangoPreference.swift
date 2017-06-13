//
//  DjangoPreference.swift
//  Pjango-Core
//
//  Created by 郑宇琦 on 2017/6/13.
//

import Foundation
import PerfectHTTP

public func url(_ url: String, _ handle: @escaping RequestHandler, _ name: String? = nil) -> PCUrlConfig {
    return PCUrlConfig(url: url, handle: handle, name: name)
}

public func HttpResponse(_ msg: String) -> RequestHandler {
    return { req, res in
        res.setHeader(.contentType, value: "text/html")
        res.setBody(string: msg)
        res.completed()
    }
}
