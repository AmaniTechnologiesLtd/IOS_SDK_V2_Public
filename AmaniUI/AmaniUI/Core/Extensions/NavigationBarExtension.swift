//
//  NavigationBarExtension.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit


extension UINavigationItem {
    enum BarButtonDisplayType {
        case hidden
        case back
        case close
    }
    
    var backButtonType: BarButtonDisplayType {
        set {
            setBackButtonType(buttonType: newValue)
        }
        get {
            if self.leftBarButtonItem == nil {
                return .hidden
            }else if (self.leftBarButtonItem as! UIBarButtonItem).accessibilityIdentifier == "BackButton" {
                return .back
            }else {
                return .close
            }
        }
    }
    
    
    func setBackButtonType(buttonType: BarButtonDisplayType, tintType: NavBarTintType = .dark, target: Any? = nil, action: Selector? = nil)  {
        
        let tintColor = tintType == .dark ? Theme.Color.dark : Theme.Color.white
        
        switch buttonType {
        case .hidden:
            self.hidesBackButton = true
            self.leftBarButtonItem = nil
        case .back:
            self.hidesBackButton = true
            let button = UIBarButtonItem(image: UIImage(named: "pinLeft")?.setTint(color: tintColor), style: .plain, target: target, action: action)
            button.accessibilityIdentifier = "BackButton"
            button.tintColor = tintColor
            self.leftBarButtonItem = button
        case .close:
            self.hidesBackButton = true
            let button = UIBarButtonItem(image: UIImage(named: "close")?                                                                                                                                                                                                     .setTint(color: tintColor) , style: .plain, target: target, action: action)
            button.tintColor = tintColor
            button.accessibilityIdentifier = "CloseButton"
            self.leftBarButtonItem = button
        }
    }
}
