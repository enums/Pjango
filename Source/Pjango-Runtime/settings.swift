//
//  Settings.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation
import Pjango_Core
import Pjango_Demo

internal func _pjango_runtime_setSettings() {
    
    pjangoUserSetSettings()

    //Pjango
    
    TEMPLATES_DIR = "\(WORKSPACE_PATH)/\(TEMPLATES_DIR)"
    
    //Django
    
    BASE_DIR = "\(WORKSPACE_PATH)/\(BASE_DIR)"
    STATIC_URL = "\(WORKSPACE_PATH)/\(STATIC_URL)"
}

