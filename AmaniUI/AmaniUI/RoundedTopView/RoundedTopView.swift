//
//  RoundedTopView.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

class RoundedTopView: UIView {
    private var shadowLayer: CAShapeLayer!
    var cornerRadius: CGFloat = 30.0
    var corners : UIRectCorner = [.topLeft,.topRight]
    var displayShadow: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            shadowLayer.fillColor = self.backgroundColor?.cgColor
            
            shadowLayer.shadowPath = shadowLayer.path
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowOpacity = displayShadow ? 0.3 : 0
            shadowLayer.shadowOffset = CGSize(width: 0, height: 6)
            shadowLayer.shadowRadius = 30.0 / 2.0
            layer.insertSublayer(shadowLayer, at: 0)
        }
        
        backgroundColor = .clear
    }
}
