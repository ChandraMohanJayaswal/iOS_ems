//
//  Calendar.swift
//  ems_ios
//
//  Created by MacMini on 19/08/2026.
//
import SwiftUI

struct ViewCalendar: View {
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var currentMonth: Date = Date.now
    @State private var currentDate: Date = Date.now
    @State private var selectedDate: Date = Date.now
    @State private var selectedMonth = Calendar.current.component(
        .month,
        from: Date()
    )
    @State private var selectedYear = Calendar.current.component(
        .year,
        from: Date()
    )
    @ObservedObject var viewModel: ViewModelPublicHolidays
    var body: some View {
        VStack {
            HStack {
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(
                            DateComponents(calendar: .current, month: month)
                                .date?
                                .formatted(.dateTime.month(.wide)) ?? ""
                        )
                        .tag(month)
                    }
                }

                Picker("Year", selection: $selectedYear) {
                    ForEach(2020...2030, id: \.self) { year in
                        Text(verbatim: "\(year)")
                            .tag(year)
                    }
                }
                .pickerStyle(.automatic)
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
                .padding(.trailing, 6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 8)
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity)
            }
            Divider()
                .padding(.horizontal, 9)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(currentMonth.daysInTheMonth, id: \.self) { day in
                    Button(
                        action: {
                            selectedDate = day
                        },
                        label: {
                            VStack(spacing: 2) {
                                if Calendar.current.isDate(
                                    day,
                                    inSameDayAs: Date.now
                                ) {
                                    Circle()
                                        .frame(width: 8, height: 8)
                                }
                                Text(day.formatted(.dateTime.day()))
                                    .frame(maxWidth: .infinity, minHeight: 30)
                                    .foregroundStyle(
                                        viewModel.checkDateColor(day)
                                    )
                                    .background(
                                        Calendar.current.isDate(
                                            day,
                                            inSameDayAs: selectedDate
                                        ) ? Color.cyan : .clear
                                    )
                                    .clipShape(Circle())
                            }
                        }
                    )
                }
                .overlay(alignment: .trailing) {
                    Rectangle()
                        .frame(width: 1)
                        .foregroundStyle(.gray.opacity(0.3))
                }
            }
            Divider()
                .padding(.horizontal, 9)
            VStack(alignment: .leading, spacing: 10) {
                if Calendar.current.isDate(selectedDate, inSameDayAs: Date.now) {
                    Text("Today")
                        .font(.system(size: 26, weight: .bold))
                } else {
                    Text(
                        selectedDate.formatted(
                            .dateTime.weekday(.wide).day().month(.wide)
                        )
                    )
                    .font(.system(size: 26, weight: .bold))
                }
                if let description = viewModel.isDateHoliday(selectedDate) {
                    HStack {
                        Text(description)
                    }
                    .padding(.leading, 20)
                    .overlay(alignment: .leading) {
                        Capsule()
                            .frame(width: 4)
                            .foregroundStyle(viewModel.checkDateColor(selectedDate))
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onChange(of: selectedMonth) {
            updateSelectedDate()
        }
        .onChange(of: selectedYear) {
            updateSelectedDate()
        }
    }
    func updateSelectedDate() {
        currentMonth = Calendar.current.date(
            from: DateComponents(
                year: selectedYear,
                month: selectedMonth,
                day: 1
            )
        )!
    }
}
