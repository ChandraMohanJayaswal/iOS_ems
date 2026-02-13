//
//  PublicHolidayAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//
import Foundation
struct PublicHolidayAPIResponse: Decodable{
    let data : PublicHolidaysAPIResponseList?
    enum CodingKeys: String, CodingKey{
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = container.decodeSafe(PublicHolidaysAPIResponseList.self, forKey: .data)
    }
}

struct PublicHolidaysAPIResponseList: Decodable{
    let publicHolidayList : [PublicHolidaysAPIResponseDetails]?
    enum CodingKeys: String, CodingKey{
        case publicHolidayList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        publicHolidayList = container.decodeSafe([PublicHolidaysAPIResponseDetails].self, forKey: .publicHolidayList)
    }
}

struct PublicHolidaysAPIResponseDetails: Decodable, Identifiable{
    let id: Int?
    let fiscalYear: PublicHoliday?
    let date: String?
    let description: String?
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case fiscalYear = "fiscalYearRes"
        case date = "date"
        case description = "description"
    }
    init(id: Int, fiscalYear: PublicHoliday?, date: String?, description: String?){
        self.id = id
        self.fiscalYear = fiscalYear
        self.date = date
        self.description = description
    }
    init(from decoder: any Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeSafe(Int.self, forKey: .id)
        fiscalYear = container.decodeSafe(PublicHoliday.self, forKey: .fiscalYear)
        date = container.decodeSafe(String.self, forKey: .date)
        description = container.decodeSafe(String.self, forKey: .description)
    }
}
