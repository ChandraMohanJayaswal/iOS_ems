//
//  CalendarCard.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct CalendarCard: View {
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    @Binding var selectedDate: Date
    let currentMonth: Date
    let isPublicHoliday: (Date) -> Bool
    let dayColor: (Date) -> Color

    var body: some View {
        VStack(spacing: 12) {
            MonthYearPicker(
                selectedMonth: $selectedMonth,
                selectedYear: $selectedYear,
                selectedDate: $selectedDate
            )
            Divider()
            WeekDayHeader()
            MonthGrid(
                selectedDate: $selectedDate,
                currentMonth: currentMonth,
                isPublicHoliday: isPublicHoliday,
                dayColor: dayColor
            )
        }
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}