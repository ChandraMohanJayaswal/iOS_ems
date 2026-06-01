//
//  Date+Extension.swift
//  ems_ios
//
//  Created by MacMini on 01/06/2026.
//
import Foundation
extension Date {
    func datetoString(_ format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
