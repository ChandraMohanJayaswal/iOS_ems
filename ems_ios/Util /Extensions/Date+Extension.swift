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
    var daysInTheMonth: [Date] {
        var daysInTheMonth: [Date] = []
        let calendar = Calendar.current
        let firstDay = calendar.dateInterval(of: .month, for: self)!.start
        let firstWeekDay = calendar.component(.weekday, from: firstDay)
        let previousMonth = calendar.date(
            byAdding: .month,
            value: -1,
            to: firstDay
        )!
        let previousMonthDays = calendar.range(
            of: .day,
            in: .month,
            for: previousMonth
        )!.count
        if firstWeekDay - 1 > 0 {
            let startDay = previousMonthDays - firstWeekDay + 2
            for day in startDay...previousMonthDays {
                daysInTheMonth.append(
                    calendar.date(
                        bySetting: .day,
                        value: day,
                        of: previousMonth
                    ) ?? Date.now
                )
            }
        }
        let currentMonthDays = calendar.range(of: .day, in: .month, for: self)!
        for day in currentMonthDays {
            let date = calendar.date(bySetting: .day, value: day, of: firstDay)!
            daysInTheMonth.append(date)
        }

        return daysInTheMonth
    }
}
