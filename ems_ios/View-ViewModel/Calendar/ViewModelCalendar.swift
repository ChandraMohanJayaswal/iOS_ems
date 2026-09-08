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
    APIGetPublicHolidays, APIGetWeekends, APIGetPersonalLeaves {}
final class ViewModelPublicHolidaysService:
    ViewModelPublicHolidaysServiceProtocol {
    deinit {
        print("ViewModelPublicHolidaysService deinitialized")
    }
}
struct Holiday {
    let identfiable: UUID = UUID()
    let date: Date
    let description: String
}
final class ViewModelPublicHolidays: ObservableObject {
    @Published var holidayList: [Holiday] = []
    @Published var fiscalYearList: [FiscalYear]
    @Published var uiState: UISTATE = .idle
    @Published var leaveRequests: [PersonalLeave] = []
    @Published var selectedFilter: LeaveStatusType = .all
    var filteredLeaveRequests: [PersonalLeave] {
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
            self.uiState = .idle
        }
    }
    func fetchPublicHolidaysFromServer() async {
        var list: [PublicHoliday] = []
        self.uiState = .loading
        await apiService.getPublicHolidays(
            success: { result in
                for item in result {
                    list.append(item)
                }
                self.uiState = .idle
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
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
                print("Appending holiday....")
                holidayList.append(
                    Holiday(date: date, description: description)
                )
            }
        }
    }
    func checkDateColor(_ date: Date) -> Color {
        let isBeforeCurrentMonth = date < Calendar.current.dateInterval(
            of: .month,
            for: .now
        )!.start
        for holiday in holidayList {
            let isHoliday = Calendar.current.isDate(
                date,
                inSameDayAs: holiday.date
            )
            if isHoliday {
                if holiday.description.contains("Weekend") {
                    return lightGray
                } else {
                    if date < Date.now {
                        return darkRed
                    } else {
                        return .red
                    }
                }
            }
        }
        if isBeforeCurrentMonth {
            return warmGray
        }
        return .primary
    }
    func isPublicHoliday(_ date: Date) -> Bool {
        for holiday in holidayList {
            let isHoliday = Calendar.current.isDate(
                date,
                inSameDayAs: holiday.date
            )
            if isHoliday && !holiday.description.contains("Weekend") {
                return true
            }
        }
        return false
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
    func getPersonalLeaves() async {
        await apiService.getPersonalLeaves { leaveRequests in
            self.leaveRequests = leaveRequests
        } failure: { error in
            print(error.localizedDescription)
        }
    }
    func fetchHolidaysList() async {
        holidayList = []
        await fetchPublicHolidaysFromServer()
        await fetchWeekends()
        await getPersonalLeaves()
    }

    deinit {
        print("ViewModelPublicHolidays deinitialized")
    }
}
