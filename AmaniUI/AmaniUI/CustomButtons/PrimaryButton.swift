//
//  PrimaryButton.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

class PrimaryButton: BaseButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }
    
    func setUI() {
        self.layer.backgroundColor = Theme.Color.hotPink.cgColor
        layerColor = layer.backgroundColor
        hoverColor = Theme.Color.darkPink.cgColor
        self.layer.borderColor = Theme.Color.hotPink.cgColor
        self.setTitleColor(Theme.Color.white, for: .normal)
        titleColor = Theme.Color.white
        self.titleLabel?.font = UIFont(name: "Ubuntu-Bold", size: 15)
        self.layer.cornerRadius = 25
    }
}
