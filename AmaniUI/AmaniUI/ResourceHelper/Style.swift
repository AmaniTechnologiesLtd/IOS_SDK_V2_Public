//
//  Style.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

enum Color {
    
    static let navBarEnd = UIColor(r: 204, g: 37, b: 58)
    static let navBarBegin = UIColor(r: 151, g: 28, b: 44)
    static let stepBar = UIColor(r: 204, g: 37, b: 58)
    static let red = UIColor(r: 204, g: 37, b: 58)
    static let green = UIColor(r: 16, g: 177, b: 96)
    static let gray = UIColor(r: 167, g: 168, b: 173)
    static let mediumGray = UIColor(r: 201, g: 201, b: 201)
    static let lightGray = UIColor(r: 245, g: 246, b: 249)
    static let borderGray = UIColor(r: 221, g: 221, b: 221)
    static let shadowGray = UIColor(r: 224, g: 224, b: 224)
    static let black = UIColor(r: 88, g: 88, b: 91)
    static let lightWhite = UIColor(r: 231, g: 231, b: 231)
    static let white = UIColor(r: 255, g: 255, b: 255)
    static let border = UIColor(r: 221, g: 221, b: 221)
    static let placeHolder = UIColor(r: 189, g: 195, b: 199)
    
    static let menuTintColor = UIColor(r: 0, g: 117, b: 235)
    static let blueTextColor = UIColor(r: 11, g: 120, b: 227)
    static let blackTextColor = UIColor(r: 22, g: 24, b: 35)
    static let blueBorderColor = UIColor(r: 107, g: 167, b: 228)
    static let grayTextColor = UIColor(r: 83, g: 86, b: 90)
    static let blueButtonColor = UIColor(r: 98, g: 181, b: 229)
    static let purpleButtonColor = UIColor("#eb008d")
    static let grayBackgroundColor = UIColor(r: 249, g: 249, b: 249)
    
    static let blueStartColor = UIColor(red:0,green:0.46,blue:0.92,alpha:1).cgColor
    static let blueEndColor = UIColor(red:0.38, green:0.15, blue:1, alpha:1).cgColor
    
    static let greenStartColor = UIColor(red:0, green:0.91, blue:0.76, alpha:1).cgColor
    static let greenEndColor = UIColor(red:0.01, green:0.5, blue:0.2, alpha:1).cgColor
    
    static let orangeStartColor = UIColor(red:1, green:0.58, blue:0.06, alpha:1).cgColor
    static let orangeEndColor = UIColor(red:0.99, green:0.21, blue:0.06, alpha:1).cgColor
    
    
    static let navbarMessageColor = UIColor(r: 227, g: 226, b: 234)
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat , b: CGFloat , a: CGFloat = 1.0) {
        let divider: CGFloat = 255
        self.init(red: r/divider, green: g/divider, blue: b/divider, alpha: a)
    }
}
