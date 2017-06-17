//
//  Urls.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation
import Pjango_Core
import Pjango_Demo

internal func _pjango_runtime_setUrls() {
    
    _pjango_user_setUrls()
    
    urlpatterns.forEach { config in
        _pjango_core_runtime_urls_url2config[config.url] = config
        if let name = config.name {
            _pjango_core_runtime_urls_name2config[name] = config
        }
    }
}
