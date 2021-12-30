//
//  UIColorExtensions.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit


extension UIColor {
    convenience init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    func colorToImage(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
    public var grayscale: UIColor {
        var (red, green, blue, alpha) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            // https://en.wikipedia.org/wiki/Grayscale
            return UIColor(white: red * 0.299 + green * 0.587 + blue * 0.114, alpha: alpha)
        }
        return self
    }
}
