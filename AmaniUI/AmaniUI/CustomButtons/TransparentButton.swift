//
//  TransparentButton.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation

import UIKit

class TransparentButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.backgroundColor = Color.black.withAlphaComponent(0.50).cgColor
        self.layer.isOpaque = false
        self.setTitleColor(Color.white, for: .normal)
        self.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "Ubuntu-Medium", size: 15), size: 15)
        self.layer.cornerRadius = 18
    }
}
