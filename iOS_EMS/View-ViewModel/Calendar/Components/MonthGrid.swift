//
//  MonthGrid.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct MonthGrid: View {
    @Binding var selectedDate: Date
    let currentMonth: Date
    let isPublicHoliday: (Date) -> Bool
    let dayColor: (Date) -> Color

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 4),
        count: 7
    )

    var body: some View {
        LazyVGrid(
            columns: columns,
            spacing: 8
        ) {
            ForEach(
                currentMonth.daysInTheMonth,
                id: \.self
            ) { day in
                DayButton(
                    day: day,
                    isSelected: Calendar.current.isDate(
                        day,
                        inSameDayAs: selectedDate
                    ),
                    isPublicHoliday: isPublicHoliday(day),
                    color: dayColor(day)
                ) {
                    selectedDate = day
                }
            }
        }
    }
}
#Preview {
    MonthGridPreview()
}

private struct MonthGridPreview: View {
    @State private var selectedDate = Date.now

    var body: some View {
        MonthGrid(
            selectedDate: $selectedDate,
            currentMonth: Date.now,
            isPublicHoliday: { _ in false },
            dayColor: { _ in .primary }
        )
        .padding()
    }
}
