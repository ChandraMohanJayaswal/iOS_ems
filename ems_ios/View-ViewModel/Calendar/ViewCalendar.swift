//
//  Calendar.swift
//  ems_ios
//
//  Created by MacMini on 19/08/2026.
//
import SwiftUI

struct ViewCalendar: View {
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let columns = Array(repeating: GridItem(.flexible(), spacing: 4), count: 7)
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelPublicHolidays()
    @State var isSheetPresented: Bool = false
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
            VStack(spacing: 16) {
                calendarCard
                dateInfoCard
                personalLeavesCard
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
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
        .refreshable {
            Task {
                await viewModel.fetchHolidaysList()
            }
        }
    }

    // MARK: - Calendar Card

    private var calendarCard: some View {
        VStack(spacing: 12) {
            monthYearPicker
            Divider()
            weekDayHeader
            LazyVGrid(
                columns: columns,
                spacing: 8
            ) {
                ForEach(
                    currentMonth.daysInTheMonth,
                    id: \.self
                ) { day in
                    dayButton(for: day)
                }
            }
        }
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var monthYearPicker: some View {
        HStack(spacing: 8) {
            Menu {
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(monthName(month))
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
                        .fill(Color.accentColor.opacity(0.12))
                )
                .foregroundStyle(Color.accentColor)
            }
            .fixedSize()

            Menu {
                Picker("Year", selection: $selectedYear) {
                    ForEach(2020...2030, id: \.self) { year in
                        Text(verbatim: "\(year)")
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
                        .fill(Color.accentColor.opacity(0.12))
                )
                .foregroundStyle(Color.accentColor)
            }
            .fixedSize()

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

    private var weekDayHeader: some View {
        HStack(spacing: 0) {
            ForEach(daysOfWeek.indices, id: \.self) { index in
                Text(daysOfWeek[index])
                    .font(.inter(.semibold, size: 12))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func dayButton(for day: Date) -> some View {
        Button {
            selectedDate = day
        } label: {
            ZStack(alignment: .top) {

                // Public holiday indicator (not weekend)
                if viewModel.isPublicHoliday(day) {
                    Circle()
                        .fill(.red)
                        .frame(width: 5, height: 5)
                        .offset(y: 2)
                }

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
                    .inter(
                        Calendar.current.isDate(
                            day,
                            inSameDayAs: selectedDate
                        )
                            ? .semibold
                            : .regular,
                        size: 14
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

    // MARK: - Selected Date Information Card

    private var dateInfoCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            if Calendar.current.isDate(
                selectedDate,
                inSameDayAs: Date.now
            ) {
                Text("Today")
                    .font(.poppins(.bold, size: 20))
            } else {
                Text(
                    selectedDate.formatted(
                        .dateTime
                            .weekday(.wide)
                            .day()
                            .month(.wide)
                    )
                )
                .font(.poppins(.bold, size: 20))
            }

            HStack(alignment: .top, spacing: 12) {
                Text(
                    viewModel
                        .isDateHoliday(selectedDate)
                        .joined(separator: "\n")
                )
                .padding(.leading)
                .font(.inter(size: 15))
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
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Personal Leaves Card

    private var personalLeavesCard: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Personal Leaves")
                    .font(.poppins(.bold, size: 20))
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

            LazyVStack(
                alignment: .leading,
                spacing: 8
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
                }
            }
        }
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
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

    func monthName(_ month: Int) -> String {
        DateComponents(
            calendar: .current,
            month: month
        )
        .date?
        .formatted(.dateTime.month(.wide)) ?? ""
    }
}