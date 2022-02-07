//
//  SelfieViewController.swift
//  AmaniUI
//
//  Created by Münir Ketizmen on 21.09.2021.
//

import UIKit
import AmaniSDK

class SelfieViewController: ViewControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        navBarType = .white
        needsNavBar = true
        let amani = Amani.sharedInstance
        do {
            amani.selfie().setType(type: documentTypes.Selfie.rawValue)
            let selfieVC = try amani.selfie().start { (previewImage) in
                DispatchQueue.main.async {
                    
                    let initilVC = PreviewVC(nibName:String(describing: PreviewVC.self),bundle:Bundle(for: PreviewVC.self))
                    initilVC.preImage = previewImage
                    initilVC.title = Resources.BiometrikDogrulamaTitle
                    initilVC.docType = documentTypes.Selfie.rawValue
                    initilVC.previewInfoText = Resources.BiometrikDogrulamaInfo
                    initilVC.previewHeaderText = Resources.BiometrikDogrulamaMessage
                    self.navigationController?.pushViewController(initilVC, animated: true)
                }
            }
            self.view.addSubview(selfieVC!)
        } catch {
            
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
