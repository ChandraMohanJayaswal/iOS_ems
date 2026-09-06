//
//  ViewModelHome.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//
import Foundation
import Combine

protocol ViewModelHomeServiceProtocol: APIMetrics {}
final class ViewModelHomeService: ViewModelHomeServiceProtocol {}

class ViewModelHome: ObservableObject {
    let apiService: ViewModelHomeServiceProtocol
    @Published var metrics: Metrics?
    init(apiService: ViewModelHomeServiceProtocol = ViewModelHomeService()) {
        self.apiService = apiService
    }
    func getMetrics() async {
        await apiService.getMetrics(success: { metrics in
            dump(metrics)
            self.metrics = metrics
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
}
