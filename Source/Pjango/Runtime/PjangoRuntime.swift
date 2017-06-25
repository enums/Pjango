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
    
    internal static let _pjango_runtime_log = PCLog.init(tag: "Pjango-Runtime")
    
    public static var _pjango_runtime_urls_name2config = Dictionary<String, PCUrlConfig>()
    
    public static var _pjango_runtime_urls_list = Array<PCUrlConfig>()
    
    public static var _pjango_runtime_models_name2meta = Dictionary<String, PCMetaModel>()
    
    public static var _pjango_runtime_database = PCDataBase.empty
    
    public static var _pjango_runtime_server = HTTPServer.init()
    
    public static var _pjango_runtime_plugin = Array<PCPlugin>()
    
    public static func run(delegate: PjangoDelegate) {
        _pjango_runtime_run(delegate: delegate)
    }
    
    internal static func _pjango_runtime_run(delegate: PjangoDelegate) {
        // MARK: - Prepare
        print("Hello Pjango!")
        
        // MARK: - Configuration
        print("Configuring...")
        _pjango_runtime_setSettings(delegate: delegate)
        _pjango_runtime_setUrls(delegate: delegate)
        _pjango_runtime_setDB(delegate: delegate)
        _pjango_runtime_registerModels(delegate: delegate)
        _pjango_runtime_registerPlugins(delegate: delegate)
        
        // MARK: - Server
        _pjango_runtime_log.info("Starting...")
        _pjango_runtime_setServer(delegate: delegate)
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
        LOG_PATH = "\(WORKSPACE_PATH)/\(LOG_PATH)"
        
        //Django
        
        BASE_DIR = "\(WORKSPACE_PATH)/\(BASE_DIR)"
        STATIC_URL = "\(WORKSPACE_PATH)/\(STATIC_URL)"
    }
    
    internal static func _pjango_runtime_setUrls(delegate: PjangoDelegate) {
        
        guard let list = delegate.setUrls() else {
            return
        }
        
        list.forEach { (host, configList) in
            guard configList.count > 0 else {
                return
            }
            for var config in configList {
                config.host = host
                _pjango_runtime_urls_list.append(config)
                if let name = config.name {
                    _pjango_runtime_urls_name2config[name] = config
                }
            }
        }
    }
    
    internal static func _pjango_runtime_registerPlugins(delegate: PjangoDelegate) {
        
        _pjango_runtime_plugin = delegate.registerPlugins() ?? []
        
        _pjango_runtime_plugin.forEach { $0.run() }
        
    }
    
    internal static func _pjango_runtime_setDB(delegate: PjangoDelegate) {
        
        let database = delegate.setDB() ?? PCDataBase.empty
        
        _pjango_runtime_database = database
        
        guard database.state != .empty else {
            return
        }
        
        database.setup()
        database.connect()
        
        if let schema = database.schema {
            if !database.isSchemaExist(schema) {
                _pjango_runtime_log.info("Schema `\(schema)` is not exist! Create it.")
                database.createSchema()
            }
        }
        
    }
    
    internal static func _pjango_runtime_registerModels(delegate: PjangoDelegate) {
        
        let metas = delegate.registerModels() ?? []
        
        metas.forEach { meta in
            if !_pjango_runtime_database.isTableExist(meta.tableName) {
                _pjango_runtime_log.info("Table `\(meta.tableName)` is not exist! Create it.")
                _pjango_runtime_database.createTable(model: meta)
            }
            _pjango_runtime_models_name2meta[meta._pjango_core_class_name] = meta
        }
    }
    
    internal static func _pjango_runtime_setServer(delegate: PjangoDelegate) {
        
        
        var allConfig = [PCUrlConfig]()
        
        var leftConfig = [PCUrlConfig]()

        _pjango_runtime_urls_list.forEach {
            if $0.host == nil || $0.host == "" {
                allConfig.append($0)
            } else {
                leftConfig.append($0)
            }
        }
        
        //[host: [url: config]] -> [url: [(host, config)]]
        //[host: [url: config]]
        var hostUrlConfig = [String: [String: PCUrlConfig]]()
        
        leftConfig.forEach { config in
            if let host = config.host {
                if hostUrlConfig[host] == nil {
                    hostUrlConfig[host] = [String: PCUrlConfig]()
                }
                hostUrlConfig[host]![config.url] = config
            }
        }
        //[url: [(host, config)]]
        var urlHostConfig = [String: [(String, PCUrlConfig)]]()
        for (host, urlConfig) in hostUrlConfig {
            for (url, config) in urlConfig {
                if urlHostConfig[url] == nil {
                    urlHostConfig[url] = [(host, config)]
                } else {
                    urlHostConfig[url]!.append((host, config))
                }
            }
        }
        
        var routeList = allConfig.map { config in
            Route.init(uri: config.url) { req, res in
                config.handle(req, res)
                res.completed()
            }
        }
        
        for (url, configList) in urlHostConfig {
            let route = Route.init(uri: url) { req, res in
                guard let index = configList.index(where: { $0.0 == req.header(.host) }) else {
                    res.status = .notFound
                    res.completed()
                    return
                }
                let (_, config) = configList[index]
                config.handle(req, res)
                res.completed()
            }
            routeList.append(route)
        }

        let routes = Routes.init(routeList)
        let server = HTTPServer.init()
        server.documentRoot = STATIC_URL
        server.serverPort = SERVER_PORT
        server.addRoutes(routes)
        
        server.setRequestFilters(delegate.setRequestFilter() ?? [])
        server.setResponseFilters(delegate.setResponseFilter() ?? [])
        
        _pjango_runtime_server = server
    }

}
