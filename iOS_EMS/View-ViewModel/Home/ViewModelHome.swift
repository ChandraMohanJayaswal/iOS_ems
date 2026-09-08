import Combine
//
//  ViewModelHome.swift
//  iOS_EMS
//
//  Created by MacMini on 25/12/2025.
//
import Foundation

protocol ViewModelHomeServiceProtocol: APIMetrics {}
final class ViewModelHomeService: ViewModelHomeServiceProtocol {
    deinit {
        print("ViewModelHomeService deinitialized")
    }
}


class ViewModelHome: ObservableObject {
    let apiService: ViewModelHomeServiceProtocol
    @Published var metrics: Metrics?
    @Published var selectedPeriod: Months = Months(
        rawValue: Calendar.current.component(.month, from: Date())
    ) ?? .fullYear
    var data: [(String, Int)] {
        guard let metrics else { return [] }
        return [
            ("Working", metrics.totalWorkingDays ?? 30),
            ("Worked", metrics.totalWorkedDays ?? 10),
            ("Leave", metrics.totalLeave ?? 20)
        ]
    }
    init(apiService: ViewModelHomeServiceProtocol = ViewModelHomeService()) {
        self.apiService = apiService
    }
    func getMetrics() async {
        await getMetrics(month: selectedPeriod.month)
    }
    func getMetrics(month: Int?) async {
        await apiService.getMetrics(
            month: month,
            success: { metrics in
                dump(metrics)
                self.metrics = metrics
            },
            failure: { error in
                print(error.localizedDescription)
            }
        )
    }

    deinit {
        print("ViewModelHome deinitialized")
    }
}
