# Amani SDK #

# Table of Content
- [Overview](#overview)
- [Basics](#basics)
    - [General Requirements](#general-requirements)
    - [Permissions](#permissions)
    - [Integration](#integration)
- [Installation](#Installation)
    - [Via CocoaPods](#via-cocoaPods)


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

```xml
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
	<array>
		<string>A0000002471001</string>
	</array>
	<key>NFCReaderUsageDescription</key>
	<string>This application requires access to NFC to  scan IDs.</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSCameraUsageDescription</key>
	<string>This application requires access to your camera for scanning and uploading the document.</string>
```
**Note**: All keys will be required for app submission.

### Grant accesss to NFC
Enable the Near Field Communication Tag Reading capability in the target Signing & Capabilities. 


## Integration

##### Example Usage
Add Navigation Controller from XCode menu in Editor -> Embed in -> Navigation Controller
After embedded in then call our sdk




##### Swift

```swift

import UIKit
import Amani

class ViewController: UIViewController {    
    //Define amani as global variant 
    let amani = Amani.sharedInstance


    override func viewDidLoad() {
        super.viewDidLoad()

            // Customer login information
            let customer:CustomerRequestModel = CustomerRequestModel(name: "", email: "", phone: "", idCardNumber: "Mandatory needed to be filled")
            // Initialize SDK 
            amani.initAmani(server: "SERVER_URL", token: "TOKEN", customer:customer,useGeoLocation:false, language: "tr" ) 
    }

  @IBAction func StartSelfieButton(_ sender: Any) {
        do {
            //Start Selfie screen 
            let selfie = self.amani.selfie()
            guard let selfieVC:UIViewController = try selfie.start(completion: { (previewImage) in
            DispatchQueue.main.async {
                //preview image return as UIImage and can be used in your screen for confirmation purposes         
                guard let previewVC:UIViewController  = self.storyboard?.instantiateViewController(identifier: "preview") else {return}
                ( previewVC as! PreviewVC).preImage = previewImage
                self.navigationController?.pushViewController(previewVC, animated: true)
                }
            }) else {return}
            self.navigationController?.pushViewController(try selfieVC, animated: true)
            }
        } catch {
            
        }
}

  @IBAction func StartIDCardButton(_ sender: Any) {
        do {
            let idCapture = amani.IdCapture()
            idCapture.setType( type: "TUR_ID_1")
            //stepId parameter must be set for wich side of document scanned you need to start both sides for using upload method
            guard let IdCapture:UIViewController = try idCapture.start(stepId: .front, completion: { (previewImage) in
            DispatchQueue.main.async {
                guard let previewVC:UIViewController  = self.storyboard?.instantiateViewController(identifier: "preview") else {return}
                ( previewVC as! PreviewVC) .preImage = previewImage
                self.navigationController?.pushViewController(previewVC, animated: true)
                }
                }) else {return}
                self.navigationController?.pushViewController(try IdCapture, animated: true)
        } catch {
            
        }
}
  @IBAction func StartNFCButton(_ sender: Any) {
        do {
            try amani.IdCapture().startNFC( completion: { result in
                if result {
                    print ("scanned successfully")
                } else {
                    print ("retry")
                }
            })
        } catch {
            
        }
}
  @IBAction func StartNFCOnlyButton(_ sender: Any) {
        do {
            let scanNFC = amani.scanNFC()
            scanNFC.setType( type: "TUR_ID_1")
            try scannfc.start( nviData: nvi,completion: { data in
                guard let data:NFCRequest = data else {
                    return
                }
            })
        } catch {
            
        }
}

//Selfie Upload
func uploadSelfie(){
    amani.selfie().upload
}
//ID Card Upload
func uploadIDCard(){
    amani.IdCapture().upload
}

//NFC Upload
func uploadNFC(){
    amani.scanNFC().upload
}
```

# Installation

## Via CocoaPods

Install using [CocoaPods](http://cocoapods.org) by adding this line to your Podfile:


```ruby
use_frameworks!
  pod 'Amani', :git => 'https://github.com/AmaniTechnologiesLtd/Public-IOS-SDK.git', :tag => '1.2.6'
```
also add after last end statement of podfile 

```ruby
#add following lines end of podfile after last 'end'
post_install do |installer|
	installer.pods_project.targets.each do |target|
	  target.build_configurations.each do |config|
	    config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
	  end
	end
end
```

Then, run the following command:

```bash
$ pod install
```

<!-- ## Getting Results 

###### Swift

```swift
extension ViewController:AmaniSDKDelegate{
    func onConnectionError(error: String?) {
        //do whatever when connection error
    }
    func onNoInternetConnection() {
        //do whatever when no internet connection
    }

    func onKYCSuccess(CustomerId: Int) {
        //do whatever when customer approved
    }

    func onKYCFailed(CustomerId: Int, Rules: [[String : String]]?) {
        // Returns uncompleted fields
    }

    func onTokenExpired() {
    	// returns when token expired. Token needs to be refreshed and restart instance 
    }
}
``` -->
