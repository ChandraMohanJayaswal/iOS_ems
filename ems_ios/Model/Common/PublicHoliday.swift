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
    init(id: Int?, fiscalyear: String?, showingYear: String?){
        self.id = id
        self.fiscalYear = fiscalyear
        self.showingYear = showingYear
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = container.decodeSafe(Int.self, forKey: .id)
        fiscalYear = container.decodeSafe(String.self, forKey: .fiscalYear)
        showingYear = container.decodeSafe(String.self, forKey: .showingYear)
    }
    
}
