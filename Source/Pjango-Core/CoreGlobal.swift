//
//  CoreGlobal.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/16.
//
//

import Foundation
import PerfectHTTPServer

internal let _pjango_core_log = PCCommandLineLog.init(tag: "Pjango-Core")

public var _pjango_core_runtime_urls_url2config = Dictionary<String, PCUrlConfig>()

public var _pjango_core_runtime_urls_name2config = Dictionary<String, PCUrlConfig>()

public var _pjango_core_runtime_models_name2meta = Dictionary<String, PCMetaModel>()

public var _pjango_core_runtime_database = PCDataBase.empty

public var _pjango_core_runtime_server = HTTPServer.init()

