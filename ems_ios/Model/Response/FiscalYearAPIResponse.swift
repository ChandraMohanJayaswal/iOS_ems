//
//  FiscalYearAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 08/01/2026.
//
import Foundation
struct FiscalYearAPIResponse:Decodable{
    let data: FiscalYearResponseData?
    enum CodingKeys: String, CodingKey{
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = container.decodeSafe(FiscalYearResponseData.self, forKey: .data)
    }
}

struct FiscalYearResponseData:Decodable{
    let fiscalYearList: [FiscalYear]?
    enum CodingKeys: String, CodingKey{
        case fiscalYearList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fiscalYearList = container.decodeSafe([FiscalYear].self, forKey: .fiscalYearList)
    }
}
