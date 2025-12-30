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
    @Published var publicHolidayList : [[String: String]]
    @Published var fiscalYearList: Set<String>
    @Published var selectedYear: String
//    @Published var
    init() {
        fiscalYearList = ["All"]
        selectedYear = "All"
        publicHolidayList = []
    }
    func fetchFiscalYearFromServer () async{
        await manager.fetchFiscalYear { (result) in
            for item in result {
                self.fiscalYearList.insert(item.fiscalYear)
            }
        }
    }
    func fetchPublicHolidaysFromServer() async{
        await manager.fetchPublicHolidays{ list in
            for item in list{
                let dict = ["date": item.date, "description": item.description, "fiscalYear": item.fiscalYearRes.fiscalYear]
                print(dict)
                self.publicHolidayList.append(dict)
            }
        }
    }
}
