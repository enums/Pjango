//
//  Pjango.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import PerfectHTTP

public typealias PCUrlHandle = RequestHandler

public func pjangoUrl(_ url: String, name: String? = nil, handle: @escaping (() -> PCUrlHandle)) -> PCUrlConfig {
    return pjangoUrl(url, name: name, handle: handle())
}

public func pjangoUrl(_ url: String, name: String? = nil, handle: @escaping PCUrlHandle) -> PCUrlConfig {
    return PCUrlConfig(url: url, handle: handle, name: name)
}

public func pjangoUrlReverse(host: String, name: String) -> String? {
    guard let config = PjangoRuntime._pjango_runtime_urls_name2config["\(host)@\(name)"] else {
        return nil
    }
    if host == PJANGO_HOST_DEFAULT {
        return "/\(config.url)"
    } else {
        return "http://\(host)/\(config.url)"
    }
}

public func pjangoUrlConfigReverse(name: String) -> PCUrlConfig? {
    return PjangoRuntime._pjango_runtime_urls_name2config[name]
}

public func pjangoHttpResponse(_ msg: String) -> PCUrlHandle {
    return pjangoHttpResponse { req, res in
        res._pjango_safe_setBody(msg)
    }
}

public func pjangoHttpResponse(_ bytes: [UInt8]) -> PCUrlHandle {
    return pjangoHttpResponse { req, res in
        res._pjango_safe_setBody(bytes)
    }
}

public func pjangoHttpResponse(_ handle: @escaping RequestHandler) -> PCUrlHandle {
    return handle
}

public func pjangoHttpRedirect(host: String = PJANGO_HOST_DEFAULT, name: String) -> PCUrlHandle? {
    guard let url = pjangoUrlReverse(host: host, name: name) else {
        return nil
    }
    return pjangoHttpRedirect(url: url)
}

public func pjangoHttpRedirect(url: String) -> PCUrlHandle {
    return pjangoHttpResponse { _, res in
        res.status = .temporaryRedirect
        res.setHeader(.location, value: url)
    }
}
