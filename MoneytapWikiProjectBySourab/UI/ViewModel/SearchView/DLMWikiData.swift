//
//  DLMWikiData.swift
//  MoneytapWikiProjectBySourab
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit

class DLMWikiData: NSObject {
    
    var wikiDataModelDetails : WikiDataModel?
    
    // MARK: - calling Webservice
    func callWikiAPI(withSearchText: String, successBlock:@escaping ((AnyObject) -> Void), failureBlock:@escaping ((AnyObject) -> Void)) {
        let wikiWebservice = WikiWebService()
        wikiWebservice.getWikiDetailsWithEndPointUrl(endPointUrl: withSearchText,
                                                        SuccessBlock: { (responseObj:AnyObject) in
                                                                                                                        let wikiModel = responseObj as! WikiDataModel
                                                                                                                        self.saveWikiModelData(withWikiModel: wikiModel)
                                                            DispatchQueue.main.async {
                                                                WikiLog().print(responseObj)
                                                                successBlock(responseObj as AnyObject);
                                                            }
        },
                                                        failureBlock: { (responseObj:AnyObject) in
                                                            DispatchQueue.main.async {
                                                                if let failureMessage = responseObj as? String {
                                                                        failureBlock(failureMessage as AnyObject);
                                                                }
                                                            }
        }
        )
    }
    
    //MARK: - Saving data
    func saveWikiModelData(withWikiModel: WikiDataModel) {
        wikiDataModelDetails = withWikiModel
    }
    
    //MARK: -Data Related Methods
    func getAllWikiPages() -> [Page]? {
        if let wikiPages = wikiDataModelDetails?.query?.pages {
            let sortData = wikiPages.sorted(by: { ($0.title?.lowercased() as String?) ?? "" < ($1.title?.lowercased() as String?) ?? ""})
            return sortData
        }
        return nil
    }
}
