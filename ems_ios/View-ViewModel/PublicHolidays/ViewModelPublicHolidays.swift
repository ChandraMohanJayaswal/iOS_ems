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
    func fetchFiscalYearFromServer () async{
        self.uiState = .loading
        self.fiscalYearList = []
        await apiService.getFiscalYear { (result) in
            for item in result{
                self.fiscalYearList.append(item)
            }
        }
        self.uiState = .idle
    }
    func searchPublicHolidays(){
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
    }
    func fetchPublicHolidaysFromServer() async{
        self.uiState = .loading
        self.allpublicHolidayList.removeAll()
        await apiService.getPublicHolidays{ result in
            for item in result{
                self.allpublicHolidayList.append(item)
            }
        }
        self.uiState = .idle
    }
    func truncateDescription(_ text: String) -> String{
        return String(text.prefix(5) + "...")
    }
}
