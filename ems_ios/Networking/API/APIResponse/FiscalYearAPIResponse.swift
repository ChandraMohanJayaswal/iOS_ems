//
//  FiscalYearAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 08/01/2026.
//

struct FiscalYearAPIResponse:Decodable{
    let data: FiscalYearResponseData
}
struct FiscalYearResponseData:Decodable{
    let list: [FiscalYearAPIResponseFiscalYear]
}
struct FiscalYearAPIResponseFiscalYear:Decodable, Identifiable{
    let id: Int
    let fiscalYear:String
}

