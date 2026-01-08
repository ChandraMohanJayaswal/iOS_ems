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
    @Published var allpublicHolidayList : [[String: String]]
    @Published var searchedPublicHolidayList : [[String: String]]
    @Published var fiscalYearList: [String]
    @Published var selectedYear: String
    init() {
        self.allpublicHolidayList = []
        self.searchedPublicHolidayList = []
        self.fiscalYearList = ["All"]
        self.selectedYear = "All"
    }
    func fetchFiscalYearFromServer () async{
        fiscalYearList = ["All"]
        let apiClient = DefaultAPIClient<FiscalYearEndPoint>()
        do {
            let data = try await apiClient.request(FiscalYearEndPoint.getFiscalYear)
            let decoded = try JSONDecoder().decode(FiscalYearAPIResponse.self, from: data)
            for year in decoded.data.list{
                fiscalYearList.append(year.fiscalYear)
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func searchPublicHolidays(){
        if selectedYear == "All"{
            searchedPublicHolidayList = allpublicHolidayList
        }
        else {
            self.searchedPublicHolidayList.removeAll()
            for item in self.allpublicHolidayList{
                if item["fiscalYear"] == self.selectedYear{
                    self.searchedPublicHolidayList.append(item)
                }
            }
        }
    }
    func fetchPublicHolidaysFromServer() async{
        self.allpublicHolidayList.removeAll()
        let apiClient = DefaultAPIClient<FiscalYearEndPoint>()
        do{
            let data = try await apiClient.request(FiscalYearEndPoint.getPublicHoliday)
            let decoded = try JSONDecoder().decode(PublicHolidayAPIResponse.self, from: data)
            for item in decoded.data.list{
                let dict = ["date": item.date, "description": item.description, "fiscalYear": item.fiscalYearRes.fiscalYear]
                self.allpublicHolidayList.append(dict)
            }
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
