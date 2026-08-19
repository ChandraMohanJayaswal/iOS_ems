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
    APIGetPublicHolidays {}
final class ViewModelPublicHolidaysService:
    ViewModelPublicHolidaysServiceProtocol {}
struct PublicHolidayList {
    let date: Date
    let description: String
}
final class ViewModelPublicHolidays: ObservableObject {
    @Published var publicHolidayList: [PublicHolidayList] = []
    @Published var fiscalYearList: [FiscalYear]
    @Published var uiState: UISTATE = .idle
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
                publicHolidayList.append(
                    PublicHolidayList(date: date, description: description)
                )
            }
        }
    }
    func checkDateColor(_ date: Date) -> Color {
        for holiday in publicHolidayList {
            let isHoliday = Calendar.current.isDate(
                date,
                inSameDayAs: holiday.date
            )
            if isHoliday {
                if date < Date.now {
                    return Color(red: 200 / 255, green: 125 / 255, blue: 125 / 255)
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
    func isDateHoliday(_ date: Date) -> String? {
        for holiday in publicHolidayList {
            let isHoliday = Calendar.current.isDate(
                date,
                inSameDayAs: holiday.date
            )
            if isHoliday {
                return holiday.description
            }
        }
        return nil
    }
}
