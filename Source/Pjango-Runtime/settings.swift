//
//  settings.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation
import Pjango_Core

internal func _pjango_runtime_settings() {
    TEMPLATES_DIR = "\(WORKSPACE_PATH)/\(TEMPLATES_DIR)"
    BASE_DIR = "\(WORKSPACE_PATH)/\(BASE_DIR)"
    STATIC_URL = "\(WORKSPACE_PATH)/\(STATIC_URL)"
}
