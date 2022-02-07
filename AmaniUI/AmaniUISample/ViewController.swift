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
    
    @IBOutlet weak var lblEposta: UITextField!
    @IBOutlet weak var lblTelNo: UITextField!
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
        email = lblEposta.text
        phone = lblTelNo.text

    }
    override func viewDidLoad() {
		super.viewDidLoad()

        tcno.attributedPlaceholder = NSAttributedString(string: "ID Card Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblExpDate.attributedPlaceholder = NSAttributedString(string: "Expire Date: YYMMDD", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblBirthDate.attributedPlaceholder = NSAttributedString(string: "Birth Date: YYMMDD", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblDocNumber.attributedPlaceholder = NSAttributedString(string: "Document No", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblEposta.attributedPlaceholder = NSAttributedString(string: "E-Mail", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblTelNo.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

    }


}

