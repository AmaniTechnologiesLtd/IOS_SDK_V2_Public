//
//  BaseButton.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation
import UIKit

class BaseButton: UIButton {
    
    var layerColor: CGColor!
    var hoverColor: CGColor!
    var titleColor: UIColor!
    
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = false
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.backgroundColor = hoverColor
        setTitleColor(Theme.Color.white, for: .normal)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        layer.backgroundColor = layerColor
        setTitleColor(titleColor, for: .normal)
        super.touchesEnded(touches, with: event)
    }
}
