//
//  PublicHolidayAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//

struct PublicHolidayAPIResponse: Codable{
    let data : PublicHolidaysAPIResponseList
}
struct PublicHolidaysAPIResponseList: Codable{
    let list : [PublicHolidaysAPIResponseDetails]
}
struct PublicHolidaysAPIResponseDetails: Codable, Identifiable{
    let id: Int
    let fiscalYearRes: PublicHolidaysAPIResponseFiscalYearRes
    let date: String
    let description: String
}
struct PublicHolidaysAPIResponseFiscalYearRes: Codable, Identifiable{
    let id: Int
    let fiscalYear: String
    let showingYear: String
}
