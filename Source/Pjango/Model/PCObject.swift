//
//  PCObject.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation

open class PCObject {
    
    public var _pjango_core_class_name: String {
        return String(describing: Mirror.init(reflecting: self).subjectType)
    }
    
    public static var _pjango_core_class_name: String {
        return String(describing: Mirror.init(reflecting: self).subjectType).components(separatedBy: ".")[0]
    }

}
