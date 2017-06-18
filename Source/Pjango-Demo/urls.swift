//
//  urls.swift
//  Pjango-Demo
//
//  Created by 郑宇琦 on 2017/6/13.
//

import Foundation
import Pjango_Core

public func pjangoUserSetUrls() -> [PCUrlConfig] {
    
    return [
        
        pjangoUrl("", IndexView.self, "index"),
        pjangoUrl("time_zone", TimeZoneView.self, "time_zone"),
        
    ]
    
}

