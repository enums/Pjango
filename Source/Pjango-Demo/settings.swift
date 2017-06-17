//
//  settings.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import Pjango_Core

public func _pjango_user_setSettings() {
    
    // Pjango
    WORKSPACE_PATH = "/Users/Enum/Developer/macOS/Pjango/Workspace"

    DEBUG_LOG = true

    // Django
    BASE_DIR = ""

    TEMPLATES_DIR = "templates"

    STATIC_URL = "static"
    
    DATABASE = PCDataBaseConfig.init(param: [
        "ENGINE": PCDataBaseEnginType.mysql,
        "NAME": "Pjango_default",
        "USER": "github",
        "PASSWORD": "enumsgithub.",
        "HOST": "127.0.0.1",
        "PORT": UInt16(3306),
    ])!
}
