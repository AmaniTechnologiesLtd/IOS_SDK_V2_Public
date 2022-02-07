//
//  UINavigationControllerExtension.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation
import UIKit

extension UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    func popBackToViewController(viewController: UIViewController?) -> Bool {
        if let viewController = viewController,
			self.viewControllers.contains(viewController) {
            self.popToViewController(viewController, animated: true)
            return true
        }
        
        return false
    }
}

