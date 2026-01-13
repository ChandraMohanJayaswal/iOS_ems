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
        do {
            self.data = try container.decode(FiscalYearResponseData.self, forKey: .data)
        } catch  {
            print("Failed to decode data :", error.localizedDescription)
            self.data = nil
        }
    }
}

struct FiscalYearResponseData:Decodable{
    let fiscalYearList: [FiscalYear]?
    enum CodingKeys: String, CodingKey{
        case fiscalYearList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.fiscalYearList = try container.decodeIfPresent([FiscalYear].self, forKey: .fiscalYearList)
        } catch  {
            print("Failed to decode fiscalYearList:" , error.localizedDescription)
            self.fiscalYearList = nil
        }
    }
}
