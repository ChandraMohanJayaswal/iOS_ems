//
//  PublicHoliday.swift
//  ems_ios
//
//  Created by MacMini on 12/01/2026.
//
import Foundation
struct PublicHoliday: Codable, Identifiable{
    let id: Int?
    let fiscalYear: String?
    let showingYear: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case fiscalYear = "fiscalYear"
        case showingYear = "showingYear"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            
            self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        }
        catch{
            print("Failed to decode id: ", error.localizedDescription)
            self.id = nil
        }
        do{
            self.fiscalYear = try container.decodeIfPresent(String.self, forKey: .fiscalYear)
        }
        catch{
            print("Failed to decode id: ", error.localizedDescription)
            self.fiscalYear = nil
        }
        do{
            self.showingYear = try container.decodeIfPresent(String.self, forKey: .showingYear)
        }
        catch{
            print("Failed to decode showingYear: ", error.localizedDescription)
            self.showingYear = nil
        }
    }
    
}
