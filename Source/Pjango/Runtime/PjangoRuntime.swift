//
//  PjangoRuntime.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/20.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import PerfectHTTP
import PerfectHTTPServer

public class PjangoRuntime {
    
    internal static let _pjango_runtime_log = PCLog.init(tag: "Pjango-Runtime")
    
    public static var _pjango_runtime_urls_name2config = Dictionary<String, PCUrlConfig>()
    
    public static var _pjango_runtime_urls_list = Array<(String, PCUrlConfig)>()
    
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
        
        PJANGO_TEMPLATES_DIR = "\(PJANGO_WORKSPACE_PATH)/\(PJANGO_TEMPLATES_DIR)"
        PJANGO_LOG_PATH = "\(PJANGO_WORKSPACE_PATH)/\(PJANGO_LOG_PATH)"
        
        //Django
        
        PJANGO_BASE_DIR = "\(PJANGO_WORKSPACE_PATH)/\(PJANGO_BASE_DIR)"
        PJANGO_STATIC_URL = "\(PJANGO_WORKSPACE_PATH)/\(PJANGO_STATIC_URL)"
    }
    
    internal static func _pjango_runtime_setUrls(delegate: PjangoDelegate) {
        
        guard let list = delegate.setUrls() else {
            return
        }
        
        list.forEach { (host, configList) in
            guard configList.count > 0 else {
                return
            }
            for config in configList {
                _pjango_runtime_urls_list.append((host, config))
                if let name = config.name {
                    _pjango_runtime_urls_name2config["\(host)@\(name)"] = config
                }
            }
        }
    }
    
    internal static func _pjango_runtime_registerPlugins(delegate: PjangoDelegate) {
        
        _pjango_runtime_plugin = delegate.registerPlugins() ?? []
        
        _pjango_runtime_plugin.forEach {
            if let filter = $0 as? PCHTTPFilterPlugin {
                _pjango_runtime_server.setRequestFilters([(filter, filter.priority)])
                _pjango_runtime_server.setResponseFilters([(filter, filter.priority)])
            } else {
                $0.run()
            }
        }
        
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
                if let initialObjects = meta.initialObjects() {
                    initialObjects.forEach {
                        _pjango_runtime_database.insertModel($0)
                    }
                }
            }
            _pjango_runtime_models_name2meta[meta._pjango_core_class_name] = meta
        }
    }
    
    internal static func _pjango_runtime_setServer(delegate: PjangoDelegate) {
        
        
        //url->config
        var defaultConfig = [String: PCUrlConfig]()
        
        //(posts, config)
        var userConfig = [(String, PCUrlConfig)]()

        _pjango_runtime_urls_list.forEach { (host, config) in
            if host == PJANGO_HOST_DEFAULT {
                defaultConfig[config.url] = config
            } else {
                userConfig.append((host, config))
            }
        }
        
        //[host: [url: config]] -> [url: [(host, config)]]
        //[host: [url: config]]
        var hostUrlConfig = [String: [String: PCUrlConfig]]()
        
        userConfig.forEach { (host, config) in
            if hostUrlConfig[host] == nil {
                hostUrlConfig[host] = [String: PCUrlConfig]()
            }
            hostUrlConfig[host]![config.url] = config
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
        
        var routeList = defaultConfig.map { (url, config) in
            Route.init(uri: url) { req, res in
                config.handle(req, res)
                res.completed()
            }
        }
        
        for (url, configList) in urlHostConfig {
            let route = Route.init(uri: url) { req, res in
                guard let index = configList.index(where: { $0.0 == req.header(.host) }) else {
                    if let dc = defaultConfig[url] {
                        dc.handle(req, res)
                        res.completed()
                        return
                    } else {
                        res.status = .notFound
                        res.completed()
                        return
                    }
                }
                let (_, config) = configList[index]
                config.handle(req, res)
                res.completed()
            }
            routeList.append(route)
        }

        let routes = Routes.init(routeList)
        _pjango_runtime_server.documentRoot = PJANGO_STATIC_URL
        _pjango_runtime_server.serverPort = PJANGO_SERVER_PORT
        _pjango_runtime_server.addRoutes(routes)
    }

}
