//
//  InnLiHandler.swift
//  filterStickers
//
//  Created by ylun on 2021//10/9.
//  Copyright © 2021 yelun. All rights reserved.
//

import UIKit
import WebKit

class InnLiHandler: NSObject {
    class func clearWebCache () {
        
        let storage:HTTPCookieStorage = HTTPCookieStorage.shared
        for cookie in storage.cookies ?? [] {
            storage.deleteCookie(cookie)
        }
     
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
}
