//
//  PCRunable.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/18.
//
//

import Foundation
import Dispatch

public typealias PCTask = ()->Void

public protocol PCRunable {
    
    var taskQueue: DispatchQueue { get }
        
    var task: PCTask? { get }
    
    func run()
    
}

