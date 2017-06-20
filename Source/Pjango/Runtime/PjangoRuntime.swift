//
//  PjangoRuntime.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/20.
//
//

import Foundation
import PerfectHTTP
import PerfectHTTPServer

public class PjangoRuntime {
    
    internal static let _pjango_runtime_log = PCCommandLineLog.init(tag: "Pjango-Runtime")
    
    public static var _pjango_runtime_urls_url2config = Dictionary<String, PCUrlConfig>()
    
    public static var _pjango_runtime_urls_name2config = Dictionary<String, PCUrlConfig>()
    
    public static var _pjango_runtime_models_name2meta = Dictionary<String, PCMetaModel>()
    
    public static var _pjango_runtime_database = PCDataBase.empty
    
    public static var _pjango_runtime_server = HTTPServer.init()
    
    public static var _pjango_runtime_plugin = Array<PCPlugin>()
    
    public static var _pjango_runtime_url = Array<PCUrlConfig>()
    
    public static func run(delegate: PjangoDelegate) {
        _pjango_runtime_run(delegate: delegate)
    }
    
    internal static func _pjango_runtime_run(delegate: PjangoDelegate) {
        // MARK: - Prepare
        _pjango_runtime_log.info("Hello Pjango!")
        
        // MARK: - CommandLine
        guard CommandLine.argc >= 2 else {
            _pjango_runtime_log.error("Please input port!")
            exit(0)
        }
        
        guard let port = UInt16(CommandLine.arguments[1]) else {
            _pjango_runtime_log.error("Illegal port!")
            exit(0)
        }
        
        // MARK: - Configuration
        _pjango_runtime_log.info("Configuring...")
        _pjango_runtime_setSettings(delegate: delegate)
        _pjango_runtime_setUrls(delegate: delegate)
        _pjango_runtime_setDB(delegate: delegate)
        _pjango_runtime_registerModels(delegate: delegate)
        _pjango_runtime_registerPlugins(delegate: delegate)
        
        // MARK: - Server
        _pjango_runtime_log.info("Starting...")
        _pjango_runtime_setServer(port: port)
        do {
            try _pjango_runtime_server.start()
        } catch {
            _pjango_runtime_log.error(error)
        }
    }
    
    internal static func _pjango_runtime_setSettings(delegate: PjangoDelegate) {
        
        delegate.setSettings()
        
        //Pjango
        
        TEMPLATES_DIR = "\(WORKSPACE_PATH)/\(TEMPLATES_DIR)"
        
        //Django
        
        BASE_DIR = "\(WORKSPACE_PATH)/\(BASE_DIR)"
        STATIC_URL = "\(WORKSPACE_PATH)/\(STATIC_URL)"
    }
    
    internal static func _pjango_runtime_setUrls(delegate: PjangoDelegate) {
        
        _pjango_runtime_url = delegate.setUrls()
        
        _pjango_runtime_url.forEach { config in
            _pjango_runtime_urls_url2config[config.url] = config
            if let name = config.name {
                _pjango_runtime_urls_name2config[name] = config
            }
        }
    }
    
    internal static func _pjango_runtime_registerPlugins(delegate: PjangoDelegate) {
        
        _pjango_runtime_plugin = delegate.registerPlugins()
        
        _pjango_runtime_plugin.forEach { $0.run() }
        
    }
    
    internal static func _pjango_runtime_setDB(delegate: PjangoDelegate) {
        
        let config = DATABASE
        let database = delegate.setDB()
        
        database.setup()
        database.connect()
        
        if !database.isSchemeExist(config.name) {
            _pjango_runtime_log.info("Scheme `\(config.name)` is not exist! Create it.")
            database.createScheme()
        }
        
        _pjango_runtime_database = database
    }
    
    internal static func _pjango_runtime_registerModels(delegate: PjangoDelegate) {
        
        let metas = delegate.registerModels()
        
        metas.forEach { meta in
            if !_pjango_runtime_database.isTableExist(meta.tableName) {
                _pjango_runtime_log.info("Table `\(meta.tableName)` is not exist! Create it.")
                _pjango_runtime_database.createTable(meta)
            }
            _pjango_runtime_models_name2meta[meta._pjango_core_class_name] = meta
        }
    }
    
    internal static func _pjango_runtime_setServer(port: UInt16) {
        let routeList = _pjango_runtime_urls_url2config.map { (url, config) in
            Route.init(uri: url, handler: config.handle)
        }
        let routes = Routes.init(routeList)
        let server = HTTPServer.init()
        server.documentRoot = STATIC_URL
        server.serverPort = port
        server.addRoutes(routes)
        
        _pjango_runtime_server = server
    }

}
