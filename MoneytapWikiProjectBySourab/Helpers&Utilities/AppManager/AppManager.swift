//
//  MoneytapWikiProjectBySourabTests.swift
//  MoneytapWikiProjectBySourabTests
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit

enum serverTypeEnum: String {
    case serverTypeProd = "https://en.wikipedia.org//w/api.php?"
}

class AppManager: NSObject {
    static let sharedInstance = AppManager()
    
    let kServerType = serverTypeEnum.serverTypeProd
    let kParams = "action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description"
    let kSearchLimit = "&gpslimit=20"
    
    //Wiki Web Page url
    let kWikiPageUrl = "http://en.wikipedia.org/?curid="
    
    func getBaseURL() -> String? {
        WikiLog().print(kServerType.rawValue)
        return kServerType.rawValue
    }
    
    func getParameters() -> String? {
        return kParams
    }
    
    func getSearchLimit() -> String? {
        return kSearchLimit
    }
    
    func getWikiPageUrl() -> String {
        return kWikiPageUrl
    }
}
