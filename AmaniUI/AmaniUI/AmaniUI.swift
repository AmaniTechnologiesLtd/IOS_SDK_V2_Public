//
//  Amani.swift
//  AmaniUI
//
//  Created by Münir Ketizmen on 30.07.2021.
//

import UIKit
import AmaniSDK
private class AmaniBundleLocator {}

public final class AmaniUI: NSObject {
    
    var parentVC:UIViewController?
    private var bundle: Bundle!
    public typealias cb = ((String) -> Void)
    public var completion:cb? = nil
    public var notOk:cb? = nil
    public var nviData:NviModel? = nil
    public var customerID:String? = nil
    /// This property represents the shared instance of SDK
    public static let sharedInstance = AmaniUI()
    public var server:String = ""
    public var token:String?
    public var username:String?
    public var password:String?
    public var customer: CustomerRequestModel?

    
    
    /**
     This method set up the SDK bundle
     
     */
    private func setBundle() {
        if let bundle = Bundle(path: "AmaniUI.bundle") {
            self.bundle = bundle
        } else if let path = Bundle(for: AmaniBundleLocator.self).path(forResource: "AmaniUI", ofType: "bundle"),
                  let bundle = Bundle(path: path)  {
            self.bundle = bundle
        } else {
            let bundle = Bundle(for: AmaniBundleLocator.self)
            self.bundle = bundle
        }
    }
    
    
    
    
    public func start(parentVC:UIViewController,server:String,token:String,customer:CustomerRequestModel, nviData:NviModel ,completion: @escaping (String) -> Void, notOk:@escaping (String)->Void ) {
        self.nviData = nviData
        self.parentVC = parentVC
        self.completion = completion
        self.notOk = notOk
        self.server = server
        self.token = token
        self.customer = customer
        let initilVC = PersonalInfoViewController(nibName:String(describing: PersonalInfoViewController.self),bundle:Bundle(for: PersonalInfoViewController.self))
        parentVC.navigationController?.pushViewController(initilVC, animated: true)

    }
    public func start(parentVC:UIViewController,server:String,username:String,password:String,customer:CustomerRequestModel, nviData:NviModel ,completion: @escaping (String) -> Void, notOk:@escaping (String)->Void ) {
        self.nviData = nviData
        self.parentVC = parentVC
        self.completion = completion
        self.notOk = notOk
        self.server = server
        self.token = nil
        self.username = username
        self.password = password
        self.customer = customer
        let initilVC = PersonalInfoViewController(nibName:String(describing: PersonalInfoViewController.self),bundle:Bundle(for: PersonalInfoViewController.self))
        parentVC.navigationController?.pushViewController(initilVC, animated: true)
        
    }
    /**
     This method used to get SDK bundle
     - returns: Bundle
     */
    func getBundle() -> Bundle {
        return self.bundle
    }
    
    public override init() {
        super .init()
        setBundle()
        UIFont.loadAllFonts(bundleIdentifierString: self.getBundle().bundleIdentifier!)
    }
    private func showView(initilVC:UIViewController){
        
        guard let navController = parentVC?.navigationController else {
            return
        }
        navController.pushViewController(initilVC, animated: true)
    }
}

