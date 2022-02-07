//
//  SecondaryButton.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

class SecondaryButton: BaseButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUI()
    }
    
    private func setUI() {
        self.layer.borderWidth = 2
        self.layer.borderColor = Theme.Color.amaniDarkBlue.cgColor
        hoverColor = Theme.Color.amaniDarkBlue.cgColor
        layerColor = layer.backgroundColor
        self.setTitleColor(Theme.Color.amaniDarkBlue, for: .normal)
        titleColor = Theme.Color.amaniDarkBlue
        self.titleLabel?.font = UIFont(name: "Ubuntu-Bold", size: 15)
        self.layer.cornerRadius = 25
    }
}
