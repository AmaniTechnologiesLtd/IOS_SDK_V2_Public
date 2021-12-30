//
//  UIViewController.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit


extension UIViewController {
    
    func addViewController(viewController: UIViewController, to view: UIView? = nil) {
        addChild(viewController)
        viewController.view.frame = (view?.bounds)!
        view?.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}


