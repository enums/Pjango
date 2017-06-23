//
//  PCNotFoundFilter.swift
//  Pjango-Project
//
//  Created by 郑宇琦 on 2017/6/21.
//
//

import Foundation
import PerfectHTTP

internal class PCNotFoundFilter: HTTPResponseFilter {
    
    func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        callback(.continue)
    }
    
    func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        if case .notFound = response.status {
            let body = ERROR_NOTFOUND_VIEW?.getTemplate() ?? ERROR_NOTFOUND_MSG
            response._pjango_safe_setBody(body)
            callback(.done)
        } else {
            callback(.continue)
        }

    }
}
