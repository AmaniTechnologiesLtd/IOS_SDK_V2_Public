//
//  Feature.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//
import UIKit

enum Features {
    case Login
    case Profile
    case Accounts
    case Investments
    case Payments
    case Loans
    case MoneyTransfer
}

class GradientColor {
    public var StartColor: CGColor
    public var EndColor: CGColor
    
    init(startColor: CGColor, endColor: CGColor) {
        StartColor = startColor
        EndColor = endColor
    }
    
    public static func getFeatureColors(feature: Features) -> GradientColor {
//        return GradientColor.init(startColor: Theme.Color.blueStartColor, endColor: Theme.Color.blueEndColor)
        return GradientColor.init(startColor: Theme.Color.AmaniStartColor, endColor: Theme.Color.AmaniEndColor)

    }
    
}
