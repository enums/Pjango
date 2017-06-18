//
//  Plugin.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/18.
//
//

import Foundation
import Pjango_Core

public func pjangoUserRegisterPlugin() -> [PCPlugin] {
    
    return [
        HelloPlugin.meta,
        ReportTimerPlugin.meta,
    ]
    
}

class HelloPlugin: PCTaskPlugin {
    
    override var task: PCTask? {
        return {
            let log = PCCommandLineLog.init(tag: "HelloPlugin")
            log.info("Hello!!!")
        }
    }
    
}

class ReportTimerPlugin: PCTimerPlugin {
    
    override var timerInterval: TimeInterval {
        return 5
    }
    
    override var task: PCTask? {
        let log = PCCommandLineLog.init(tag: "ReportTimerPlugin")
        return {
            log.info("Report timer triggered!")
        }
    }
    
}
