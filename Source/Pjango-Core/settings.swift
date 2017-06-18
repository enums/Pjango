//
//  Settings.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation

// Pjango

public var WORKSPACE_PATH = ""

public var DEBUG_LOG = true

public var ERROR_MSG_INTERNAL = "INTERNAL ERROR"
public var ERROR_TEMPLATE_INTERNAL: PCView? = nil

public var ERROR_MSG_NOTFOUND = "404"
public var ERROR_TEMPLATE_NOTFOUND: PCView? = nil

// Django
public var BASE_DIR = ""

public var TEMPLATES_DIR = "templates"

public var STATIC_URL = "static"

public var DATABASE = PCDataBaseConfig.init()
