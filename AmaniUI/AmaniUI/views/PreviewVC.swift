//
//  PreviewVC.swift
//  AmaniUI
//
//  Created by Münir Ketizmen on 31.07.2021.
//

import AmaniSDK
import JGProgressHUD
import UIKit
import SafariServices

class PreviewVC: ViewControllerBase {

  @IBOutlet weak var roundedTopView: RoundedTopView!

  @IBOutlet weak var lblErrorTitle: UILabel!
  @IBOutlet weak var lblErrorInfo: UILabel!
  @IBOutlet weak var errorView: RoundedTopView!
  @IBOutlet weak var effectView: UIView!
  @IBOutlet weak var lblMessage: UILabel!
  @IBOutlet weak var imgPreview: UIImageView!
  let activityIndicator = JGProgressHUD()

  @IBOutlet weak var lblPreviewInfo: UILabel!
  let amani = Amani.sharedInstance
  var preImage: UIImage?
  var previewInfoText: String?
  var previewHeaderText: String?
  var docType: String?
  var side: steps.RawValue?
  let maxSelfieAttempt = 3
  let maxIdCardAttempt = 3

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.setGradientBackground(feature: .Login)
    guard let preImage = preImage else {
      return
    }
    lblPreviewInfo.text = previewInfoText
    lblMessage.text = previewHeaderText
    imgPreview.image = preImage
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navBarType = .white
    needsNavBar = true

  }

  @IBAction func continueButtonTapped(_ sender: Any) {
    activityIndicator.show(in: view)
    do {
      switch docType {
      case documentTypes.Selfie.rawValue:
        let selfie = self.amani.selfie()
        selfie.upload(location: nil) { result, error in
          guard let result = result else { return }
          if result {
              do{
                  let sfView:SFSafariViewController = try  self.amani.videoCall().start() as! SFSafariViewController
                  sfView.delegate = self
                  DispatchQueue.main.async {
                      self.navigationController?.isNavigationBarHidden = true
                    self.navigationController?.pushViewController(sfView, animated: false)
                  }
              } catch {
                  
              }


          } else {
            print(result)
            DispatchQueue.main.async {
              if self.maxSelfieAttempt == currentSelfieAttempt {
                self.showError(
                  title: Resources.BiometrikDogrulamaMaxErrorTitle,
                  info: Resources.BiometrikDogrulamaMaxErrorInfo)
              } else {
                currentSelfieAttempt += 1
                print(currentSelfieAttempt)
                guard let bberror: [AmaniError] = error else { return }
                let manyfaceError = bberror.filter({ $0.error_code == 2004 })
                if manyfaceError.count > 0 {
                  self.showError(
                    title: Resources.BiometrikDogrulamaMultipleFaceTitle,
                    info: Resources.BiometrikDogrulamaMultipleFaceInfo)
                } else {
                  self.showError(
                    title: Resources.BiometrikDogrulamaErrorTitle,
                    info: Resources.BiometrikDogrulamaErrorInfo)

                }
              }
            }

          }
          self.activityIndicator.dismiss()
        }
      case documentTypes.TurkishIdNew.rawValue:
        if side == steps.front.rawValue {
          startAnimation()
        } else {
          let idCapture = self.amani.IdCapture()
          idCapture.upload(location: nil) { result, error in
            guard let result = result else { return }
            print(result)
              DispatchQueue.main.async {

            if result {
              let initilVC = SelfieViewController(
                nibName: String(describing: SelfieViewController.self),
                bundle: Bundle(for: SelfieViewController.self))
              DispatchQueue.main.async {
                initilVC.title = Resources.KimlikTaramaTitle
                //        initilVC.callback = startIdCapture
                self.navigationController?.pushViewController(initilVC, animated: false)
              }
            } else {
              print(result)
                self.showError(
                  title: Resources.KimlikOnayErrorTitle, info: Resources.KimlikOnayErrorMessage)
              }

            }
            self.activityIndicator.dismiss()

          }
        }

      default:
        return
      }

    } catch {
        
    }
  }
  func startAnimation() {
    DispatchQueue.main.async {
      let initilVC = AnimationVC(
        nibName: String(describing: AnimationVC.self), bundle: Bundle(for: AnimationVC.self))
      initilVC.side = steps.back.rawValue
      initilVC.title = Resources.KimlikTaramaTitle
      self.navigationController?.pushViewController(initilVC, animated: false)
    }
  }

  @IBAction func tryAgain(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    //        self.navigationController?.popViewController(animated: true)
  }

  @IBAction func errorAction(_ sender: Any) {
    effectView.isHidden = true
    errorView.isHidden = true
    switch docType {
    //        case documentTypes.Selfie.rawValue:
    //            let dashboardVC = self.navigationController!.viewControllers.filter { $0 is KuryeCagirVC }.first!
    //            self.navigationController!.popToViewController(dashboardVC, animated: true)
    case documentTypes.TurkishIdNew.rawValue:
      let dashboardVC = self.navigationController!.viewControllers.filter { $0 is AnimationVC }
        .first!
      self.navigationController!.popToViewController(dashboardVC, animated: true)

    default:
      self.navigationController?.popViewController(animated: true)
    }
  }

  func showError(title: String, info: String) {
    lblErrorTitle.text = title
    lblErrorTitle.font = Theme.Font.listTypeFeatured
    let attributedString = NSMutableAttributedString(string: info)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 9  // Whatever line spacing you want in points
    paragraphStyle.alignment = .center
    attributedString.addAttribute(
      NSAttributedString.Key.paragraphStyle, value: paragraphStyle,
      range: NSMakeRange(0, attributedString.length))

    lblErrorInfo.attributedText = attributedString
    lblErrorInfo.font = Theme.Font.listTypeDescription

    effectView.isHidden = false
    errorView.isHidden = false
  }
}
extension PreviewVC:SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        guard let completion = AmaniUI.sharedInstance.completion else { return }
        completion(AmaniUI.sharedInstance.customerID!)
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    

}
