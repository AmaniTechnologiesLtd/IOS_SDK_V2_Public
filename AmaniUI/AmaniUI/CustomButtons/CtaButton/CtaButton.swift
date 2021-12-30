//
//  CtaButton.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation
import UIKit

class CtaButton: UIButton {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    var buttonClicked : (()->())?
    
    @IBInspectable public var icon: UIImage = UIImage() {
        didSet {
            iconImage.image = icon
        }
    }
    
    @IBInspectable public var title: String = "" {
        didSet {
            buttonLabel.text = title
        }
    }
    
    @IBInspectable public var verticalSpacing: CGFloat = 15.0 {
        didSet {
            stackView.spacing = verticalSpacing
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CtaButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonClicked(sender:)))
        contentView.addGestureRecognizer(gestureRecognizer)
        
        buttonLabel.numberOfLines = 3
    }
    
    func setLabelText(title: String) {
        buttonLabel.text = title
    }
    
    func setImage(image: UIImage) {
        iconImage.contentMode = .scaleAspectFit
        iconImage.image = image
        
    }
    
    
    
    @objc func buttonClicked(sender: UITapGestureRecognizer) {
        buttonClicked?()
    }

}
