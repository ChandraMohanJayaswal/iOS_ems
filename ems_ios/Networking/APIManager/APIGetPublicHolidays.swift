//
//  APIGetPublicHolidays.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Foundation
protocol APIGetPublicHolidays{
    func getPublicHolidays(completion: @escaping([PublicHolidaysAPIResponseDetails])-> Void) async
}
extension APIGetPublicHolidays{
    func getPublicHolidays(completion:@escaping([PublicHolidaysAPIResponseDetails])->Void) async{
        let apiClient = DefaultAPIClient<EndPointFiscalYear>()
        do{
            let data = try await apiClient.request(EndPointFiscalYear.getPublicHoliday)
            let decoded = try JSONDecoder().decode(PublicHolidayAPIResponse.self, from: data)
            if let publicHolidayList =  decoded.data?.publicHolidayList{
                completion(publicHolidayList)
            }
        }
        catch{
            print("Error in fetching public holiday")
        }
    }
}
