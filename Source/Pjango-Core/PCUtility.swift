//
//  PCUtility.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/15.
//
//

import Foundation
import PerfectMustache

final public class PCUtility {
    
    static public func getMustacheTemplate(path: String, param: Dictionary<String, Any> = [:]) throws -> String {
        let context = MustacheEvaluationContext.init(templatePath: path, map: param)
        let collector = MustacheEvaluationOutputCollector.init()
        return try context.formulateResponse(withCollector: collector)
    }
    
}
