//
//  KuryeCagirVC.swift
//  AmaniUI
//
//  Created by Münir Ketizmen on 31.07.2021.
//

import Foundation
import UIKit
import AmaniSDK
import AVFoundation

class KuryeCagirVC: ViewControllerBase {
    let amani = Amani.sharedInstance
    @IBOutlet weak var lblBankInfo: UILabel!
    @IBOutlet weak var lblKuryeInfo: UILabel!
    @IBOutlet weak var lblErrorMessage: UILabel!

    @IBOutlet weak var roundedTopView: RoundedTopView!
    

    fileprivate func startIdCapture() {
//        do {
//            let idCapture = amani.IdCapture()
//            idCapture.setType( type: documentTypes.TurkishIdNew.rawValue)
//            
//            guard let IdCapture:UIViewController = try idCapture.start(stepId: .front, completion: { (previewImage) in
//                DispatchQueue.main.async {
//                    
//                    let initilVC = PreviewVC(nibName:String(describing: PreviewVC.self),bundle:Bundle(for: PreviewVC.self))
//                    initilVC.preImage = previewImage
//                    initilVC.docType = documentTypes.TurkishIdNew.rawValue
//                    initilVC.side = steps.front.rawValue
//                    initilVC.title = Resources.KimlikOnayTitle
//                    initilVC.previewInfoText = Resources.KimlikOnayInfo
//                    initilVC.previewHeaderText = Resources.KimlikOnayMessageOn
//                    self.navigationController?.pushViewController(initilVC, animated: true)
//                }
//            }) else {return}
//            self.navigationController?.pushViewController(try IdCapture, animated: true)
//            
//        } catch {
//            
//        }
    }
    
    
    func startAnimation(){
        let initilVC = AnimationVC(nibName: String(describing: AnimationVC.self), bundle: Bundle(for: AnimationVC.self))
        initilVC.side = steps.front.rawValue
        initilVC.title = Resources.KimlikTaramaTitle
//        initilVC.callback = startIdCapture
        self.navigationController?.pushViewController(initilVC, animated: false)
    }
    
    
    @IBAction func btnContinue(_ sender: Any) {
        checkCameraPermission()
    }
    
    @IBAction func btnKuryeCagir(_ sender: Any) {
        guard let notOk = AmaniUI.sharedInstance.notOk else { return  }
        notOk("kuryeCagir")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func checkCameraPermission() {
        let cameraPermission = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraPermission {
        case .authorized:
            startAnimation()
            return
        case .denied,.restricted:
            guard let notOk = AmaniUI.sharedInstance.notOk else { return  }
            notOk("permissionDenied")
            self.navigationController?.popToRootViewController(animated: true)

            return
        case .notDetermined:
            print("notdetermined")
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] (granted: Bool) in
                DispatchQueue.main.async { [weak self] in
                    if granted {
                        self?.startAnimation()
                    } else {
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                }
            })
            return
        @unknown default:
            return
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Resources.KuryeCagirTitle
        self.view.setGradientBackground(feature: .Login)
        
        var attributedString = NSMutableAttributedString(string: Resources.KuryeCagirBankaInfo)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 9
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lblBankInfo.attributedText = attributedString
        lblBankInfo.font = Theme.Font.listTypeDescription
        
        attributedString = NSMutableAttributedString(string: Resources.KuryeCagirKuryeInfo)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        lblKuryeInfo.attributedText = attributedString
        lblKuryeInfo.font = Theme.Font.listTypeDescription
    
        lblErrorMessage.textColor = Theme.Color.ErrorGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarType = .white
        needsNavBar = true
    }
    
    
}
