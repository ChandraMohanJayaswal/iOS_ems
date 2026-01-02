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
    let manager  = NetworkManager()
    @Published var allpublicHolidayList : [[String: String]]
    @Published var searchedPublicHolidayList : [[String: String]] = []
    @Published var fiscalYearList: Set<String>
    @Published var selectedYear: String
    init() {
        fiscalYearList = ["All"]
        selectedYear = "All"
        allpublicHolidayList = []
    }
    func fetchFiscalYearFromServer () async{
        await manager.fetchFiscalYear { (result) in
            for item in result {
                self.fiscalYearList.insert(item.fiscalYear)
            }
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
        await manager.fetchPublicHolidays{ list in
            self.allpublicHolidayList.removeAll()
            for item in list{
                let dict = ["date": item.date, "description": item.description, "fiscalYear": item.fiscalYearRes.fiscalYear]
                self.allpublicHolidayList.append(dict)
            }
        }
    }
}
