//
//  UIColorExtension.swift
//  teksystems-exercise
//
//  Created by Gianni Settino on 2014-08-22.
//  Copyright (c) 2014 Milton and Parc. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorFromHex(hexString: String) -> UIColor {
        var result: CUnsignedInt = 0
        var scanner = NSScanner(string: hexString)
        // skip the # symbol
        scanner.scanLocation = 1
        scanner.scanHexInt(&result)
        
        var r = CGFloat((result & 0xFF0000) >> 16)/255
        var g = CGFloat((result & 0xFF00) >> 8)/255
        var b = CGFloat(result & 0xFF)/255
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    class func flatPumpkinColor() -> UIColor {
        return UIColor.colorFromHex("#d35400")
    }
    
    class func flatCarrotColor() -> UIColor {
        return UIColor.colorFromHex("#e67e22")
    }
    
    class func flatOrangeColor() -> UIColor {
        return UIColor.colorFromHex("#f39c12")
    }
    
    class func flatCloudsColor() -> UIColor {
        return UIColor.colorFromHex("#ecf0f1")
    }
    
    class func flatSilverColor() -> UIColor {
        return UIColor.colorFromHex("#bdc3c7")
    }
    
}
