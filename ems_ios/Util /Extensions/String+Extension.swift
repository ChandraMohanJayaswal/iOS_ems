//
//  String+Extension.swift
//  ems_ios
//
//  Created by MacMini on 01/06/2026.
//

import Foundation
extension String {
    func stringToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: self) {
            return date
        }
        return nil
    }
}
