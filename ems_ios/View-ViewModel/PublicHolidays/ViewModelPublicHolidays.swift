//
//  ViewModelPublicHolidays.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//

import Foundation
import Combine
import KeychainSwift

class ViewModelPublicHolidays: ObservableObject{
    @Published var allpublicHolidayList : [PublicHolidaysAPIResponseDetails]
    @Published var searchedPublicHolidayList : [PublicHolidaysAPIResponseDetails]
    @Published var fiscalYearList: [FiscalYearAPIResponseFiscalYear]
    @Published var selectedYear: String
    @Published var uiState: UISTATE = .idle
    init() {
        self.allpublicHolidayList = []
        self.searchedPublicHolidayList = []
        self.fiscalYearList = []
        self.selectedYear = "All"
    }
    func fetchFiscalYearFromServer () async{
        self.uiState = .loading
        fiscalYearList = []
        let apiClient = DefaultAPIClient<FiscalYearEndPoint>()
        do {
            let data = try await apiClient.request(FiscalYearEndPoint.getFiscalYear)
            let decoded = try JSONDecoder().decode(FiscalYearAPIResponse.self, from: data)
            for item in decoded.data.list{
                fiscalYearList.append(item)
            }
        }
        catch{
            print(error.localizedDescription)
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
                if item.fiscalYearRes.fiscalYear == selectedYear{
                    searchedPublicHolidayList.append(item)
                }
            }
        }
    }
    func fetchPublicHolidaysFromServer() async{
        self.uiState = .loading
        self.allpublicHolidayList.removeAll()
        let apiClient = DefaultAPIClient<FiscalYearEndPoint>()
        do{
            let data = try await apiClient.request(FiscalYearEndPoint.getPublicHoliday)
            let decoded = try JSONDecoder().decode(PublicHolidayAPIResponse.self, from: data)
            for item in decoded.data.list{
                self.allpublicHolidayList.append(item)
            }
            
        }
        catch{
            print(error.localizedDescription)
        }
        self.uiState = .idle
    }
    func truncateDescription(_ text: String) ->String{
        return String(text.prefix(5) + "...")
    }
}
