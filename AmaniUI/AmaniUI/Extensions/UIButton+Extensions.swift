//
//  UIButton+Extensions.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation
import UIKit

extension UIButton {
    
    @IBInspectable var cornerRadius: Int{
        get{
            return self.cornerRadius
        }
        set(radius){
            self.layer.cornerRadius = CGFloat(radius)
            self.clipsToBounds = true
        }
    }
    
    @IBInspectable var customFont: UIFontDescriptor {
        get{
            return (self.titleLabel?.font.fontDescriptor)!
        }
        
        set(descriptor) {
            self.titleLabel?.font = UIFont(descriptor: descriptor, size: 18)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func alignImageRight() {
        if UIApplication.shared.userInterfaceLayoutDirection == .leftToRight {
            semanticContentAttribute = .forceRightToLeft
        }
        else {
            semanticContentAttribute = .forceLeftToRight
        }
    }
    
    func allowTextToScale(minFontScale: CGFloat = 0.5, numberOfLines: Int = 1) {
           self.titleLabel?.adjustsFontSizeToFitWidth = true
           self.titleLabel?.minimumScaleFactor = minFontScale
           self.titleLabel?.lineBreakMode = .byTruncatingTail
           self.titleLabel?.numberOfLines = numberOfLines
       }
}
