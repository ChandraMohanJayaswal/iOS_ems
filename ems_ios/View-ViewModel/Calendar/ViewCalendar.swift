//
//  Calendar.swift
//  ems_ios
//
//  Created by MacMini on 19/08/2026.
//
import SwiftUI

struct ViewCalendar: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelPublicHolidays()
    @State var isSheetPresented: Bool = false
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)

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
    var body: some View {
        ScrollView {
            // MARK: - Month / Year Picker
            HStack(spacing: 4) {
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(
                            DateComponents(
                                calendar: .current,
                                month: month
                            )
                            .date?
                            .formatted(.dateTime.month(.wide)) ?? ""
                        )
                        .tag(month)
                    }
                }
                .fixedSize(horizontal: true, vertical: false)
                .tint(.primary)

                Picker("Year", selection: $selectedYear) {
                    ForEach(2020...2030, id: \.self) { year in
                        Text(verbatim: "\(year)")
                            .tag(year)
                    }
                }
                .tint(.primary)

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
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.cyan)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)

            // MARK: - Calendar

            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    ForEach(daysOfWeek.indices, id: \.self) { index in
                        Text(daysOfWeek[index])
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 8)

                Divider()
                    .padding(.horizontal, 12)
                LazyVGrid(
                    columns: columns,
                    spacing: 8
                ) {
                    ForEach(
                        currentMonth.daysInTheMonth,
                        id: \.self
                    ) { day in

                        Button {
                            selectedDate = day
                        } label: {
                            ZStack(alignment: .top) {

                                // Today indicator
                                if Calendar.current.isDate(
                                    day,
                                    inSameDayAs: Date.now
                                ) {
                                    Circle()
                                        .fill(.cyan)
                                        .frame(width: 5, height: 5)
                                        .offset(y: 2)
                                }

                                Text(
                                    day.formatted(
                                        .dateTime.day()
                                    )
                                )
                                .font(
                                    .system(
                                        size: 14,
                                        weight: Calendar.current.isDate(
                                            day,
                                            inSameDayAs: selectedDate
                                        )
                                            ? .semibold
                                            : .regular
                                    )
                                )
                                .foregroundStyle(
                                    viewModel.checkDateColor(day)
                                )
                                .frame(
                                    width: 34,
                                    height: 34
                                )
                                .background {
                                    if Calendar.current.isDate(
                                        day,
                                        inSameDayAs: selectedDate
                                    ) {
                                        Circle()
                                            .fill(.cyan.opacity(0.18))
                                    }
                                }
                            }
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: 34
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 8)
                Divider()
                    .padding(.horizontal, 12)
                    .padding(.top, 4)
            }
//            .padding(.top, 8)

            // MARK: - Selected Date Information
            VStack(alignment: .leading, spacing: 12) {
                if Calendar.current.isDate(
                    selectedDate,
                    inSameDayAs: Date.now
                ) {
                    Text("Today")
                        .font(.title3.weight(.bold))
                } else {
                    Text(
                        selectedDate.formatted(
                            .dateTime
                                .weekday(.wide)
                                .day()
                                .month(.wide)
                        )
                    )
                    .font(.title3.weight(.bold))
                }

                HStack(alignment: .top, spacing: 12) {
                    Text(
                        viewModel
                            .isDateHoliday(selectedDate)
                            .joined(separator: "\n")
                    )
                    .padding(.leading)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .overlay(alignment: .leading) {
                        Capsule()
                            .fill(viewModel.checkDateColor(selectedDate))
                            .frame(width: 4)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                Color.primary.opacity(0.035)
            )
            // MARK: - Personal Leaves
            VStack(spacing: 12) {
                HStack {
                    Text("Personal Leaves")
                        .font(.title3.weight(.bold))
                    Spacer()
                    Button {
                        isSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 30, height: 30)
                            .background(.cyan)
                            .clipShape(Circle())
                    }
                    .accessibilityIdentifier(
                        "requestALeaveButton"
                    )
                }

                Picker(
                    "Leave Status",
                    selection: $viewModel.selectedFilter
                ) {
                    ForEach(LeaveStatusType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            // MARK: - Leave Requests
                LazyVStack(
                    alignment: .leading,
                    spacing: 0
                ) {
                    ForEach(
                        viewModel.filteredLeaveRequests
                    ) { item in
                        LeaveRequestItem(
                            leaveType: item.leaveTypeRes?.typeOfLeave,
                            createdDateTime: item.createdEpoch,
                            leaveFromDate: item.leaveFromDate,
                            leaveToDate: item.leaveToDate,
                            description: item.description,
                            leaveStatus: item.leaveStatusRes?.statusType?
                                .rawValue,
                            comment: item.statusComment
                        )
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)

                        Divider()
                            .padding(.horizontal, 16)
                    }
                }
        }
        .header(title: "Calendar")
        .sheet(isPresented: $isSheetPresented) {
            NavigationStack {
                ViewRequestLeave()
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
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
