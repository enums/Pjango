//
//  Django.swift
//  Pjango-Core
//
//  Created by 郑宇琦 on 2017/6/13.
//

import Foundation
import PerfectHTTP

public typealias PCUrl = RequestHandler

public func url(_ url: String, _ handleBlock: @escaping (() -> PCUrl), _ name: String? = nil) -> PCUrlConfig {
    let handle = handleBlock()
    return PCUrlConfig(url: url, handle: handle, name: name)
}

public func url(_ url: String, _ view: PCView, _ name: String? = nil) -> PCUrlConfig {
    let handle: RequestHandler = { req, res in
        res._pjango_safe_setResponse(view.getTemplate())
    }
    return PCUrlConfig(url: url, handle: handle, name: name)
}

public func HttpResponse(_ msg: String) -> PCUrl {
    return HttpResponse { req, res in
        res._pjango_safe_setResponse(msg)
    }
}

public func HttpResponse(_ handle: @escaping RequestHandler) -> PCUrl {
    return handle
}
