//
//  PCTimerPlugin.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/18.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation

open class PCTimerPlugin: PCPlugin {
    
    open var timerInterval: TimeInterval {
        return 1
    }
    
    open var timerDelay: TimeInterval {
        return 0
    }
    
    open var timerRepeatTimes: Int {
        return 0
    }
    
    override var _pjango_core_plugin_task: PCTask? {
        return {
            Thread.sleep(forTimeInterval: self.timerDelay)
            if self.timerRepeatTimes <= 0 {
                while true {
                    _pjango_core_log.debug("Plugin [\(self._pjango_core_class_name)] triggered!")
                    self.task?()
                    Thread.sleep(forTimeInterval: self.timerInterval)
                }
            } else {
                var time = 0
                while true {
                    _pjango_core_log.debug("Plugin [\(self._pjango_core_class_name)] triggered!")
                    self.task?()
                    time += 1
                    if time >= self.timerRepeatTimes {
                        break
                    }
                    Thread.sleep(forTimeInterval: self.timerInterval)
                }
            }
        }
    }
    
}
