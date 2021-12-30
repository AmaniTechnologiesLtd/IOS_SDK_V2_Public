//
//  AnimationVC.swift
//  AmaniUI
//
//  Created by Münir Ketizmen on 3.08.2021.
//

import UIKit
import Lottie
import AmaniSDK
class AnimationVC: ViewControllerBase {
    var animationView:AnimationView?
    var side:Int = 0
    typealias cb = ()->()
    var callback:cb? = nil
    var viewContainer:UIView?
    var step:steps = .front
    let croptimeout = 15
    var oldTitle:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navBarType = .white
        needsNavBar = true
        var animationType = "trfront"
        switch side {
        case 0 :
            animationType = "trfront"
            step = .front
            
        case 1:
            animationType = "trback"
            step = .back
            
        default:
            return
        }
        
        lottieInit(name: animationType, completion: callback)
    }
    @objc func selectorFunc() {
        self.title = "Kimlik Fotoğrafını Çek"
    }
    private func lottieInit(name:String = "trfront", completion:(()->())?) {

        animationView = AnimationView(name: name, bundle: AmaniUI.sharedInstance.getBundle())
        animationView!.frame = view.bounds
        animationView!.backgroundColor = .clear
        view.addSubview(animationView!)
        animationView!.play {[weak self] (_) in
            self?.animationView!.removeFromSuperview()
            do {
                let amani = Amani.sharedInstance
                let idcapture = amani.IdCapture()
                idcapture.setManualCropTimeout(Timeout: self?.croptimeout ?? 15)
                idcapture.setType( type: documentTypes.TurkishIdNew.rawValue)
                guard let step = self?.step else {return}
                guard let idcaptureVC:UIView = try idcapture.start(stepId:step.rawValue,completion: { [weak self](previewImage) in
                    DispatchQueue.main.async {
                        self?.viewContainer?.removeFromSuperview()
                        self?.viewContainer = nil
                        let initilVC = PreviewVC(nibName:String(describing: PreviewVC.self),bundle:Bundle(for: PreviewVC.self))
                        initilVC.preImage = previewImage
                        initilVC.docType = documentTypes.TurkishIdNew.rawValue
                        initilVC.side = self?.step.rawValue
                        initilVC.title = Resources.KimlikOnayTitle
                        initilVC.previewInfoText = Resources.KimlikOnayInfo
                        initilVC.previewHeaderText = Resources.KimlikOnayMessageOn
                        self?.navigationController?.pushViewController(initilVC, animated: true)
                    }
                }) else {return}
                self?.viewContainer = idcaptureVC
                let manualcropTimer = Timer.scheduledTimer(timeInterval: Double(self!.croptimeout), target: self!, selector: #selector(self!.selectorFunc), userInfo: nil, repeats: false)
                DispatchQueue.main.async {
                    self?.view.addSubview(idcaptureVC)
                }
                
            }
            catch  {
                print("Unexpected error: \(error).")
                
            }
            if completion != nil {
                completion!()
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
