//
//  UIViewControllerExtension.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

extension UIViewController {
    
    func isModal() -> Bool {
        
        if let navigationController = self.navigationController{
            if navigationController.viewControllers.first != self{
                return false
            }
        }
        
        if self.presentingViewController != nil {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        }
        
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    
    func removeOtherChildren<T: UIViewController>(then viewControllerType: T.Type) {
        self.children.filter({ (viewController) -> Bool in
            return !(viewController is T)
        }).forEach { (viewController) in
            viewController.removeFromParent()
        }
    }
}

