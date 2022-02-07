//
//  UIColor+Extensions.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

extension UIColor {
    
    static func getColor(for string: String) -> UIColor {
        var colors = ColorPalette.colors
        var concanatedString: String = ""
        
        let stringInputArr = string.components(separatedBy: " ")
        var trimmedString = ""
        
        trimmedString = "\(stringInputArr.first?.prefix(2) ?? "")\(stringInputArr.last?.prefix(2) ?? "")"
        
        for value in trimmedString.ascii {
            concanatedString += "\(value)"
        }
        
        var asciiResult = 0
        
        asciiResult = Int(concanatedString) ?? 0
        let index = asciiResult % colors.count
        let color = colors[index]
        
        return color
    }
}

extension Character {
    
    var isAscii: Bool {
        return unicodeScalars.allSatisfy { $0.isASCII }
    }
    var ascii: UInt32? {
        return isAscii ? unicodeScalars.first?.value : nil
    }
}

extension StringProtocol {
    
    var ascii: [UInt32] {
        return compactMap { $0.ascii }
    }
}
