//
//  Theme.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import UIKit

enum Theme {
    
    enum Color {
        static let clear = UIColor("#000000").withAlphaComponent(0)
        static let ceruleanBlue = UIColor("#0075eb")
        static let hotPink = UIColor("#eb008d")
        static let darkPink = UIColor("#cc007a")
        static let pinkyRed = UIColor("#ff244a")
        static let butterscotch = UIColor("#f1be48")
        static let darkishBlue = UIColor("#003ead")
        static let white = UIColor("#ffffff")
        static let dark = UIColor("#181c1f")
        static let charcoalGrey = UIColor("#313538")
        static let blueyGrey = UIColor("#8b959e")
        static let lightGreyBlue = UIColor("#b6bbbf")
        static let veryLightBlue = UIColor("#e9edf5")
        static let paleGrey = UIColor("#f4f4fb")
        static let cloudyBlue = UIColor("#c0c0c8")
        static let cloudyBlueTwo = UIColor("#bbbec0")
        static let orangeyYellow = UIColor("#f0ad24")
        static let slateGrey = UIColor("#5b6267")
        static let iceBlue = UIColor("#edf0f4")
        static let deepSkyBlue = UIColor("#007aff")
        static let lightPeach = UIColor("#e1e0e0")
        static let border = UIColor("#d0d4db")
        static let paleLilac = UIColor("#e2e4ef")
        static let lightBlueGrey = UIColor("#d0d5db")
        static let lightPeriwinkle50 = UIColor("#d2d3df")
        static let paleGreyTwo = UIColor("#f0f1f6")
        static let silver = UIColor("#dcdedf")
        static let lightPinkyRed = UIColor("EF0063")
        static let lightGray = UIColor("89959F")
        static let brightGreen = UIColor("27A435")
        static let defaultBlue = UIColor("#0075EB")
        static let ErrorGray = UIColor("#e3e2ea")
        
        static let amaniBlue = UIColor("#8991ff")
        static let amaniDarkBlue = UIColor("#6956de")
        
        static let slateGray = UIColor(red: 91/255, green: 98/255, blue: 103/255, alpha: 1)
        
        static let blueStartColor = UIColor(red:0,green:0.46,blue:0.92,alpha:1).cgColor
        static let blueEndColor = UIColor(red:0.38, green:0.15, blue:1, alpha:1).cgColor
        
        static let greenStartColor = UIColor(red:0, green:0.91, blue:0.76, alpha:1).cgColor
        static let greenEndColor = UIColor(red:0.01, green:0.5, blue:0.2, alpha:1).cgColor
        
        static let orangeStartColor = UIColor(red:1, green:0.58, blue:0.06, alpha:1).cgColor
        static let orangeEndColor = UIColor(red:0.99, green:0.21, blue:0.06, alpha:1).cgColor
        
        static let purpleStartColor = UIColor(red:112/255, green:27/255, blue:216/255, alpha:1).cgColor
        static let purpleEndColor = UIColor(red:118/255, green:42/255, blue:217/255, alpha:1).cgColor
        
        static let AmaniEndColor = UIColor(r: 67, g: 35, b: 185).cgColor
        static let AmaniStartColor = UIColor(r: 110, g: 107, b: 229).cgColor
        
        static let transparentDark = UIColor(red: 23/255, green: 28/255, blue: 31/255, alpha: 0.40)
        static let intenselyTransparentWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.13)
        static let transparentWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        static let whiteBorderColor = UIColor(red: 225/255, green: 225/255, blue: 230/255, alpha: 1.0)
        static let black10 = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
    }
    

    enum Font {
        static let inputContentBlack = UIFont(name: "Ubuntu", size: 17.0 )!
        static let inputContentWhite = UIFont(name: "Ubuntu", size: 17.0)!
        static let inputPlaceholderWhite = UIFont(name: "Ubuntu", size: 12.0)!
        static let headerTitleBlack = UIFont(name: "Ubuntu", size: 18.0)!
        static let listTypeDefault = UIFont(name: "Ubuntu", size: 15.0)!
        static let headerTitleWhite = UIFont(name: "Ubuntu", size: 18.0)!
        static let listTypeFeatured = UIFont(name: "Ubuntu-Medium", size: 17.0)!
        static let listTypeFeaturedMin = UIFont(name: "Ubuntu", size: 17.0)!
        static let inputPlaceholderBlue = UIFont(name: "Ubuntu", size: 12.0)!
        static let navigationDefault = UIFont(name: "Ubuntu", size: 22.0)!
        static let inputPlaceholderBlack = UIFont(name: "Ubuntu", size: 12.0)!
        static let inputPlaceholderRed = UIFont(name: "Ubuntu", size: 12.0)!
        static let Style123 = UIFont(name: "Ubuntu", size: 17.0)!
        static let listTypeFeaturedMinMoney = UIFont(name: "Ubuntu-Medium", size: 13.0)!
        static let headerTitleSubTitleBlack = UIFont(name: "Ubuntu", size: 13.0)!
        static let headerTitleMinTitleBlack = UIFont(name: "Ubuntu-Medium", size: 17.0)!
        static let listTypeDescription = UIFont(name: "Ubuntu", size: 15.0)!
        static let listTypeFeaturedMinMinMoney = UIFont(name: "Ubuntu", size: 13.0)!
        static let headerTitleMinTitleWhite = UIFont(name: "Ubuntu-Medium", size: 17.0)!
        static let headerTitleSubTitleWhite = UIFont(name: "Ubuntu", size: 13.0)!
        static let inputLabelBlack = UIFont(name: "Ubuntu", size: 13.0)!
        static let inputLabelWhite = UIFont(name: "Ubuntu", size: 13.0)!
        static let symbolOrganizerGroupTitle = UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
        static let headerTitleBlackBigger = UIFont(name: "Ubuntu", size: 20.0)!
        static let headerTitleWhiteBigger = UIFont(name: "Ubuntu", size: 20.0)!
        static let listDefault = UIFont(name: "Ubuntu", size: 13.0)!
        static let listError = UIFont(name: "Ubuntu", size: 13.0)!
        static let listWarning = UIFont(name: "Ubuntu", size: 13.0)!
        static let listTypeCompMinMoney2 = UIFont(name: "Ubuntu-Medium", size: 14.0)!
        static let errorRed12Pt16Lh = UIFont(name: "GalanoGrotesque-Medium", size: 12.0)!
        static let lightSubhead1 = UIFont(name: "Roboto-Regular", size: 16.0)!
        static let lightTitle = UIFont(name: "Roboto-Medium", size: 20.0)!
        static let otpCounter = UIFont(name: "Ubuntu-Bold", size: 26.0)!
        static let toolbar = UIFont(name: "HelveticaNeue-Medium", size: 15.0)!
        static let AmountFont = UIFont(name: "Ubuntu", size: 38.0)!
        static let AmountDecimalFont = UIFont(name: "Ubuntu", size: 22.0)!
        static let AmountDecimalLast = UIFont(name: "Ubuntu-Bold", size: 14.0)!
        static let calculatePickerValue = UIFont(name: "Ubuntu-Medium", size: 28.0)!
        static let calculatePickerTitle = UIFont(name: "Ubuntu-Medium", size: 11.0)!
        static let chartAmountFont = UIFont(name: "Ubuntu-Medium", size: 38.0)!
        static let chartAmountDecimalFont = UIFont(name: "Ubuntu-Medium", size: 27.0)!
        static let otherAccountItemRate = UIFont(name: "Ubuntu-Bold", size: 15.0)!
        static let ListTitleSubTitleBlack = UIFont(name: "Ubuntu", size: 14.0)!
        static let loanInstallmentAmountDecimalFont = UIFont(name: "Ubuntu-Medium", size: 35.0)!
        static let loanInstallmentAmountFractionFont = UIFont(name: "Ubuntu-Medium", size: 22.0)!
    }
    
    enum Constants {
        static let animationDuration = 0.3
        static let countryCode = "+90"
        static let defaultChevron = #imageLiteral(resourceName: "announcement")
        static let activeChevron = #imageLiteral(resourceName: "announcement")
        
        static let inputLeftViewWidth: CGFloat = 19.0
        static let inputLeftViewHeight: CGFloat = 19.0
        static let inputLeftViewLeadingMargin: CGFloat = 11.0
        static let inputLeftViewY: CGFloat = 13.0
        
        static let leftImageDefaultTopMargin: CGFloat = 12.0
        static let leftImageDefaultLeadingMargin: CGFloat = 10.0
        static let leftImageDefaultWidth: CGFloat = 20.0
        static let leftImageDefaultHeight: CGFloat = 20.0
        
        static let rightImageDefaultTopMargin: CGFloat = 12.0
        static let rightImageDefaultLeadingMargin: CGFloat = 10.0
        static let rightImageDefaultWidth: CGFloat = 20.0
        static let rightImageDefaultHeight: CGFloat = 20.0
        
        static let borderWidth: CGFloat = 1.0
    }
}
