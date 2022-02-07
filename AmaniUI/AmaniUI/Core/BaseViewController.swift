//
//  BaseViewController.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var timeoutInSeconds: TimeInterval = 1*30
    var second = 0
    var oldTimer: Timer?
    var isUserAction = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        defaultNavigationUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Analytic send name: " + (self.title ?? ""))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func defaultNavigationBarColor() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.964045465, green: 0.9891164899, blue: 1, alpha: 1)
    }
    
    func detailNavigationBarColor() {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.964045465, green: 0.9891164899, blue: 1, alpha: 1)
    }
    
    func defaultNavigationUI() {
        
        self.navigationController!.navigationBar.barTintColor = Color.white
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.layer.borderWidth = 0.0
        self.navigationController!.navigationBar.layer.borderColor = UIColor.clear.cgColor
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "Ubuntu", size: 17), size: 17)]
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = Color.shadowGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 2
        
    }
    
 
    
    func setGradientBackground(feature: Features, withLogo: Bool) {
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        
        let gradientColor = GradientColor.getFeatureColors(feature: feature)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        gradient.colors = [
            gradientColor.StartColor,
            gradientColor.EndColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 1, y: 0.92)
        gradient.endPoint = CGPoint(x: 0.02, y: 0.02)
        layer.layer.addSublayer(gradient)
        
        self.view.insertSubview(layer, at: 0)
        
        if withLogo {
            let image = UIImage(named: "backgroundNlogo")
            let imageView = UIImageView(image: image)
            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            let xC = (self.view.frame.width - imageView.frame.size.width)
            let yC = (self.view.frame.height / 3) - (imageView.frame.size.height / 2)
            imageView.frame = CGRect(x: xC, y: yC, width: imageView.frame.size.width, height: imageView.frame.size.height)
            self.view.insertSubview(imageView, at: 1)
        }
    }

}
