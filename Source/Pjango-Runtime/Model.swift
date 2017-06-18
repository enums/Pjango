//
//  Model.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation
import Pjango_Core
import Pjango_Demo

internal func _pjango_runtime_setDataBase() -> PCDataBase {
    
    let config = DATABASE
    var database: PCDataBase
    
    switch config.engine {
    case .mysql:
        database = PCMySQLDataBase.init(config: config)
    }
    
    database.setup()
    database.connect()
    
    if !database.isSchemeExist(config.name) {
        _pjango_runtime_log.info("Scheme `\(config.name)` is not exist! Create it.")
        database.createScheme()
    }
    
    let metas = pjangoUserRegisterModels()
    
    metas.forEach { meta in
        if !database.isTableExist(meta.tableName) {
            _pjango_runtime_log.info("Table `\(meta.tableName)` is not exist! Create it.")
            database.createTable(meta)
        }
        _pjango_core_runtime_models_name2meta[meta._pjango_core_class_name] = meta
    }
    
    
    return database
}


