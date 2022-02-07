//
//  UIFont+Extensions.swift
//  Amani
//
//  Created by Münir Ketizmen on 31.07.2021.
//

import Foundation
import UIKit

public extension UIFont {
    
    class func loadAllFonts(bundleIdentifierString: String) {
        registerFontWithFilenameString(filenameString: "Ubuntu-M.ttf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "Ubuntu-L.ttf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "Ubuntu-BI.ttf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "Ubuntu-MI.ttf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "Ubuntu-R.ttf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "Ubuntu-LI.ttf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "Ubuntu-B.ttf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "Ubuntu-C.ttf", bundleIdentifierString: bundleIdentifierString)
        registerFontWithFilenameString(filenameString: "Ubuntu-RI.ttf", bundleIdentifierString: bundleIdentifierString)
        // Add more font files here as required
    }
    
    static func registerFontWithFilenameString(filenameString: String, bundleIdentifierString: String) {
        if let frameworkBundle = Bundle(identifier: bundleIdentifierString) {
            let pathForResourceString = frameworkBundle.path(forResource: filenameString, ofType: nil)
            let fontData = NSData(contentsOfFile: pathForResourceString!)
            let dataProvider = CGDataProvider(data: fontData!)
            let fontRef = CGFont(dataProvider!)!
            var errorRef: Unmanaged<CFError>? = nil
            
            if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
                print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
            }
        }
        else {
            print("Failed to register font - bundle identifier invalid.")
        }
    }
}
