//
//  WeekendResponse.swift
//  ems_ios
//
//  Created by MacMini on 23/08/2026.
//

struct WeekendResponse: Codable {
    let weekendList: [Weekend]?
    enum CodingKeys: String, CodingKey {
        case weekendList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weekendList = container.decodeSafe(
            [Weekend].self,
            forKey: .weekendList
        )
    }
}
struct Weekend: Codable {
    let id: Int?
    let epochDate: Double?
    enum CodingKeys: String, CodingKey {
        case id
        case epochDate = "weekendDate"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = container.decodeSafe(Int.self, forKey: .id)
        self.epochDate = container.decodeSafe(Double.self, forKey: .epochDate)
    }
}
