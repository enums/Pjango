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
        return "\(TEMPLATES_DIR)/\(templateName ?? "")"
    }
    
    internal var _pjango_core_view_param: PCViewParam {
        return viewParam ?? PCViewParam()
    }
    
    open static var meta: PCView {
        return self.init()
    }
        
    open var templateName: String? {
        return nil
    }
    
    open var viewParam: PCViewParam? {
        return nil
    }
    
    required public override init() { }
    
    open weak var currentRequest: HTTPRequest? = nil
    
    open static func asHandle() -> PCUrlHandle {
        let handle: RequestHandler = { req, res in
            let view = self.init()
            view.currentRequest = req
            guard view.requestVaild(req) else {
                guard let invaildHandle = view.requestInvaildHandle() else {
                    res._pjango_safe_setBody("Oops! Request is invaild but the `invaild handle` is nil!")
                    _pjango_core_log.error("Failed on rendering view when request is invaild!")
                    return
                }
                invaildHandle(req, res)
                return
            }
            res._pjango_safe_setBody(view.getTemplate())
            view.currentRequest = nil
        }
        return handle

    }
    
    open func requestVaild(_ req: HTTPRequest) -> Bool {
        return req.method == .get
    }
    
    open func requestInvaildHandle() -> PCUrlHandle? {
        return nil
    }
        
    open func getTemplate() -> String {
        do {
            let param = _pjango_core_view_param
            _pjango_core_log.debug("Rendering [\(_pjango_core_class_name)]:\nTemplate: \(_pjango_core_view_template_path)\nParam: \(param)")
            return try PCMustacheUtility.getTemplate(path: _pjango_core_view_template_path, param: param)
        } catch {
            _pjango_core_log.error(error)
            return "Oops! Something wrong when rendering view!"
        }
    }
}
