//
//  PCObject.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation

open class PCObject {
    
    open var _pjango_core_class_name: String {
        return String(describing: Mirror.init(reflecting: self).subjectType)
    }
    
    open static var _pjango_core_class_name: String {
        return String(describing: Mirror.init(reflecting: self).subjectType).components(separatedBy: ".")[0]
    }

}
