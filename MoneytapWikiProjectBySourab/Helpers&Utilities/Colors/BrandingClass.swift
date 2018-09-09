//
//  MoneytapWikiProjectBySourabTests.swift
//  MoneytapWikiProjectBySourabTests
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

import UIKit

class BrandingClass: NSObject {
    
    //MARK: - Color Methods
    static let lightBlackColor = "#878DA0"
    static let darkBlackColor = "#5C6275"
    
    static let lightTextColor
        = "#E2F3FA"
    static let darkTextColor = "#AAC7DD"
    
    static let cellAlternativeColor = "#F0F9FC"
    static let backgroundColor = "#FFFFFF"
    
    class func getLightBlackColor() -> UIColor {
        return hexStringToUIColor(hex: lightBlackColor)
    }
    
    class func getDarkBlackColor() -> UIColor {
        return hexStringToUIColor(hex: darkBlackColor)
    }
    
    class func getLightTextColor() -> UIColor {
        return hexStringToUIColor(hex: lightTextColor)
    }
    
    class func getDarkTextColor() -> UIColor {
        return hexStringToUIColor(hex: darkTextColor)
    }
    
    class func getCellAlternativeColor() -> UIColor {
        return hexStringToUIColor(hex: cellAlternativeColor)
    }
    
    class func getBackgroundColor() -> UIColor {
        return hexStringToUIColor(hex: backgroundColor)
    }
    
    //MARK: - Color Convertion
    //This method gives the UIcolor from hex color with Alpha
    static func hexStringToUIColor(hex: String, alpha: Float) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    //This method gives the UIcolor from hex color
    static func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor (
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
