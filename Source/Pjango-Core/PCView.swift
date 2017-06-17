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

open class PCView {
    
    open var templateName = ""
    open var contextObjectName = ""
    open var objects: PCViewParam? {
        return nil
    }

    required public init() { }
    
    open func getTemplate() -> String {
        do {
            let path = "\(TEMPLATES_DIR)/\(templateName)"
            let obj = objects ?? PCViewParam()
            _pjango_core_log.debug("_pjango_core_getTemplate\nPath: \(path)\nParam: \(obj)\n")
            return try PCUtility.getMustacheTemplate(path: path, param: obj)
        } catch {
            _pjango_core_log.error(error)
            return PCDefaultTemplate.template404
        }
    }
}
