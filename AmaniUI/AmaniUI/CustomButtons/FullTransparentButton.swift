//
//  FullTransparentButton.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

class FullTransparentButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 2
        self.layer.borderColor = Color.white.withAlphaComponent(0.3).cgColor
        self.setTitleColor(Color.white, for: .normal)
        self.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(name: "Ubuntu-Medium", size: 12), size: 12)
        self.layer.cornerRadius = 18
    }
    
}
