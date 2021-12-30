//
//  UIDatePicker+Extensions.swift
//  Amani
//
//  Created by Münir Ketizmen on 5.08.2021.
//

import Foundation
import UIKit

extension UIDatePicker {
    func set18YearValidation() {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -18
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = -150
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.minimumDate = minDate
        self.maximumDate = maxDate
    }
    
    func set2YearValidation() {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = -2
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.minimumDate = minDate
        self.maximumDate = maxDate
    }
    
}
