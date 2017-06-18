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
        ReportTimer.meta
    ]
    
}

class ReportTimer: PCTimerPlugin {
    
    override var timerInterval: TimeInterval {
        return 5
    }
    
    override var task: PCTask? {
        let log = PCCommandLineLog.init(tag: "ReportTimer")
        return {
            log.info("Report timer triggered!")
        }
    }
    
}
