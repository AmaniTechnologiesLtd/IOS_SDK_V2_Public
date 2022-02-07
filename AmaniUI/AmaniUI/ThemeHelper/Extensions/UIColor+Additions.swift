//
//  UIColor+Additions.swift
//  N Kolay App UI Design - 1. Faz
//
//  Generated on Zeplin. (9/24/2019).
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

import UIKit

extension UIColor {
    
    @nonobjc class var ceruleanBlue: UIColor {
        return Theme.Color.ceruleanBlue
    }
    
    @nonobjc class var hotPink: UIColor {
        return Theme.Color.hotPink
    }
    
    @nonobjc class var pinkyRed: UIColor {
        return Theme.Color.pinkyRed
    }
    
    @nonobjc class var butterscotch: UIColor {
        return Theme.Color.butterscotch
    }
    
    @nonobjc class var darkishBlue: UIColor {
        return Theme.Color.darkishBlue
    }
    
    @nonobjc class var white: UIColor {
        return Theme.Color.white
    }
    
    @nonobjc class var dark: UIColor {
        return Theme.Color.dark
    }
    
    @nonobjc class var charcoalGrey: UIColor {
        return Theme.Color.charcoalGrey
    }
    
    @nonobjc class var blueyGrey: UIColor {
        return Theme.Color.blueyGrey
    }
    
    @nonobjc class var lightGreyBlue: UIColor {
        return Theme.Color.lightGreyBlue
    }
    
    @nonobjc class var veryLightBlue: UIColor {
        return Theme.Color.veryLightBlue
    }
    
    @nonobjc class var paleGrey: UIColor {
        return Theme.Color.paleGrey
    }
    
    @nonobjc class var cloudyBlue: UIColor {
        return Theme.Color.cloudyBlue
    }
    
    @nonobjc class var cloudyBlueTwo: UIColor {
        return Theme.Color.cloudyBlueTwo
    }
    
    @nonobjc class var orangeyYellow: UIColor {
        return Theme.Color.orangeyYellow
    }
    
    @nonobjc class var slateGrey: UIColor {
        return Theme.Color.slateGrey
    }
    
    func toHex() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}
