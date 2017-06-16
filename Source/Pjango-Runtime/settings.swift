//
//  settings.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import PerfectLib
import Pjango_Core
import Pjango_Demo

internal func _pjango_runtime_build_settings() {
    PCSettings.shared.workspacePath = WORKSPACE_PATH
    PCSettings.shared.baseDir = "\(WORKSPACE_PATH)/\(BASE_DIR)"
    PCSettings.shared.templatesDir = "\(WORKSPACE_PATH)/\(TEMPLATES_DIR)"
    PCSettings.shared.staticUrl = "\(WORKSPACE_PATH)/\(STATIC_URL)"

}

