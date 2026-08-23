//
//  APIGetWeekends.swift
//  ems_ios
//
//  Created by MacMini on 23/08/2026.
//
import Foundation
protocol APIGetWeekends {
    func getWeekends(completion: @escaping ([Weekend]) -> Void) async
}
extension APIGetWeekends {
    func getWeekends(completion: @escaping ([Weekend]) -> Void) async {
        let apiClient = DefaultAPIClient<EndPointWeekend>()
        do {
            let data = try await apiClient.request(EndPointWeekend.getWeekend)
            let decoded = try JSONDecoder().decode(
                WeekendResponse.self,
                from: data
            )
            if let weekendList = decoded.weekendData?.weekendList?.data {
                completion(weekendList)
            }
        } catch {
            print("Error in fetching public holiday")
        }

    }
}
