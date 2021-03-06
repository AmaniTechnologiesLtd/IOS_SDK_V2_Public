#
#  Be sure to run `pod spec lint Amani.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "AmaniSDK"
  spec.version      = "2.2.7"
  spec.summary      = "Amani-SDK"
  spec.description  = "The Amani Software Development kit (SDK) provides you complete steps to perform eKYC."
  spec.homepage     = "https://github.com/AmaniTechnologiesLtd/IOS_SDK_V2_Public"
  spec.license      = "Copyright"
  spec.author       = "Amani"
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => 'https://github.com/AmaniTechnologiesLtd/IOS_SDK_V2_Public.git', :tag => "#{spec.version}"}
  # spec.dependency 'Alamofire', '>=5.2'
  # spec.dependency 'SwiftLint'
  # spec.dependency 'IQKeyboardManagerSwift'
  # spec.dependency "lottie-ios"
  # spec.dependency 'OpenSSL-Universal'
  spec.xcconfig          = { 'OTHER_LDFLAGS' => '-weak_framework CryptoKit -weak_framework CoreNFC -weak_framework CryptoTokenKit'}
  spec.ios.deployment_target = '10.0'
  spec.vendored_frameworks = 'AmaniSDK.xcframework'
  

end
