//
//  LeaveType.swift
//  ems_ios
//
//  Created by Chandra Jayaswal on 12/01/2026.
//

import Foundation

struct LeaveType: Decodable{
    let id:Int?
    let typeOfLeave: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case typeOfLeave = "applyFor"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try container.decode(Int.self, forKey: .id)
        } catch  {
            print("Failed to decode id: ", error.localizedDescription)
            self.id = nil
        }
        
        do {
            self.typeOfLeave = try container.decode(String.self, forKey: .typeOfLeave)
        } catch  {
            print("Failed to decode typeOfLeave: ", error.localizedDescription)
            self.typeOfLeave = nil
        }
    }
}
