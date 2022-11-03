# Amani SDK #

# Table of Content
- [Overview](#overview)
- [Basics](#basics)
    - [General Requirements](#general-requirements)
    - [Permissions](#permissions)
    - [Integration](#integration)
- [Installation](#Installation)
    - [Via Cocoapods](#via-cocoapods)
    - [Via Carthage](#via-carthage)
    - [Via Manual](#via-manual)


# Overview

The Amani Software Development kit (SDK) provides you complete steps to perform KYC.This sdk consists of 5 steps:

## 1. Upload Your Identification:  

This internally consist of 4 types of documents, you can upload any of them to get your identification verified.THese documets are
1. Turkish ID Card(New): There you can upload your new turkish ID card.
2. Turkish ID Card(Old): There you can upload your old turkish ID card.
3. Turkish Driver License: There you can upload your old turkish driver license.
4. Passport: You can also upload your passport to get verification of your identity.

## 2. Upload your selfie:

This steps includes the taking a selfie and uploading it.


## 3. Upload Your Proof of Address:

There we have 4 types of categories you can upload any of them to get your address verified.  
1. Proof of Address: you will upload simply proof of address there.  
2. ISKI: you will upload ISKI address proof there.  
3. IGDAS: There you have the option of IGDAS.  
4. CK Bogazici Elektrik: You have to upload the same here.  

## 4. Sign Digital Contract:

In this step, you will enter your information required to make digital contract.Then you will got your contract in the same step from our side.Then by reading that contract, you have to sign that and then at the end upload the same.

## 5. Upload Physical Contract:

In this step, you will download your physical contract. Then you have to upload the same contrat by filling the all the information to get your physical contract verified.

## Congratulation Screen:

After successfully uploading of all the documents you will see a congratulation screen saying you completed all the steps.We will check your documents and
increase your limit in 48 hours.

# Basics

## General Requirements
The minimum requirements for the SDK are:  
* iOS 11.0 and higher  


### App permissions

Amani SDK makes use of the device Camera, Location and NFC. If you dont want to use location service please provide in init method. You will be required to have the following keys in your application's Info.plist file:

for NFC: 

```xml
    <key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
	<array>
		<string>A0000002471001</string>
	</array>
	<key>NFCReaderUsageDescription</key>
	<string>This application requires access to NFC to  scan IDs.</string>
```

For Location:

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

For Camera:

```xml
	<key>NSCameraUsageDescription</key>
	<string>This application requires access to your camera for scanning and uploading the document.</string>
```


**Note**: You need to add all keys according to your usage. 

### Grant accesss to NFC
Enable the Near Field Communication Tag Reading capability in the target Signing & Capabilities. 

## Integration

For not NFC supported device (like iPhone 6) there is no CoreNFC library in system and also we are using some ios crypto libraries for reading nfc data supported after iOS 13.
You need to add below listed libraries as optional under Build Phases->Link Binary With Libraries menu. Even if you don't use the nfc process, you should add.
```
CoreNFC.framework
```

```
CryptoTokenKit.framework
```
```
CryptoKit.framework
```

### Example Usage

#### Swift

Initialize sdk and make it ready to use 

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
        amani.initAmani(server: "SERVER_URL", token: "TOKEN", sharedSecret: "SHAREDSECRETKEY", customer: customer, useGeoLocation: false, language: "tr"){ cmModel, error in
            //cmModel is CustomerResponseModel? 
            //error is NetworkError?
        }
    }

```

We assume you have an preview screen named preview and viewcontroller is previewVC for showing data of what user take as a photo 
you can make it visible for them and make step of confirmation. 

##### Selfie

```swift
///In Main viewcontroller calling selfie screen 
        do {
            //Start Selfie screen 
            let selfie = self.amani.selfie()
            selfie.setType( type: documentTypes.Selfie.rawValue)
            guard let selfieView:UIView = try selfie.start(completion: { [weak self] (previewImage) in
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
            self.viewContainer = selfieVC
            DispatchQueue.main.async {
                self.view.addSubview(selfieVC)
            }            }
        } catch {
            
        }
```
###### Upload
If you want to upload from another screen like in our example you need to define Amani.sharedInstance and than you can call it upload method
```swift

    let amani = Amani.sharedInstance

        amani.selfie().upload(location: nil) { (status, error) in
            //status is in boolean state if upload successful and analysis are done status is true
            // if status is false in error as AmaniError returns error code and description in an array.
        }
```

##### Document Capture
Document capture screen has an crop functinolaty when customer takes document photo they will move to crop screen and make only document photo. 
Because of this we dont need to confirmation screen in every pages of document. For last page if you want to show we are uploading kind screen you can use 
lastly taken photo.

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
        print("Unexpected error: \(error).")
        
    }
```
###### Upload
If you want to upload from another screen like in our example you need to define Amani.sharedInstance and than you can call it upload method
```swift

    let amani = Amani.sharedInstance

        amani.document().upload(location: nil) { (status, error) in
            //status is in boolean state if upload successful and analysis are done status is true
            // if status is false in error as AmaniError returns error code and description in an array.
        }
```

###### Upload With File
If you want to upload from another screen like in our example you need to define Amani.sharedInstance and than you can call it upload method


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

##### ID Card Capture

id card's has 2 sides so we need to tell which side of id card capturing in stepId if its not settet as in example it will gets front value allways.

```swift
    do {
        
        let idcapture = amani.IdCapture()
        // setType accepts String if you have provided another value by Amani please use that
        // for accepted id card types you can access with documentTypes enum.
        idcapture.setType( type: documentTypes.TurkishIdNew.rawValue) 
        idcapture.setManualCropTimeout(Timeout: 15) // after 15 second it will show photo button
        // if you are capturing front side of id card you need to set stepId:steps.front.rawValue or you can simply use 0 
        guard let idcaptureVC:UIView = try idcapture.start( stepId: steps.front ,completion: { [weak self] (previewImage) in
            //previewImage return as UIImage and includes what user captured with phone. 
            //you can simply show on your page or directly upload it with calling upload method in here
            //in this example we have previewVC for showing data to customer and we call it upload button from that screen.
            DispatchQueue.main.async {
            guard let previewVC:UIViewController  = self?.storyboard?.instantiateViewController(withIdentifier: "preview") else {return}
            ( previewVC as! PreviewVC) .preImage = previewImage
                self?.viewContainer?.removeFromSuperview()
                self?.navigationController?.pushViewController(previewVC, animated: true)
            }
        }) else {return}
        DispatchQueue.main.async {

        self.viewContainer = idcaptureVC
        self.view.addSubview(idcaptureVC)
        }
        
    }
    catch  {
        print("Unexpected error: \(error).")
    }
```
For previewVC file you need to start id capture for back side of id card. 
```swift
    let amani = Amani.sharedInstance

        do {
            let idCapture = self.amani.IdCapture()
            // if you are capturing back side of id card you need to set stepId:steps.back.rawValue or you can simply use 1 
            guard let IdCapture2:UIView = try idCapture.start( stepId: steps.back.rawValue , completion: { (previewImage) in
                DispatchQueue.main.async {
                    guard let previewVC:UIViewController  = self.storyboard?.instantiateViewController(withIdentifier: "preview") else {return}
                    ( previewVC as! PreviewVC) .preImage = previewImage
                    self.navigationController?.pushViewController(previewVC, animated: true)
                }
            }) else {return}
       
            self.view.addSubview(IdCapture2)
            
        } catch {
            
        }
```
###### Upload
If you want to upload from another screen like in our example you need to define Amani.sharedInstance and than you can call it upload method
```swift

    let amani = Amani.sharedInstance

        amani.idCapture().upload(location: nil) { (status, error) in
            //status is in boolean state if upload successful and analysis are done status is true
            // if status is false in error as AmaniError returns error code and description in an array.
        }
```

##### NFC

```swift
    let amani = Amani.sharedInstance

        do {
            let scanNFC = amani.scanNFC()
            // setType accepts String if you have provided another value by Amani please use that
            // for accepted id card types you can access with documentTypes enum.
            scanNFC.setType( type: documentTypes.NFCDocument.rawValue)
            //when try to scan nfc you need to give 3 parameters document number, birth date and expire date
            //birth date and expire date must be in YYMMDD format
            //document number if contains alphanumeric characters, they need to be upper case
            let nvi = NviModel(documentNo: "DOCUMENTNUMBER", dateOfBirth: "YYMMDD", dateOfExpire: "YYMMDD")
            try scannfc.start( nviData: nvi,completion: { data, error in
            //data in NFCRequest type and it contains nfc information, if there is error it can be null
            //error in AmaniError type and if there is no error it can be null
                guard let data:NFCRequest = data else {
                    return
                }
            })
        } catch {
            
        }
```
###### Upload

If you want to upload from another screen like in our example you need to define Amani.sharedInstance and than you can call it upload method
```swift

    let amani = Amani.sharedInstance

        amani.scanNFC().upload(location: nil) { (status, error) in
            //status is in boolean state if upload successful and analysis are done status is true
            // if status is false in error as AmaniError returns error code and description in an array.
        }
```
##### Video Call


you need to add delegate method for detecting end of video call

add SFSafariViewControllerDelegate protocol to ViewController 

```swift

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        guard let completion = AmaniUI.sharedInstance.completion else { return }
        completion(AmaniUI.sharedInstance.customerID!)
        DispatchQueue.main.async {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
```


```swift
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

# Installation

You need to add openSSL package some of our customers wants to use as static library so we remove it from our dependicies.
When you want to use AmaniSDK you need to be sure openSSL must be installed. 

You can check this link for install via package managers or there is a helper script for compile on your own.
https://github.com/krzyzanowskim/OpenSSL

## Via Cocoapods

Add sdk source to cocoapods
```ruby
source "https://github.com/AmaniTechnologiesLtd/Mobile_SDK_Repo"
source "https://github.com/CocoaPods/Specs"
```

Adapt you Podfile and add the Amani SDK  

```ruby 
pod 'AmaniSDK'
```

## Via Carthage

Adapt you Cartfile and add the Amani SDK  

```
binary "https://raw.githubusercontent.com/AmaniTechnologiesLtd/Public-IOS-SDK/main/Amani.json"
```

## Via Manual

You can check our compiled frameworks for your version from the link 
```
https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK/tree/main/Carthage
```
