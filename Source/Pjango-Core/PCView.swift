//
//  PCView.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/15.
//
//

import Foundation
import PerfectMustache

public typealias PCViewParam = Dictionary<String, Any>

public protocol PCViewable {
    
    func toViewParam() -> PCViewParam
    
}
open class PCView {
    
    open var _pjango_core_class_name: String {
        return String(describing: object_getClass(self)!)
    }
    
    open var _pjango_core_template_path: String {
        return "\(TEMPLATES_DIR)/\(templateName)"
    }
    
    open var _pjango_core_param: PCViewParam {
        return objects ?? PCViewParam()
    }
    
    open var templateName: String {
        return ""
    }
    
    open var objects: PCViewParam? {
        return nil
    }

    required public init() { }
    
    open func getTemplate() -> String {
        do {
            _pjango_core_log.debug("\(_pjango_core_class_name) Render Template:\nPath: \(_pjango_core_template_path)\nParam: \(_pjango_core_param)\n")
            return try PCUtility.getMustacheTemplate(path: _pjango_core_template_path, param: _pjango_core_param)
        } catch {
            _pjango_core_log.error(error)
            return PCDefaultTemplate.template404
        }
    }
}
