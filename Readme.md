# Amani iOS low level (v2) SDK 
# Table of Contents

- [Overview](#overview)
- [Installation](#installation)
    - [Installing the SDK](#installing-the-sdk)
    - [App Permissions](#app-permissions)
- [Usage](#usage)
    - [Initializing the sdk](#initializing-the-sdk)
    - [ID Capture](#id-capture)
    - [Selfie](#selfie)
    - [Auto Selfie](#auto-selfie)
    - [Pose Estimation Selfie](#pose-estimation-selfie)
    - [Document Capture](#document-capture)
    - [NFC Capture](#nfc-capture)
- [F.A.Q](#faq)
# Overview

The Amani Software Development kit (SDK) provides you with complete steps to perform KYC. This SDK consists of 5 steps:

## 1. Upload Your Identification:

This internally consists of 4 types of documents, you can upload any of them to get your identification verified. These documents are

1. Turkish ID Card(New): There you can upload your new Turkish ID card.
2. Turkish ID Card(Old): There you can upload your old Turkish ID card.
3. Turkish Driver License: There you can upload your old Turkish driver's license.
4. Passport: You can also upload your passport to get verification of your identity.

## 2. Upload your selfie:

This step includes taking a selfie and uploading it.

## 3. Upload Your Proof of Address:

There we have 4 types of categories you can upload any of them to get your address verified.

1. Proof of Address: you will upload simply proof of address there.
2. ISKI: you will upload ISKI address proof there.
3. IGDAS: There you have the option of IGDAS.
4. CK Bogazici Elektrik: You have to upload the same here.

## 4. Sign Digital Contract:

In this step, you will enter the information required to make a digital contract. Then you will get your contract in the same step from our side. Then by reading that contract, you have to sign that and then at the end upload the same.

## 5. Upload Physical Contract:

In this step, you will download your physical contract. Then you have to upload the same contract by filling the all the information to get your physical contract verified.

# Installation

## Installing the SDK
## A short notice about OpenSSL

You need to add OpenSSL package yourself as some of our customers want to use it as a static library so we removed OpenSSL from our dependencies.

You can check this link for installing the OpenSSL via package managers or you can check this repository for a helper script for compiling on your own.
[https://github.com/krzyzanowskim/OpenSSL](https://github.com/krzyzanowskim/OpenSSL)

### Via Cocoapods

Add SDK source to cocoapods

```
source "<https://github.com/AmaniTechnologiesLtd/Mobile_SDK_Repo>"
source "<https://github.com/CocoaPods/Specs>"

```

Adapt your Podfile and add the Amani SDK

```
pod 'AmaniSDK'

```

### Via Carthage

Adapt your Cartfile and add the Amani SDK

```
binary "<https://raw.githubusercontent.com/AmaniTechnologiesLtd/Public-IOS-SDK/main/Amani.json>"

```

### Via Manual

[You can check our compiled frameworks from here](https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/tree/main/Carthage)

### General requirements
- iOS 11.0 and higher

## App permissions

Amani SDK makes use of the device's Camera, Location, and NFC. If you don't want to use the location service please provide it in the init method. You will be required to have the following keys in your application's `Info.plist` file:

Permissions for NFC:

```xml
    <key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
	<array>
		<string>A0000002471001</string>
	</array>
	<key>NFCReaderUsageDescription</key>
	<string>This application requires access to NFC to  scan IDs.</string>

```

Permissions for Location:

```xml
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>

```

Permissions for Camera:

```xml
	<key>NSCameraUsageDescription</key>
	<string>This application requires access to your camera for scanning and uploading the document.</string>

```

**Note**: You need to add all keys for your specific usage.

### Granting access to NFC (iOS 13.0 or later)

Enable the Near Field Communication Tag Reading capability in the target Signing & Capabilities section on Xcode.

For devices that do not support NFC like iPhone 6, some libraries that we use for NFC reading, like CoreNFC and Crypto libraries, won’t be included in the system. Because of this, you must add the libraries in the “Link Binary with Libraries” section under “Build Phases” and set them as optional. Even if you don’t require NFC to be used you must add these libraries for building the application. 

```
CoreNFC.framework
CryptoTokenKit.framework
CryptoKit.framework
```

# Usage

## Initializing the SDK

Before calling any other function of this SDK, you must call `initAmani` as shown below.

```swift

import UIKit
import AmaniSDK

class ViewController: UIViewController {
    //Define amani as global variant
    let amani = Amani.sharedInstance
    var viewContainer:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
            // Customer login information
            let customer:CustomerRequestModel = CustomerRequestModel(name: "", email: "", phone: "", idCardNumber: "Mandatory needed to be filled")
            // Initialize SDK
        amani.initAmani(server: "SERVER_URL", token: "TOKEN", sharedSecret: "SHAREDSECRETKEY", customer: customer, useGeoLocation: false, language: "tr", uploadSource: .KYC){ cmModel, error in
            //cmModel is CustomerResponseModel?
            //error is NetworkError?
        }
    }

```

We assume you have a preview screen named preview and the view controller is named previewVC for showing the image and options for trying again or continuing the KYC process.

## ID Capture

ID cards have two sides. So we need to tell the `IdCapture` module the side of the ID we’re currently capturing. To do this, give `stepId` with `steps.front.rawValue` which has the value of `0` for front and `steps.back.rawValue` for the back and respectfully this has a value of `1`.

Note: If you don’t give a value for `start` method it will default to 0, for capturing the front of the ID. 

```swift

do {
  let idcapture = amani.IdCapture()
  // setType method accepts a string. If you have provided another value by Amani please use that here
  // for accepted types you can access with documentTypes enum.
  idcapture.setType(type: documentTypes.TurkishIdNew.rawValue)
  // After 15 second it will show a capture button for taking the photo manually.
  idcapture.setManualCropTimeout(Timeout: 15)
  // if you are capturing front side of id card you need to set stepId:steps.front.rawValue or you can simply use 0
  guard
    let idcaptureView: UIView = try idcapture.start(
      stepId: steps.front,
      completion: { [weak self] (previewImage) in
        // previewImage here is an UIImage it contains the cropped image of the id.
        // You can simply this image with continue or try again button, or directly upload it with calling the upload method.
        // In this example we have previewVC for showing the captured image to customer and we call it upload button from that screen.
        DispatchQueue.main.async {
          // Remove the current view
          self?.viewContainer.removeFromSuperview()
          guard
            let previewVC: UIViewController = self?.storyboard?.instantiateViewController(
              withIdentifier: "preview")
          else { return }
          (previewVC as! PreviewVC).preImage = previewImage
          self?.viewContainer?.removeFromSuperview()
          self?.navigationController?.pushViewController(previewVC, animated: true)
        }
      })
  else { return }
  DispatchQueue.main.async {
    self.viewContainer = idcaptureView
    self.view.addSubview(idcaptureView)
    self.view.bringSubviewToFront(idCaptureView)
  }

} catch {
  print("Unexpected error: \\(error).")
}
```

For the preview view controller, you need to start id capture for the back side of the id card.

```swift
let amani = Amani.sharedInstance

do {
  let idCapture = self.amani.IdCapture()
  // if you are capturing back side of id card you need to set stepId:steps.back.rawValue or you can simply use 1
  guard
    let IdCapture2: UIView = try idCapture.start(
      stepId: steps.back.rawValue,
      completion: { (previewImage) in
        DispatchQueue.main.async {
          guard
            let previewVC: UIViewController = self.storyboard?.instantiateViewController(
              withIdentifier: "preview")
          else { return }
          (previewVC as! PreviewVC).preImage = previewImage
          self.navigationController?.pushViewController(previewVC, animated: true)
        }
      })
  else { return }

  self.view.addSubview(IdCapture2)

} catch {

}
```

### Capturing NFC With ID Capture

After capturing both sides of the ID, you can call `startNFC` method as shown in the example below. 

**Note** this method won’t work unless you have captured both sides of the id.

```swift
// After completing the capture proces for both sides.
let idCapture = Amani.sharedInstance.IdCapture()
idCapture.startNFC { [weak self] (isSuccess) in
	guard let self = self else {return}
	// do something with isSuccess.
}
```

### Upload

If you want to upload from another screen like in our example you need to define `Amani.sharedInstance` and then you can call the upload method.

```swift
let amani = Amani.sharedInstance

amani.idCapture().upload(location: nil) { (status, error) in
  //status is a boolean state if the upload is successful and the analysis done status is true
  // if the status is false in error as AmaniError returns error code and description in an array.
}
```

## Selfie

```swift
///In Main viewcontroller calling selfie screen
do {
  //Start Selfie screen
  let selfie = self.amani.selfie()
  selfie.setType(type: documentTypes.Selfie.rawValue)
  guard
    let selfieView: UIView = try selfie.start(completion: { [weak self] (previewImage) in
      //previewImage return as UIImage and includes what user captured with phone.
      //you can simply show on your page or directly upload it with calling upload method in here
      //in this example we have previewVC for showing data to customer and we call it upload button from that screen.
      DispatchQueue.main.async {
        //preview image return as UIImage and can be used in your screen for confirmation purposes
        guard
          let previewVC: UIViewController = self.storyboard?.instantiateViewController(
            identifier: "preview")
        else { return }
        (previewVC as! PreviewVC).preImage = previewImage
        self?.navigationController?.pushViewController(previewVC, animated: true)
      }
    })
  else { return }
  self.viewContainer = selfieView
  DispatchQueue.main.async {
    self.view.addSubview(selfieView)
  }
} catch {

}
```

### Upload

If you want to upload from another screen like in our example you need to define `Amani.sharedInstance` and then you can call the upload method.

```swift

let amani = Amani.sharedInstance
amani.idCapture().upload(location: nil) { (status, error) in
  // status is in boolean state if upload successful and analysis are done status is true
  // if status is false in error as AmaniError returns error code and description in an array.
}
```

## Auto Selfie

The auto selfie module same as the selfie, the only difference is it takes a selfie whenever it recognizes a person.

```swift
///In Main viewcontroller calling auto selfie screen
        do {
            //Start Selfie screen
            let autoSelfie = self.amani.autoSelfie(
            autoSelfie.setType( type: documentTypes.Selfie.rawValue)
            guard let selfieView:UIView = try autoSelfie.start(completion: { [weak self] (previewImage) in
            //previewImage return as UIImage and includes what user captured with phone.
            //you can simply show on your page or directly upload it with calling upload method in here
            //in this example we have previewVC for showing data to customer and we call it upload button from that screen.
            DispatchQueue.main.async {
                //preview image return as UIImage and can be used in your screen for confirmation purposes
                guard let previewVC:UIViewController  = self.storyboard?.instantiateViewController(identifier: "preview") else {return}
                ( previewVC as! PreviewVC).preImage = previewImage
                self?.navigationController?.pushViewController(previewVC, animated: true)
                }
            }) else {return}
            self.viewContainer = selfieView
            DispatchQueue.main.async {
                self.view.addSubview(selfieView)
            }            
					}
        } catch let err {
					print(err)
        }

```

### Upload

If you want to upload from another screen like in our example you need to define `Amani.sharedInstance` and then you can call the upload method.

```swift

let amani = Amani.sharedInstance
amani.idCapture().upload(location: nil) { (status, error) in
  // status is in boolean state if upload successful and analysis are done status is true
  // if status is false in error as AmaniError returns error code and description in an array.
}
```

## Pose Estimation Selfie

Pose estimation requires customer to complete some poses on camera and takes a selfie.

You can customize messages, and various colors by calling `poseEstimation.setScreenConfig()` and `poseEstimation.setInfoMessages()` methods respectively.

You can also set a manual crop timeout with `poseEstimation.setManualCropTimeout()` method.

Example below assumes that you have a `settings` struct with respective values.

```swift
 do {
	let poseEstimation = Amani.sharedInstance.poseEstimation()
	
	// configure screen config
	poseEstimation.setScreenConfig(screenConfig: [
      .appBackgroundColor: settings.appBackgroundColor,
      .appFontColor: settings.appFontColor,
      .primaryButtonBackgroundColor: settings.primaryButtonBackgroundColor,
      .primaryButtonTextColor: settings.primaryButtonTextColor,
      .ovalBorderColor: settings.ovalBorderColor,
      .ovalBorderSuccessColor: settings.ovalBorderSuccessColor,
      .poseCount: settings.poseCount,
    ])
	
	// configure info messages
	poseEstimation.setInfoMessages(infoMessages: [
      .faceIsOk: settings.faceIsOk,
      .notInArea: settings.notInArea,
      .faceTooSmall: settings.faceTooSmall,
      .faceTooBig: settings.faceTooBig,
      .completed: settings.completed,
      .turnedRight: settings.turnedRight,
      .turnedLeft: settings.turnedLeft,
      .turnedUp: settings.turnedUp,
      .turnedDown: settings.turnedDown,
      .straightFace: settings.straightMessage,
      .errorMessage: settings.errorMessage,
      .sonraki: settings.next,
      .tekrarDene: settings.tryAgain,
      .errorTitle: settings.errorTitle,
      .informationScreenDesc1: settings.informationScreenDesc1,
      .informationScreenDesc2: settings.informationScreenDesc2,
      .informationScreenTitle: settings.informationScreenTitle,
      .wrongPose: settings.wrongPose,
      .descriptionHeader: settings.descriptionHeader,
    ])

	poseEstimation.setManualCropTimeout(Timeout: settings.manualCropTimeout)

	self.poseEstimationView = poseEstimation.start { [weak self] (capturedSelfie) in
		guard let self = self else { return }
		DispatchQueue.main.async {
			self.poseEstimationView.removeFromSuperview()
			 //preview image return as UIImage and can be used in your screen for confirmation purposes
       guard let previewVC:UIViewController  = self.storyboard?.instantiateViewController(identifier: "preview") else {return}
       (previewVC as! PreviewVC).preImage = previewImage
       self.navigationController?.pushViewController(previewVC, animated: true)
		}
	}

	DispatchQueue.main.async {
		self.view.addSubview(self.poseEstimationView)
		self.view.bringSubviewToFront(self.poseEstimationView)
	}

} catch let err {
	print("An error occured \(err.localizedDescription)")
}
```

## Document Capture

This module captures and automatically crops the document. The callback returns only the latest image of document if you are taking more than one page.

> If you want to take more than one page of a document, set the `stepId` to **total page count - 1.**

```swift
    do {
        let documentCapture = self.amani.document()
        //"XXX_XX_0" code is example. You need to get type code from amani for document type if you not set type you can saw an exception message
        documentCapture.setType( type:"XXX_XX_0")
        //stepId is document page count for n-1 page. for example 2 page document you need to set it 1
        guard let documentCaptureView:UIView = try documentCapture.start(stepId:1, completion: { [weak self](previewImage) in
            //preview image returns lastly taken photo
            DispatchQueue.main.async {
            guard let previewVC:UIViewController  = self?.storyboard?.instantiateViewController(withIdentifier: "preview") else {return}
            ( previewVC as! PreviewVC) .preImage = previewImage
                self?.viewContainer?.removeFromSuperview()
                self?.navigationController?.pushViewController(previewVC, animated: true)
            }
        }) else {return}
        self.viewContainer = documentCaptureView
        DispatchQueue.main.async {
            self.view.addSubview(documentCaptureView)
        }

    }
    catch  {
        print("Unexpected error: \\(error).")

    }

```

### Upload

If you want to upload from another screen like in our example you need to define Amani.sharedInstance and then you can call it the upload method.

```swift

    let amani = Amani.sharedInstance

        amani.document().upload(location: nil) { (status, error) in
            //status is in boolean state if upload successful and analysis are done status is true
            // if status is false in error as AmaniError returns error code and description in an array.
        }

```

### Uploading documents directly without capture

If you want to upload your document without using the capture method, you can call the upload method of `Amani.sharedInstance.document()` with `files` parameter as shown below.

```swift
    /// Upload Files currently supporting jpg( jpe,jpg,jpeg), png, webp, bmp,pdf formats use acceptedFileTypes enum rawValue for FileWithType.dataType  or you can use

    let amani = Amani.sharedInstance
        let documentCapture = self.amani.document()
        //"XXX_XX_0" code is example. You need to get type code from amani for document type if you not set type you can saw an exception message
        documentCapture.setType( type:"XXX_XX_0")
        //FileWithType object has an 2 values
        //Data:Data
        //DataType:String you can use acceptedFileTypes enum rawValue for FileWithType.dataType or
        // "image/jpeg" for jpg, jpeg, jpe
        // "image/png" for png
        // "image/bmp" for bitmap
        // "image/webp" for webp
        // "application/pdf" for pdf
        var files:[FileWithType] = [FileWithType(data: FileData, dataType: acceptedFileTypes.jpg.rawValue)]
        documentCapture.upload(location: nil, files: files) { (status, error) in
            //status is in boolean state if upload successful and analysis are done status is true
            // if status is false in error as AmaniError returns error code and description in an array.
        }

```


## NFC Capture

You can start the NFC Capture in multiple ways.

You can call the NFC Capture with `NviData` which contains the document number, date of birth and expire date of id in `YYMMDD` format. 

```swift
let amani = Amani.sharedInstance

do {
  let scanNFC = amani.scanNFC()
  // setType method accepts a string. If you have provided another value by Amani please use that here
  // for accepted types you can access with documentTypes enum.
  scanNFC.setType(type: documentTypes.NFCDocument.rawValue)
  // when try to scan nfc you need to give 3 parameters document number, birth date and expire date
  // birth date and expire date must be in YYMMDD format
  // document number if contains alphanumeric characters, they need to be upper case
  let nvi = NviModel(documentNo: "DOCUMENTNUMBER", dateOfBirth: "YYMMDD", dateOfExpire: "YYMMDD")
  try scannfc.start(
    nviData: nvi,
    completion: { data, error in
      //data in NFCRequest type and it contains nfc information, if there is error it can be null
      //error in AmaniError type and if there is no error it can be null
      guard let data: NFCRequest = data else {
        return
      }
    })
} catch let error {
	error
}
```

You can also call the `start` method of the `ScanNFC` with base64 encoded image that contains the MRZ field of the document.

```swift
let amani = Amani.sharedInstance

do {
  let scanNFC = amani.scanNFC()
  // setType method accepts a string. If you have provided another value by Amani please use that here
  // for accepted types you can access with documentTypes enum.
  scanNFC.setType(type: documentTypes.NFCDocument.rawValue)
  try scannfc.start(
    imageBase64: imageData,
    completion: { data, error in
      //data in NFCRequest type and it contains nfc information, if there is error it can be null
      //error in AmaniError type and if there is no error it can be null
      guard let data: NFCRequest = data else {
        return
      }
    })
} catch let error {
	print("error occurred while reading nfc \(error)"
}
```

If you want to capture the image with the side that contains the MRZ field. You can call the start method with only the callback provided.

```swift
let amani = Amani.sharedInstance

do {
  let scanNFC = amani.scanNFC()
  // setType method accepts a string. If you have provided another value by Amani please use that here
  // for accepted types you can access with documentTypes enum.
  scanNFC.setType(type: documentTypes.NFCDocument.rawValue)
  try scannfc.start(completion: { data, error in
      //data in NFCRequest type and it contains nfc information, if there is error it can be null
      //error in AmaniError type and if there is no error it can be null
      guard let data: NFCRequest = data else {
        return
      }
    })
} catch let error {
	print("error occurred while reading nfc \(error)"
}
```

### Upload

If you want to upload from another screen like in our example you need to define `Amani.sharedInstance` and then you can call the upload method.

```swift

let amani = Amani.sharedInstance
amani.scanNFC().upload(location: nil) { (status, error) in
  // status is in boolean state if upload successful and analysis are done status is true
  // if status is false in error as AmaniError returns error code and description in an array.
}
```

### Video Call

you need to add a delegate method for detecting the end of the video call

add SFSafariViewControllerDelegate protocol to ViewController

```

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        guard let completion = AmaniUI.sharedInstance.completion else { return }
        completion(AmaniUI.sharedInstance.customerID!)
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

```

```
              do{
                  let sfView:SFSafariViewController = try  self.amani.videoCall().start() as! SFSafariViewController
                  sfView.delegate = self //detecting finished video call
                  DispatchQueue.main.async {
                      self.navigationController?.isNavigationBarHidden = true
                    self.navigationController?.pushViewController(sfView, animated: false)
                  }
              } catch {

              }

```

### Customer Info

To get customer info from this SDK you can use `CustomerInfo` module

```
let customerInfo = Amani.sharedInstance.customerInfo()
let customer: CustomerResponseModel = customerInfo.getCustomer()

```

# F.A.Q

## How to acquire customer token for using this SDK
1- On the server side, you need to log in with your credentials and get a token for the next steps. This token should be used only on server-side requests not used on Web SDK links.
```bash
curl --location --request POST 'https://demo.amani.ai/api/v1/user/login/' \

- -form 'email="user@account.com"' \
- -form 'password="password"'
```
2- Get or Create a customer using the request below. If there is no customer new one is created if there is a customer already created with this ID Card Number it will be returned.

This request will return a customer token that has a short life span and is valid only for this customer. Use this token to initialize Web SDK.
```
curl --location --request POST 'https://demo.amani.ai/api/v1/customer' \

- -header 'Authorization: TOKEN use_your_admin_token_here' \
- -form 'id_card_number="Customer_ID_Card_Number"'\ (Required)
- -form 'name="Customer Name"' \ (Optional)
- -form 'email="Customer Email"' \ (Optional)
- -form 'phone="Customer Phone"' (Optional)