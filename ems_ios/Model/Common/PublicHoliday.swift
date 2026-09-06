//
//  PublicHoliday.swift
//  ems_ios
//
//  Created by MacMini on 06/09/2026.
//


import Foundation

struct PublicHoliday: Decodable, Identifiable {
    let id: Int?
    let epochDate: Double?
    let description: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case epochDate = "date"
        case description
    }
    init(id: Int, date: Double?, description: String?) {
        self.id = id
        self.epochDate = date
        self.description = description
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeSafe(Int.self, forKey: .id)
        epochDate = container.decodeSafe(Double.self, forKey: .epochDate)
        description = container.decodeSafe(String.self, forKey: .description)
    }
}
