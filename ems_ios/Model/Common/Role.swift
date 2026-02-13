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
        title = container.decodeSafe(String.self, forKey: .title)
    }
}
