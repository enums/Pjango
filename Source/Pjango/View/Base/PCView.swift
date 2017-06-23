//
//  PCView.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/15.
//
//

import Foundation
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache

public typealias PCViewParam = Dictionary<String, Any>

open class PCView: PCObject {
    
    internal var _pjango_core_view_template_path: String {
        return "\(TEMPLATES_DIR)/\(templateName)"
    }
    
    internal var _pjango_core_view_param: PCViewParam {
        return viewParam ?? PCViewParam()
    }
        
    open var templateName: String {
        return ""
    }
    
    open var viewParam: PCViewParam? {
        return nil
    }
    
    required public override init() { }
    
    open static func asHandle() -> PCUrlHandle {
        let handle: RequestHandler = { req, res in
            let view = self.init()
            guard view.checkRequest(req) else {
                res._pjango_safe_setBody(ERROR_NOTFOUND_VIEW?.getTemplate() ?? ERROR_NOTFOUND_MSG)
                return
            }
            res._pjango_safe_setBody(view.getTemplate())
        }
        return handle

    }
    
    open func checkRequest(_ req: HTTPRequest) -> Bool {
        return req.method == .get
    }
    
    open func checkRequestFailed() -> PCUrlHandle {
        return { _, _ in }
    }
        
    open func getTemplate(ignoreErrorTemplate: Bool = false) -> String {
        do {
            let param = _pjango_core_view_param
            _pjango_core_log.debug("Rendering [\(_pjango_core_class_name)]:\nTemplate: \(_pjango_core_view_template_path)\nParam: \(param)")
            return try PCMustacheUtility.getTemplate(path: _pjango_core_view_template_path, param: param)
        } catch {
            _pjango_core_log.error(error)
            if ignoreErrorTemplate {
                return ERROR_INTERNAL_MSG
            } else {
                return ERROR_INTERNAL_VIEW?.getTemplate(ignoreErrorTemplate: true) ?? ERROR_INTERNAL_MSG
            }
        }
    }
}