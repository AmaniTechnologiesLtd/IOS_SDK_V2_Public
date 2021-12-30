//
//  UILabel+Extensions.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation
import UIKit

extension UILabel {
    
    func addIconToLabel(imageName: String, labelText: String, bounds_x: Double, bounds_y: Double, boundsWidth: Double, boundsHeight: Double) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        attachment.bounds = CGRect(x: bounds_x, y: bounds_y, width: boundsWidth, height: boundsHeight)
        let attachmentStr = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: labelText)
        string.append(attachmentStr)
        let string2 = NSMutableAttributedString(string: "")
        string.append(string2)
        return string
    }
}
