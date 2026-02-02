//
//  APIGetFiscalYear.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Foundation
protocol APIGetFiscalYear{
    func getFiscalYear(completion: @escaping([FiscalYear])->Void) async
}
extension APIGetFiscalYear{
    func getFiscalYear(completion: @escaping([FiscalYear]) -> Void) async{
        let apiClient = DefaultAPIClient<EndPointFiscalYear>()
        do {
            let data = try await apiClient.request(EndPointFiscalYear.getFiscalYear)
            let decoded = try JSONDecoder().decode(FiscalYearAPIResponse.self, from: data)
            completion(decoded.data?.fiscalYearList ?? [])
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
