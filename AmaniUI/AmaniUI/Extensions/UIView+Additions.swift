//
//  UIView+Additions.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func ownFirstNib() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
    }
    
    func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    public func addConstaintsToSuperview(leftOffset: CGFloat, topOffset: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .leading,
                           multiplier: 1,
                           constant: leftOffset).isActive = true
        
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.superview,
                           attribute: .top,
                           multiplier: 1,
                           constant: topOffset).isActive = true
    }
    
    public func addConstaints(height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: height).isActive = true
        
        
        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: width).isActive = true
    }
}

extension UIView {
    
    func removeAllSubviews() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat, backgroundColor: UIColor, shadow: ((_ layer: CAShapeLayer)->())? = nil) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let frameLayer = CAShapeLayer()
        frameLayer.path = path.cgPath
        frameLayer.shadowPath = path.cgPath
        
        frameLayer.fillColor = backgroundColor.cgColor
        shadow?(frameLayer)
        
        self.layer.mask = nil
        self.layer.insertSublayer(frameLayer, at: 0)
    }
    
}

extension UIView {
    func setGradientBackground(feature: Features) {
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        
        let gradientColor = GradientColor.getFeatureColors(feature: feature)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        gradient.colors = [
            gradientColor.StartColor,
            gradientColor.EndColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 1, y: 0.92)
        gradient.endPoint = CGPoint(x: 0.02, y: 0.02)
        layer.layer.addSublayer(gradient)
        
        self.insertSubview(layer, at: 0)
    }
    
    func setGradientBackground(feature: Features, roundCorner: CGFloat, widthPadding: CGFloat) {
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width - widthPadding, height: self.bounds.height))
        
        let gradientColor = GradientColor.getFeatureColors(feature: feature)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width - widthPadding, height: self.bounds.height)
        gradient.colors = [
            gradientColor.StartColor,
            gradientColor.EndColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 1, y: 0.92)
        gradient.endPoint = CGPoint(x: 0.02, y: 0.02)
        layer.roundCorners(.allCorners, radius: roundCorner)
        layer.layer.addSublayer(gradient)
        
        self.insertSubview(layer, at: 0)
    }
    
    func addBackgroundNLogo() {
        let image = UIImage(named: "backgroundNlogo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        let xC = (self.frame.width - imageView.frame.size.width)
        let yC = (self.frame.height / 3) - (imageView.frame.size.height / 2)
        imageView.frame = CGRect(x: xC, y: yC, width: imageView.frame.size.width, height: imageView.frame.size.height)
        self.insertSubview(imageView, at: 1)
    }
}
