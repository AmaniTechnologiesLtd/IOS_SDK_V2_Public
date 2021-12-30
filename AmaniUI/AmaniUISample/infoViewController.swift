//
//  infoViewController.swift
//  AmaniUISample
//
//  Created by Münir Ketizmen on 21.09.2021.
//

import UIKit
import AmaniUI
import AmaniSDK

class infoViewController: UIViewController {

    @IBOutlet weak var lblIsAdedi: UITextField!
    
    @IBOutlet weak var lblMalvarligi: UITextField!
    @IBOutlet var lblOrtalamaGelir: UITextField!
    @IBOutlet weak var lblIsHacmi: UITextField!
    @IBOutlet weak var lblJobType: UITextField!
    @IBOutlet weak var lblJob: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lblJob.attributedPlaceholder = NSAttributedString(string: "Job", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblJobType.attributedPlaceholder = NSAttributedString(string: "Job Type", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblIsAdedi.attributedPlaceholder = NSAttributedString(string: "Monthly Operations", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblIsHacmi.attributedPlaceholder = NSAttributedString(string: "Monthly Trading Volume", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblOrtalamaGelir.attributedPlaceholder = NSAttributedString(string: "Average Income", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        lblMalvarligi.attributedPlaceholder = NSAttributedString(string: "Asset / Sources of Funds", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }

    @IBAction func actDevam(_ sender: Any) {
        
        let amaniUI = AmaniUI.sharedInstance
        let customer = CustomerRequestModel(name: "", email: email ?? "", phone: phone ?? "", idCardNumber: tckn!)
        let nviData = NviModel(documentNo: DocNumber ?? "", dateOfBirth: BirthDate ?? "" , dateOfExpire: ExpDate ?? "")
        amaniUI.start(parentVC: self, server: "SERVER", username: "USERNAME", password: "PASSWORD", customer: customer, nviData: nviData){ (CustomerID) in
            print(CustomerID)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "tebrikler2", sender: nil)
                
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
