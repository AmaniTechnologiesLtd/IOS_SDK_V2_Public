//
//  BaseViewController.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

enum NavBarTintType {
    case dark
    case white
}

public class ViewControllerBase: UIViewController, UIGestureRecognizerDelegate {
    
    var viewModel: BaseViewModel!
    
    var navBarType: NavBarTintType = .white {
        didSet {
            setNavBarTint(barTint: navBarType)
            setBackButton()
        }
    }
    
    var needsNavBar: Bool {
        set {
            self.navigationController?.setNavigationBarHidden(!newValue, animated: true)
            if newValue {
                defaultNavigationUI()
                needsBarLogo = false
            }else {
                self.navigationItem.setBackButtonType(buttonType: .hidden)
            }
        }
        get {
            return (self.navigationController?.isNavigationBarHidden)!
        }
    }
    
    var needsNavigationBarBottomLine = true
    var isAutomaticLoggingEnabled = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewModel = BaseViewModel()
        
        setBackButton()
    }
    
    init(nibName:String,bundle:Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
    }
    public override func viewDidLoad() {
        super .viewDidLoad()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        needsNavBar = true
        setupSwipeToBackFeature()
    }
    
    func setupSwipeToBackFeature() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func defaultNavigationUI() { 
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.layer.borderWidth = 0.0
        self.navigationController?.navigationBar.layer.borderColor = UIColor.clear.cgColor
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationItem.titleView?.accessibilityIdentifier = "CommonTitle"
    }
    
    func setNavBarTint(barTint: NavBarTintType) {
        if barTint == .white {
            UINavigationBar.appearance().tintColor = Theme.Color.white
			self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: Theme.Font.headerTitleBlack,
                NSAttributedString.Key.foregroundColor: Theme.Color.white]
            setNeedsStatusBarAppearanceUpdate()
        }
        else if barTint == .dark {
            UINavigationBar.appearance().tintColor = Theme.Color.dark
            self.navigationController?.navigationBar.barTintColor = Theme.Color.dark
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: Theme.Font.headerTitleBlack,
                NSAttributedString.Key.foregroundColor: Theme.Color.dark]
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return navBarType == .dark ? .default : .lightContent
    }
    
    public override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @objc func backAction() {
        _ = navigationController?.popViewController(animated: true)
        // do your stuff if you needed
    }
    
    var needsBarLogo: Bool = false {
        didSet {
            if needsBarLogo {
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 56, height: 19))
                imageView.accessibilityIdentifier = "AmaniBarLogo"
                imageView.contentMode = .scaleAspectFit
                let logo = UIImage(named: "AmaniLogoWhite")?.resizeImage(CGFloat(96), opaque: false)
                imageView.image = logo
                self.navigationItem.titleView = imageView
            }
        }
    }
    
    
    func setBackButton() {
        if self.isModal() {
            self.navigationItem.setBackButtonType(buttonType: .close, tintType: self.navBarType, target: self, action: #selector(closeViewController))
        }else {
            self.navigationItem.setBackButtonType(buttonType: .back, tintType: self.navBarType, target: self, action: #selector(closeViewController))
        }
    }
    
    
    
    @objc func closeViewController() {
        if self.isModal() {
            self.dismiss(animated: true, completion: nil)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: Swipe to back function
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if navigationItem.backButtonType == UINavigationItem.BarButtonDisplayType.hidden {
            return false
        }
        
        return true
    }
}
