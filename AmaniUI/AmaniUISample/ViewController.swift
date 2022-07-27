//
//  ViewController.swift
//  AmaniDesignTemplate
//
//  Created by Münir Ketizmen on 26.07.2021.
//

import UIKit
import AmaniUI
import AmaniSDK

class ViewController: UIViewController {
    @IBOutlet weak var lblCity: UITextField!
    @IBOutlet weak var lblProvince: UITextField!
    @IBOutlet weak var lblAdres: UITextField!
    @IBOutlet weak var lblOccupation: UITextField!
    @IBOutlet weak var tcno: UITextField!
    @IBOutlet weak var lblBirthDate: UITextField!
    @IBOutlet weak var lblExpDate: UITextField!
    @IBOutlet weak var lblDocNumber: UITextField!
    @IBAction func btnContinue(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "otpPage", sender: nil)
            
        }
        tckn = tcno.text
        ExpDate = self.lblExpDate.text
        DocNumber = self.lblDocNumber.text
        BirthDate = self.lblBirthDate.text
        email = ""
        phone = ""

    }
    @IBAction func actDevam(_ sender: Any) {
        tckn = tcno.text
        ExpDate = self.lblExpDate.text
        DocNumber = self.lblDocNumber.text
        BirthDate = self.lblBirthDate.text
        email = ""
        phone = ""
        Province = self.lblProvince.text
        Adres = self.lblAdres.text
        Occupation = self.lblOccupation.text
        City = self.lblCity.text
        
        var customerInfo:[String] = [ ]
        customerInfo.append(Occupation ?? "")
        customerInfo.append(Adres ?? "")
        customerInfo.append(Province ?? "")
        customerInfo.append(City ?? "")
        
        let amaniUI = AmaniUI.sharedInstance
        let customer = CustomerRequestModel(name: "", email: email ?? "", phone: phone ?? "", idCardNumber: tckn!)
        let nviData = NviModel(documentNo: DocNumber ?? "", dateOfBirth: BirthDate ?? "" , dateOfExpire: ExpDate ?? "")
        //            amaniSDK.set(server: "https://demo.amani.ai", userName: "mobile_team@amani.ai", password: "vUcxPvfvP9rYUJ", customer:customer!,nvi: nvi,useGeoLocation: false,language: "tr")
      amaniUI.start(parentVC: self, server:"https://tr3.amani.ai", username: "videotest@btcturk.com", password: "vUcxPvfvP9rYUJ", customer: customer, nviData: nviData,customerInfo: customerInfo)
//        amaniUI.start(parentVC: self, server:"https://sandbox.amani.ai", username: "mobile_team@amani.ai", password: "vUcxPvfvP9rYUJ", customer: customer, nviData: nviData,customerInfo: customerInfo)
      { (CustomerID) in
            print(CustomerID)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "tebrikler", sender: nil)
                
            }
            
        } notOk: { (ProblemType) in
            switch ProblemType {
            case "kuryeCagir":
                print("kuryeCagirBasıldı")
                return
            case "permissionDenied":
                print("CameraPermissionDenied")
                return
            case "tokenError":
                print("tokenError")
                return
            default:
                return
            }
        }
    }
    override func viewDidLoad() {
		super.viewDidLoad()

        tcno.attributedPlaceholder = NSAttributedString(string: "ID Card Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblExpDate.attributedPlaceholder = NSAttributedString(string: "Expire Date: YYMMDD", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblBirthDate.attributedPlaceholder = NSAttributedString(string: "Birth Date: YYMMDD", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblDocNumber.attributedPlaceholder = NSAttributedString(string: "Document No", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblAdres.attributedPlaceholder = NSAttributedString(string: "Adres", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblCity.attributedPlaceholder = NSAttributedString(string: "Şehir", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblProvince.attributedPlaceholder = NSAttributedString(string: "Semt", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblOccupation.attributedPlaceholder = NSAttributedString(string: "Meslek", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        tcno.layer.borderWidth = 1
        tcno.layer.borderColor = UIColor.gray.cgColor
        lblCity.layer.borderWidth = 1
        lblCity.layer.borderColor = UIColor.gray.cgColor
        lblAdres.layer.borderWidth = 1
        lblAdres.layer.borderColor = UIColor.gray.cgColor
        lblProvince.layer.borderWidth = 1
        lblProvince.layer.borderColor = UIColor.gray.cgColor
        lblOccupation.layer.borderWidth = 1
        lblOccupation.layer.borderColor = UIColor.gray.cgColor
        lblExpDate.layer.borderWidth = 1
        lblExpDate.layer.borderColor = UIColor.gray.cgColor
        lblBirthDate.layer.borderWidth = 1
        lblBirthDate.layer.borderColor = UIColor.gray.cgColor
        lblDocNumber.layer.borderWidth = 1
        lblDocNumber.layer.borderColor = UIColor.gray.cgColor
    }


}

