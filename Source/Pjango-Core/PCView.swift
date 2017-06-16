//
//  PCView.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/15.
//
//

import Foundation

open class PCView {
    
    open var template_name = ""
    open var context_object_name = ""

    required public init() { }
    
    open func getObjects() -> Dictionary<String, Any>? {
        return nil
    }
    
    open func getTemplate() -> String {
        do {
            let path = "\(PCSettings.shared.templatesDir)/\(template_name)"
            let obj = getObjects() ?? Dictionary<String, Any>()
            _pjango_core_log.debug("_pjango_core_getTemplate\nPath: \(path)\nParam: \(obj)\n")
            return try PCUtility.getMustacheTemplate(path: path, param: obj)
        } catch {
            _pjango_core_log.error(error)
            return PCDefaultTemplate.template404
        }
    }
}
