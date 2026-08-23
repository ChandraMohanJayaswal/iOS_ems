//
//  ViewModelPublicHolidays.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//

import Combine
import Foundation
import KeychainSwift
import SwiftUI

protocol ViewModelPublicHolidaysServiceProtocol: APIGetFiscalYear,
    APIGetPublicHolidays, APIGetWeekends, APIGetMyLeaveRequests {}
final class ViewModelPublicHolidaysService:
    ViewModelPublicHolidaysServiceProtocol {}
struct Holiday {
    let identfiable: UUID = UUID()
    let date: Date
    let description: String
}
final class ViewModelPublicHolidays: ObservableObject {
    @Published var holidayList: [Holiday] = []
    @Published var fiscalYearList: [FiscalYear]
    @Published var uiState: UISTATE = .idle
    @Published var leaveRequests: [LeaveRequest] = []
    @Published var selectedFilter: LeaveStatusType = .all
    var filteredLeaveRequests: [LeaveRequest] {
        if self.selectedFilter == .all {
            return leaveRequests
        } else {
            return leaveRequests.filter {
                $0.leaveStatusRes?.statusType == self.selectedFilter
            }
        }
    }
    private let apiService: ViewModelPublicHolidaysServiceProtocol
    init(
        apiService: ViewModelPublicHolidaysServiceProtocol =
            ViewModelPublicHolidaysService()
    ) {
        self.apiService = apiService
        self.fiscalYearList = []
    }
    func fetchFiscalYearFromServer() async {
        self.uiState = .loading
        self.fiscalYearList = []
        await apiService.getFiscalYear { (result) in
            for item in result {
                self.fiscalYearList.append(item)
            }
        }
        self.uiState = .idle
    }
    func fetchPublicHolidaysFromServer() async {
        var list: [PublicHolidaysAPIResponseDetails] = []
        self.uiState = .loading
        await apiService.getPublicHolidays { result in
            for item in result {
                list.append(item)
            }
            self.uiState = .idle
        }
        for holiday in list {
            let date = holiday.epochDate?.date
            let description = holiday.description
            if let date = date, let description = description {
                holidayList.append(
                    Holiday(date: date, description: description)
                )
            }
        }
    }
    func fetchWeekends() async {
        var list: [Weekend] = []
        await apiService.getWeekends { result in
            for item in result {
                list.append(item)
            }
        }
        for item in list {
            let date = item.epochDate?.date
            let description = "Weekend"
            if let date = date {
                holidayList.append(
                    Holiday(date: date, description: description)
                )
            }
        }
    }
    func checkDateColor(_ date: Date) -> Color {
        for holiday in holidayList {
            let isHoliday = Calendar.current.isDate(
                date,
                inSameDayAs: holiday.date
            )
            if isHoliday {
                if date < Date.now {
                    return Color(
                        red: 200 / 255,
                        green: 125 / 255,
                        blue: 125 / 255
                    )
                } else {
                    return .red
                }
            }
        }
        if date < Date.now {
            return .gray
        } else {
            return .primary
        }
    }
    func isDateHoliday(_ date: Date) -> [String] {
        var descriptions: [String] = []
        for holiday in holidayList {
            let isHoliday = Calendar.current.isDate(
                date,
                inSameDayAs: holiday.date
            )
            if isHoliday {
                descriptions.append(holiday.description)
            }
        }
        return descriptions
    }
    func getLeaveRequests() async {
        await apiService.getMyLeaveRequests { leaveRequests in
            self.leaveRequests = leaveRequests
        }
    }
    func fetchHolidaysList() async {
        holidayList = []
        await fetchPublicHolidaysFromServer()
        await fetchWeekends()
        await getLeaveRequests()
    }
}
