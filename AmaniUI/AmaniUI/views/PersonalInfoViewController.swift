//
//  CustomerInfoViewController.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import AmaniSDK
import UIKit
import JGProgressHUD


class PersonalInfoViewController: ViewControllerBase {
    @IBOutlet weak var errorView: RoundedTopView!
    @IBOutlet weak var effectView: UIView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var roundedTopView: RoundedTopView!
    @IBOutlet weak var lblErrorTitle: UILabel!
    @IBOutlet weak var lblErrorInfo: UILabel!
    
    let amani = Amani.sharedInstance
    var attempt:Int = 0
    let maxAttempt:Int = 3
    let activityIndicator = JGProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Resources.KimlikTaramaTitle
        self.view.setGradientBackground(feature: .Login)
        let attributedString = NSMutableAttributedString(string: Resources.KimlikTaramaInfo)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        lblInfo.attributedText = attributedString
        lblInfo.font = Theme.Font.listTypeDescription
        
        if let token:String = AmaniUI.sharedInstance.token {
            print("Logged in via Token")
            amani.initAmani(server: AmaniUI.sharedInstance.server, token: token, customer: AmaniUI.sharedInstance.customer!, useGeoLocation: false, language: "tr"){ cmModel, error in
                if let error:NetworkError = error {
                    guard let notOk = AmaniUI.sharedInstance.notOk else { return }
                    notOk("token Error")
                    self.navigationController?.popViewController(animated: true)
                }
                guard let cmModel:CustomerResponseModel = cmModel else {return}
                AmaniUI.sharedInstance.customerID = String(cmModel.id!)
                print(cmModel.id)
            }
        } else {
            print("Logged in via login info")
            guard let username:String = AmaniUI.sharedInstance.username else {
                print("username cannot be nil")
                return  }
            guard let password = AmaniUI.sharedInstance.password else {
                print("password cannot be nil")
                return  }
            amani.initAmani(server: AmaniUI.sharedInstance.server, userName: username, password: password, customer: AmaniUI.sharedInstance.customer!,useGeoLocation: false) { (cmModel, error) in
                if let error:NetworkError = error {
                    guard let notOk = AmaniUI.sharedInstance.notOk else { return }
                    notOk("login Error")
                    self.navigationController?.popViewController(animated: true)
                }
                guard let cmModel:CustomerResponseModel = cmModel else {return}
                AmaniUI.sharedInstance.customerID = String(cmModel.id!)
                print(cmModel.id)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarType = .white
        needsNavBar = true
    }
    
    @IBAction func btnContinueToID(_ sender: Any) {
        let initilVC = KuryeCagirVC(nibName:String(describing: KuryeCagirVC.self),bundle:Bundle(for: KuryeCagirVC.self))
        self.navigationController?.pushViewController(initilVC, animated: true)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        if #available(iOS 13, *) {
            do {

                guard let nvi:NviModel = AmaniUI.sharedInstance.nviData else {
                    print(AmaniUI.sharedInstance.nviData)
                    return

                }
                amani.scanNFC().setType(type: documentTypes.TurkishIdNew.rawValue)
                if (attempt < maxAttempt){
                    try amani.scanNFC().start(nviData: nvi ) { (req,error) in
                        if let req:NFCRequest = req  {
                            DispatchQueue.main.async {
                                self.activityIndicator.show(in: self.view)
                            }
                            self.amani.scanNFC().upload(location: nil) { (result, err) in
                                DispatchQueue.main.async {
                                    self.activityIndicator.dismiss()
                                }
                                if (result!) {
                                    let initilVC = SelfieViewController(nibName: String(describing: SelfieViewController.self), bundle: Bundle(for: SelfieViewController.self))
                                    initilVC.title = Resources.KimlikTaramaTitle
                                    //        initilVC.callback = startIdCapture
                                    self.navigationController?.pushViewController(initilVC, animated: false)
                                } else {
                                    DispatchQueue.main.async {
                                        self.showError(title: Resources.KimlikTaramaNFCErrorTitle, info: Resources.KimlikTaramaNFCErrorMessage)
                                    }
                                }
                            }
                        } else {
                            self.attempt += 1
                        }
                        print(self.attempt)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showError(title: Resources.KimlikTaramaNFCErrorTitle, info: Resources.KimlikTaramaNFCErrorMessage)
                    }
                }
            } catch {
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func startAnimation(){
        let initilVC = AnimationVC(nibName: String(describing: AnimationVC.self), bundle: Bundle(for: AnimationVC.self))
        initilVC.side = steps.front.rawValue
        initilVC.title = Resources.KimlikTaramaTitle
        //        initilVC.callback = startIdCapture
        self.navigationController?.pushViewController(initilVC, animated: false)
    }

    func showError(title:String, info:String) {
        
        lblErrorTitle.text = title
        lblErrorTitle.font = Theme.Font.listTypeFeatured
        let attributedString = NSMutableAttributedString(string: info)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9 // Whatever line spacing you want in points
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        lblErrorInfo.attributedText = attributedString
        lblErrorInfo.font = Theme.Font.listTypeDescription
        
        effectView.isHidden = false
        errorView.isHidden = false
    }
}

