//
//  FiscalYear.swift
//  ems_ios
//
//  Created by Chandra Jayaswal on 12/01/2026.
//

import Foundation

struct FiscalYear:Decodable, Identifiable{
    let id: Int?
    let fiscalYear:String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case fiscalYear = "fiscalYear"
    }
    init(id: Int?, fiscalYear: String?){
        self.id = id
        self.fiscalYear = fiscalYear
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        } catch  {
            print("Failed to decode id: ", error.localizedDescription)
            self.id = nil
        }
        do{
            self.fiscalYear = try container.decodeIfPresent(String.self, forKey: .fiscalYear)
        }
        catch{
            print("Failed to decode fiscalYear: ", error.localizedDescription)
            self.fiscalYear = nil
        }
    }
}

