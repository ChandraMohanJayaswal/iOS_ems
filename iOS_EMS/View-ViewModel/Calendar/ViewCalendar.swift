//
//  Calendar.swift
//  iOS_EMS
//
//  Created by MacMini on 19/08/2026.
//
import SwiftUI

struct ViewCalendar: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelPublicHolidays()
    @State var isSheetPresented: Bool = false
    @State private var currentMonth: Date = Date.now
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
                CalendarCard(
                    selectedMonth: $selectedMonth,
                    selectedYear: $selectedYear,
                    selectedDate: $selectedDate,
                    currentMonth: currentMonth,
                    isPublicHoliday: viewModel.isPublicHoliday,
                    dayColor: viewModel.checkDateColor
                )
                DateInfoCard(
                    selectedDate: selectedDate,
                    holidayNames: viewModel.isDateHoliday(selectedDate),
                    color: viewModel.checkDateColor(selectedDate)
                )
                PersonalLeavesCard(
                    selectedFilter: $viewModel.selectedFilter,
                    leaveRequests: viewModel.filteredLeaveRequests
                ) {
                    isSheetPresented = true
                }
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