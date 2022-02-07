//
//  UITextField+Extensions.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation
import UIKit

@IBDesignable
extension UITextField{
    
    @IBInspectable var cornerRadius: Int {
        get{
            return self.cornerRadius
        }
        set(radius){
            self.layer.cornerRadius = CGFloat(radius)
            self.clipsToBounds = true
            
            // border color
            self.layer.borderColor = #colorLiteral(red: 0.322735548, green: 0.3377646804, blue: 0.354604125, alpha: 1)
        }
    }
    
    @IBInspectable var paddingLeft: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRight: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
}
