//
//  PublicHolidayAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//

struct PublicHolidayAPIResponse: Codable{
    let data : PublicHolidaysResponseList
}
struct PublicHolidaysResponseList: Codable{
    let list : [PublicHolidaysResponseDetails]
}
struct PublicHolidaysResponseDetails: Codable{
    let fiscalYearRes: PublicHolidaysResponseFiscalYearRes
    let date: String
    let description: String
}
struct PublicHolidaysResponseFiscalYearRes: Codable{
    let fiscalYear: String
}
