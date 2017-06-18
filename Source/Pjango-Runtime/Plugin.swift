//
//  Plugin.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/18.
//
//

import Foundation
import Pjango_Core
import Pjango_Demo

internal func _pjango_runtime_setPlugin() {
    
    _pjango_core_runtime_plugin = pjangoUserRegisterPlugin()
    
    _pjango_core_runtime_plugin.forEach { $0.run() }
    
}
