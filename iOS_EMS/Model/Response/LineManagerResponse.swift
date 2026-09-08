//
//  LineManagerResponse.swift
//  iOS_EMS
//
//  Created by MacMini on 23/08/2026.
//

struct LineManagerResponse: Codable {
    let lineManagerList: [LineManager]?
    enum CodingKeys: String, CodingKey {
        case lineManagerList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lineManagerList = container.decodeSafe([LineManager].self, forKey: .lineManagerList)
    }
}
struct LineManager: Codable, Identifiable {
    let id: Int
    let fullName: String?
}
