//
//  Icons.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

enum Icons : String {
    case NextArrow = "icoNextArrow"
    case ArrowRight = "arrowRight"
    case Wait = "icoWait"
    case Failed = "icoFailed"
    case Success = "icoSuccess"
    case Home = "home"

    //Add Icons here before using 
}

extension Icons {
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
    
    var name: String {
        return self.rawValue
    }
}
