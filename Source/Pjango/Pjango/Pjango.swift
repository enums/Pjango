//
//  Pjango.swift
//  Pjango-Core
//
//  Created by 郑宇琦 on 2017/6/13.
//

import Foundation
import PerfectHTTP

public typealias PCUrlHandle = RequestHandler

public func pjangoUrl(_ url: String, host: String? = nil, name: String? = nil, handle: @escaping (() -> PCUrlHandle)) -> PCUrlConfig {
    return pjangoUrl(url, host: host, name: name, handle: handle())
}

public func pjangoUrl(_ url: String, host: String? = nil, name: String? = nil, handle: @escaping PCUrlHandle) -> PCUrlConfig {
    return PCUrlConfig(url: url, handle: handle, host: host, name: name)
}

public func pjangoUrlReverse(name: String) -> String? {
    guard let config = PjangoRuntime._pjango_runtime_urls_name2config[name] else {
        return nil
    }
    if let host = config.host {
        return "\(host)/\(config.url)"
    } else {
        return "/\(config.url)"
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

public func pjangoHttpResponse(_ handle: @escaping RequestHandler) -> PCUrlHandle {
    return handle
}

public func pjangoHttpRedirect(name: String) -> PCUrlHandle? {
    guard let url = pjangoUrlReverse(name: name) else {
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
