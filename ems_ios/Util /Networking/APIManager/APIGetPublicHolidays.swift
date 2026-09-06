//
//  APIGetPublicHolidays.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Foundation
protocol APIGetPublicHolidays {
    func getPublicHolidays(success: @escaping ([PublicHoliday]) -> Void, failure: @escaping (Error) -> Void) async
}
extension APIGetPublicHolidays {
    func getPublicHolidays(success: @escaping ([PublicHoliday]) -> Void, failure: @escaping (Error) -> Void) async {
        let apiClient = DefaultAPIClient<EndPointFiscalYear>()
        do {
            let data = try await apiClient.request(EndPointFiscalYear.getPublicHoliday)
            let decoded = try JSONDecoder().decode(PublicHolidayResponse.self, from: data)
            if let publicHolidayList =  decoded.publicHolidayList {
                success(publicHolidayList)
            }
        } catch {
            failure(error)
            print("Error in fetching public holiday")
        }
    }
}
