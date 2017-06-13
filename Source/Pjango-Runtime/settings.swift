//
//  settings.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import PerfectLib
import Pjango_Demo

func settings_build() {
    workspace_path = WORKSPACE_PATH
    base_dir = "\(workspace_path)/\(BASE_DIR)"
    templates_dir = "\(workspace_path)/\(TEMPLATES_DIR)"
    
    static_url = "\(workspace_path)\(STATIC_URL)"
}

var workspace_path: String! = nil

var base_dir: String! = nil
var templates_dir: String! = nil

var static_url: String! = nil
