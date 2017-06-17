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
open class PCView: PCObject {
    
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
    
    required public override init() { }
        
    open func getTemplate() -> String {
        do {
            _pjango_core_log.debug("Render [\(_pjango_core_class_name)]:\nPath: \(_pjango_core_template_path)\nParam: \(_pjango_core_param)\n")
            return try PCMustacheUtility.getTemplate(path: _pjango_core_template_path, param: _pjango_core_param)
        } catch {
            _pjango_core_log.error(error)
            return PCDefaultTemplate.template404
        }
    }
}
