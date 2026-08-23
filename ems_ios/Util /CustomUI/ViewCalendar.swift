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
    @Binding var isSheetPresented: Bool
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
            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(currentMonth.daysInTheMonth, id: \.self) { day in
                    Button(
                        action: {
                            selectedDate = day
                        },
                        label: {
                            ZStack(alignment: .top) {
                                if Calendar.current.isDate(
                                    day,
                                    inSameDayAs: Date.now
                                ) {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .zIndex(1)
                                }
                                Text(day.formatted(.dateTime.day()))
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(maxWidth: .infinity, minHeight: 25)
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
                        .font(.system(size: 20, weight: .bold))
                } else {
                    Text(
                        selectedDate.formatted(
                            .dateTime.weekday(.wide).day().month(.wide)
                        )
                    )
                    .font(.system(size: 20, weight: .bold))
                }
                HStack {
                    Text(viewModel.isDateHoliday(selectedDate).joined(separator: "\n"))
                }
                .padding(.leading, 20)
                .overlay(alignment: .leading) {
                    Capsule()
                        .frame(width: 4)
                        .foregroundStyle(viewModel.checkDateColor(selectedDate))
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                HStack {
                    Text("Personal Leaves")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    Button {
                        isSheetPresented = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .padding(.trailing)
                    .accessibilityIdentifier("requestALeaveButton")

                }
                Picker("Leave Status", selection: $viewModel.selectedFilter) {
                    Text("All").tag(LeaveStatusType.all)
                    Text("Pending").tag(LeaveStatusType.pending)
                    Text("Approved").tag(LeaveStatusType.approved)
                    Text("Rejected").tag(LeaveStatusType.rejected)
                }
                .pickerStyle(.segmented)
            }
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.filteredLeaveRequests) { item in
                        LeaveRequestItem(
                            leaveType: item.leaveTypeRes?.typeOfLeave,
                            createdDateTime: item.createdEpoch,
                            leaveFromDate: item.leaveFromDate,
                            leaveToDate: item.leaveToDate,
                            description: item.description,
                            leaveStatus: item.leaveStatusRes?.statusType?.rawValue,
                            comment: item.statusComment
                        )
                        .padding(.leading)
                        .padding(.vertical, 4)
                        Divider()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchHolidaysList()
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
