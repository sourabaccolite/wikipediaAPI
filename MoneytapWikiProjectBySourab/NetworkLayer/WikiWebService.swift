//
//  WikiWebService.swift
//  MoneytapWikiProjectBySourab
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit

class WikiWebService: NSObject {
    
    func getWikiDetailsWithEndPointUrl(endPointUrl: String, SuccessBlock: @escaping((AnyObject) -> Void), failureBlock: @escaping((AnyObject) -> Void)) {
        guard let baseURL = AppManager.sharedInstance.getBaseURL() else {
            return
        }
        
        let parameters = AppManager.sharedInstance.getParameters()
        let srchLimit = AppManager.sharedInstance.getSearchLimit()
        
        let finalURL = baseURL + parameters! + "&gpssearch=" + endPointUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + srchLimit!
        
        let wikiReqUrl = URL(string: finalURL)
        WikiLog().print("Final Url :: \(String(describing: wikiReqUrl))")
        
        var wikiURLRequest = URLRequest(url: wikiReqUrl!)
        wikiURLRequest.httpMethod = "Get"
        wikiURLRequest.timeoutInterval = 60
        let task = URLSession.shared.dataTask(with: wikiURLRequest, completionHandler: { (data, response, err) in
            do {
                if let responseData : Data = data, let responseObj = response as? HTTPURLResponse {
                    WikiLog().print("StatusCode:\(responseObj.statusCode)")
                    let statusCode = responseObj.statusCode
                    if statusCode == Constants.statusCodeSuccess {
                        let jsonString : String = String(data: responseData, encoding: .utf8)!
                        WikiLog().print(jsonString)
                        let wikiModelData = try WikiDataModel(jsonString)
                        DispatchQueue.main.async {
                            SuccessBlock(wikiModelData as AnyObject)
                        }
                    } else {
                        DispatchQueue.main.async {
                            let failure = "Failure"
                            failureBlock(failure as AnyObject)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        let failure = "Failure"
                        failureBlock(failure as AnyObject)
                    }
                }
                return
            } catch {
                DispatchQueue.main.async {
                    let failure = "Failure"
                    failureBlock(failure as AnyObject)
                }
            }
            
        }
        )
        task.resume()
    }
}
