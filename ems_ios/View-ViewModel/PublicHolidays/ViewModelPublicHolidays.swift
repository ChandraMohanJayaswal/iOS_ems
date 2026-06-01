//
//  ViewModelPublicHolidays.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//

import Foundation
import Combine
import KeychainSwift
protocol ViewModelPublicHolidaysServiceProtocol: APIGetFiscalYear, APIGetPublicHolidays{}
final class ViewModelPublicHolidaysService: ViewModelPublicHolidaysServiceProtocol{}
final class ViewModelPublicHolidays: ObservableObject{
    @Published var allpublicHolidayList : [PublicHolidaysAPIResponseDetails]
    @Published var searchedPublicHolidayList : [PublicHolidaysAPIResponseDetails]
    @Published var fiscalYearList: [FiscalYear]
    @Published var selectedYear: String
    @Published var uiState: UISTATE = .idle
    private let apiService: ViewModelPublicHolidaysServiceProtocol
    init(apiService: ViewModelPublicHolidaysServiceProtocol = ViewModelPublicHolidaysService()) {
        self.apiService = apiService
        self.allpublicHolidayList = []
        self.searchedPublicHolidayList = []
        self.fiscalYearList = []
        self.selectedYear = "All"
    }
    func fetchFiscalYearFromServer () async {
        self.uiState = .loading
        self.fiscalYearList = []
        await apiService.getFiscalYear { (result) in
            for item in result{
                self.fiscalYearList.append(item)
            }
        }
        self.uiState = .idle
    }
    func searchPublicHolidays() {
        if selectedYear == "All"{
            searchedPublicHolidayList = allpublicHolidayList
        }
        else {
            self.searchedPublicHolidayList.removeAll()
            for item in self.allpublicHolidayList{
                if item.fiscalYear?.fiscalYear == selectedYear{
                    searchedPublicHolidayList.append(item)
                }
            }
        }
        sortPublicHolidayList()
    }
    func fetchPublicHolidaysFromServer() async {
        self.uiState = .loading
        self.allpublicHolidayList.removeAll()
        await apiService.getPublicHolidays{ result in
            for item in result {
                self.allpublicHolidayList.append(item)
            }
        }
        self.uiState = .idle
        self.sortPublicHolidayList()
    }
    func sortPublicHolidayList() {
        searchedPublicHolidayList.sort(by: {$0.dateString ?? Date() < $1.dateString ?? Date()})
    }
    func truncateFiscalYear(_ string: String?) -> String {
        guard let string else {
            print("No string")
            return ""
        }
        var truncatedString: String  = ""
        var lookUpArray: [Int] = [10, 11, 15, 16]
        for (index, character) in  string.enumerated() {
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
