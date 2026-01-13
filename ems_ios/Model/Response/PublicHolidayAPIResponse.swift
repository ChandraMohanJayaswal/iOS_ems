//
//  PublicHolidayAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 30/12/2025.
//
import Foundation
struct PublicHolidayAPIResponse: Decodable{
    let data : PublicHolidaysAPIResponseList?
    enum CodingKeys: String, CodingKey{
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            
            self.data = try container.decode(PublicHolidaysAPIResponseList.self, forKey: .data)
        }
        catch{
            print("Failed to decode data", error.localizedDescription)
            self.data = nil
        }
    }
}

struct PublicHolidaysAPIResponseList: Decodable{
    let publicHolidayList : [PublicHolidaysAPIResponseDetails]?
    enum CodingKeys: String, CodingKey{
        case publicHolidayList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            self.publicHolidayList = try container.decode([PublicHolidaysAPIResponseDetails].self, forKey: .publicHolidayList)
        }
        catch{
            print("Failed to decode list", error.localizedDescription)
            self.publicHolidayList = nil
        }
    }
}

struct PublicHolidaysAPIResponseDetails: Decodable, Identifiable{
    let id: Int?
    let fiscalYear: PublicHoliday?
    let date: String?
    let description: String?
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case fiscalYear = "fiscalYearRes"
        case date = "date"
        case description = "description"
    }
    init(from decoder: any Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do{
            self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        }
        catch{
            print("Failed to decode id: ", error.localizedDescription)
            self.id = nil
        }
        
        do{
            self.fiscalYear = try container.decodeIfPresent(PublicHoliday.self, forKey: .fiscalYear)
        }
        catch{
            print("Failed to decode fiscalYearRes: ", error.localizedDescription)
            self.fiscalYear = nil
        }
        do{
            self.date = try container.decodeIfPresent(String.self, forKey: .date)
        }
        catch{
            print("Failed to decode date: ", error.localizedDescription)
            self.date = nil
        }
        
        do{
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
        }
        catch{
            print("Failed to decode description: ", error.localizedDescription)
            self.description = nil
        }
    }
}

