//
//  PCMustacheUtility.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/15.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import PerfectMustache

final public class PCMustacheUtility {
    
    static public func getTemplate(path: String, param: Dictionary<String, Any> = [:]) throws -> String {
        let context = MustacheEvaluationContext.init(templatePath: path, map: param)
        let collector = MustacheEvaluationOutputCollector.init()
        return try context.formulateResponse(withCollector: collector)
    }
    
}
