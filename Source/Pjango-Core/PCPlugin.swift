//
//  PCPlugin.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/18.
//
//

import Foundation

public typealias PCMetaPlugin = PCPlugin

open class PCPlugin: PCObject, PCRunable {
    
    open static var meta: PCMetaPlugin {
        return self.init()
    }
    
    required override public init() { }
    
    public var taskQueue: DispatchQueue {
        return DispatchQueue.init(label: _pjango_core_class_name)
    }
    
    open var task: PCTask? {
        return nil
    }
    
    internal var _pjango_core_plugin_task: PCTask? {
        return task
    }
    
    public func run() {
        _pjango_core_log.info("Component [\(_pjango_core_class_name)] run!")
        taskQueue.async {
            self._pjango_core_plugin_task?()
            _pjango_core_log.info("Component [\(self._pjango_core_class_name)] done!")
        }
    }
    
}
