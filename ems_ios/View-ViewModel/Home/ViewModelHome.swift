import Combine
//
//  ViewModelHome.swift
//  ems_ios
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

enum HomeMetricsPeriod: Int, CaseIterable, Identifiable {
    case fullYear = 0
    case january = 1
    case february = 2
    case march = 3
    case april = 4
    case may = 5
    case june = 6
    case july = 7
    case august = 8
    case september = 9
    case october = 10
    case november = 11
    case december = 12

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .fullYear: return "Full Year"
        case .january: return "January"
        case .february: return "February"
        case .march: return "March"
        case .april: return "April"
        case .may: return "May"
        case .june: return "June"
        case .july: return "July"
        case .august: return "August"
        case .september: return "September"
        case .october: return "October"
        case .november: return "November"
        case .december: return "December"
        }
    }

    var month: Int? {
        self == .fullYear ? nil : rawValue
    }
}

class ViewModelHome: ObservableObject {
    let apiService: ViewModelHomeServiceProtocol
    @Published var metrics: Metrics?
    @Published var selectedPeriod: HomeMetricsPeriod = HomeMetricsPeriod(
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
