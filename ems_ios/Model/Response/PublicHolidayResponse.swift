//
//  PublicHolidayAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//
import Foundation
struct PublicHolidayResponse: Decodable {
    let publicHolidayList: [PublicHoliday]?
    enum CodingKeys: String, CodingKey {
        case publicHolidayList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        publicHolidayList = container.decodeSafe([PublicHoliday].self, forKey: .publicHolidayList)
    }
}
