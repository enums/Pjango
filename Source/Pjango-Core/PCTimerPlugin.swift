//
//  PCTimerPlugin.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/18.
//
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
                    self.task?()
                    Thread.sleep(forTimeInterval: self.timerInterval)
                }
            } else {
                var time = 0
                while true {
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
