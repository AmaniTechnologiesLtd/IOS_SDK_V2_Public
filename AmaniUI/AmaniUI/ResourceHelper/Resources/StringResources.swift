//
//  StringResources.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

class StringResources: NSObject {

    static var resources : [String: String] = [
        "login.customerNo" : "TC Kimlik Numarası / Müşteri Numarası",
        "login.password" : "İnternet Şube Şifresi",
        "input.defaultErrorMessage" : "Lütfen bu alanı doldurunuz"
        
    ]
    
    
    static func findResource(By code: String) -> String {
        let resource = StringResources.resources[code]
        return resource ?? code
    }
    
    static func findCode(By resource: String) -> String {
        let code = StringResources.resources.first {
            $0.value == resource
        }
        
        return code == nil ? resource : code!.key
    }
}
