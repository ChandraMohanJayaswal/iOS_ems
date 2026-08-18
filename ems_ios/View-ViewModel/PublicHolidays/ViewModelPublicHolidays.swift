//
//  ViewModelPublicHolidays.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//

import Combine
import Foundation
import KeychainSwift

protocol ViewModelPublicHolidaysServiceProtocol: APIGetFiscalYear,
    APIGetPublicHolidays {}
final class ViewModelPublicHolidaysService:
    ViewModelPublicHolidaysServiceProtocol {}
final class ViewModelPublicHolidays: ObservableObject {
    @Published var allpublicHolidayList: [PublicHolidaysAPIResponseDetails]
    @Published var searchedPublicHolidayList: [PublicHolidaysAPIResponseDetails]
    @Published var fiscalYearList: [FiscalYear]
    @Published var selectedYear: Int
    @Published var uiState: UISTATE = .idle
    private let apiService: ViewModelPublicHolidaysServiceProtocol
    init(
        apiService: ViewModelPublicHolidaysServiceProtocol =
            ViewModelPublicHolidaysService()
    ) {
        self.apiService = apiService
        self.allpublicHolidayList = []
        self.searchedPublicHolidayList = []
        self.fiscalYearList = []
        self.selectedYear = 0
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
    func searchPublicHolidays() {
        if selectedYear == 0 {
            searchedPublicHolidayList = allpublicHolidayList
        } else {
            self.searchedPublicHolidayList.removeAll()
            for item in self.allpublicHolidayList
            where item.fiscalYear?.id == selectedYear {
                searchedPublicHolidayList.append(item)
            }
        }
        sortPublicHolidayList()
    }
    func fetchPublicHolidaysFromServer() async {
        self.uiState = .loading
        self.allpublicHolidayList.removeAll()
        await apiService.getPublicHolidays { result in
            for item in result {
                self.allpublicHolidayList.append(item)
            }
        }
        self.uiState = .idle
        self.sortPublicHolidayList()
    }
    func sortPublicHolidayList() {
        searchedPublicHolidayList.sort(by: {
            $0.epochDate  ?? 0.00 < $1.epochDate ?? 0.00
        })
    }
    func checkDatePassed(_ epochDate: Double?) -> Bool {
        guard let epochDate = epochDate else {
            print("No date")
            return false
        }
        let epoch: TimeInterval  = TimeInterval(epochDate)
        let date = Date(timeIntervalSince1970: epoch)
        if date < Date.now {
            return true
        } else {
            return false
        }
    }
    func truncateFiscalYear(_ string: String?) -> String {
        guard let string else {
            print("No string")
            return ""
        }
        var truncatedString: String = ""
        let lookUpArray: [Int] = [10, 11, 15, 16]
        for (index, character) in string.enumerated() {
            if lookUpArray.contains(index) {
                truncatedString.append(character)
            }
            if index == 11 {
                truncatedString.append("-")
            }
        }
        return truncatedString
    }
}
