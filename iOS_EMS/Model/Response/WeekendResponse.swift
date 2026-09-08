//
//  WeekendResponse.swift
//  iOS_EMS
//
//  Created by MacMini on 23/08/2026.
//

struct WeekendResponse: Codable {
    let weekendList: WeekendData?
    enum CodingKeys: String, CodingKey {
        case weekendList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weekendList = container.decodeSafe(
            WeekendData.self,
            forKey: .weekendList
        )
    }
}
struct WeekendData: Codable {
    let weekendData: [Weekend]?
    enum CodingKeys: String, CodingKey {
        case weekendData = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weekendData = container.decodeSafe([Weekend].self, forKey: .weekendData)
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
