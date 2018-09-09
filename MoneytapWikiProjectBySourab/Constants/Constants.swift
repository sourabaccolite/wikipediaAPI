//
//  MoneytapWikiProjectBySourabTests.swift
//  MoneytapWikiProjectBySourabTests
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    //MARK: -ScreenTitles
    static let searchVCTitle = "Wikipedia"
    
    //MARK: -TableViewCell Identifier
    static let wikiDataTableViewCellIdentifier = "WikiDataTableViewCell"
    
    //StatusCodes
    static let statusCodeSuccess = 200
    
    //MARK: -alertMessages
    static let messageTitle = "Message"
    static let erorTitle = "Error"
    static let oopsTitle = "Oops!"
    static let sorryTitle = "Sorry!"
    static let logoutTitle = "Logout"
    
    static let alertOkActionTitle = "Ok"
    static let alertCancelActionTitle = "Cancel"
    static let alertLogoutActionTitle = "Logout"
    static let alertOpenActionTitle = "Open"
    
    static let noInternetMessage = "Please check your internet connection!!"
    static let genericFailureMessage = "Uh oh, seems like some network issue. Please try again in a short while."
}

class WikiLog {
    func print(_ message: Any, function: String = #function) {
        #if DEBUG
            Swift.print("\(function):\n \(message)")
        #endif
    }
}
