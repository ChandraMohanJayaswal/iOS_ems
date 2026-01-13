//
//  Role.swift
//  ems_ios
//
//  Created by Chandra Jayaswal on 12/01/2026.
//

import Foundation

struct Role: Decodable{
    let title: String?
    enum CodingKeys: String, CodingKey{
        case title = "title"
    }
    init(from decoder: any Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            title = try container.decodeIfPresent(String.self, forKey: .title)
        }
        catch{
            print("Failed to decode title: ", error.localizedDescription)
            title = nil
        }
    }
}
