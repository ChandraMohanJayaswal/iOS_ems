//
//  MonthYearPicker.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct MonthYearPicker: View {
    @Binding var selectedMonth: Int
    @Binding var selectedYear: Int
    @Binding var selectedDate: Date

    var body: some View {
        HStack(spacing: 8) {
            monthMenu
            yearMenu

            Spacer()

            Button("Today") {
                selectedMonth = Calendar.current.component(
                    .month,
                    from: Date()
                )
                selectedYear = Calendar.current.component(
                    .year,
                    from: Date()
                )
                selectedDate = Date.now
            }
            .font(.inter(.semibold, size: 15))
            .foregroundStyle(.cyan)
        }
    }

    private var monthMenu: some View {
        Menu {
            Picker("Month", selection: $selectedMonth) {
                ForEach(1...12, id: \.self) { month in
                    Text(monthName(month))
                        .font(.inter(size: 15))
                        .tag(month)
                }
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                Text(monthName(selectedMonth))
                    .font(.inter(.semibold, size: 12))
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption2.weight(.bold))
                    .opacity(0.7)
            }
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(blue.opacity(0.12))
            )
            .foregroundStyle(blue)
        }
        .fixedSize()
        .tint(blue)
    }

    private var yearMenu: some View {
        Menu {
            Picker("Year", selection: $selectedYear) {
                ForEach(2020...2030, id: \.self) { year in
                    Text(verbatim: "\(year)")
                        .font(.inter(size: 15))
                        .tag(year)
                }
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                Text(verbatim: "\(selectedYear)")
                    .font(.inter(.semibold, size: 12))
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption2.weight(.bold))
                    .opacity(0.7)
            }
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(blue.opacity(0.12))
            )
            .foregroundStyle(blue)
        }
        .fixedSize()
        .tint(blue)
    }

    private func monthName(_ month: Int) -> String {
        DateComponents(
            calendar: .current,
            month: month
        )
        .date?
        .formatted(.dateTime.month(.wide)) ?? ""
    }
}