//
//  String+Extension.swift
//  ems_ios
//
//  Created by MacMini on 01/06/2026.
//

import Foundation
extension Double {
    var displayDate: String {
        let epoch: TimeInterval  = TimeInterval(self)
        let date = Date(timeIntervalSince1970: epoch / 1000)
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "MMM/dd/yyyy"
        return formatter.string(from: date)
    }
    var date: Date {
        let epoch: TimeInterval  = TimeInterval(self)
        let date = Date(timeIntervalSince1970: epoch / 1000)
        return date
    }
}
