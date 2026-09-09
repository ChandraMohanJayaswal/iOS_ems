//
//  MetricsResponse.swift
//  iOS_EMS
//
//  Created by MacMini on 06/09/2026.
//

import Foundation

struct MetricsResponse: Codable {
    let metrics: Metrics?
    enum CodingKeys: String, CodingKey {
        case metrics = "dashboardMetrics"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.metrics = container.decodeSafe(Metrics.self, forKey: .metrics)
    }
}
struct Metrics: Codable {
    let totalWorkingDays: Int?
    let totalWorkedDays: Int?
    let totalLeave: Int?
    let balanceCasualLeave: Double?
    let balanceSickLeave: Double?
    let fiscalYear: String?
    let currentMonth: String?
    let totalWorkingHours: Int?
    let totalWorkedHours: Int?
    enum CodingKeys: String, CodingKey {
        case totalWorkingDays, totalWorkedDays, totalLeave, balanceCasualLeave,
            balanceSickLeave, fiscalYear, currentMonth, totalWorkingHours, totalWorkedHours
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalWorkingDays = container.decodeSafe(Int.self, forKey: .totalWorkingDays)
        self.totalWorkedDays = container.decodeSafe(Int.self, forKey: .totalWorkedDays)
        self.totalLeave = container.decodeSafe(Int.self, forKey: .totalLeave)
        self.balanceCasualLeave = container.decodeSafe(Double.self, forKey: .balanceCasualLeave)
        self.balanceSickLeave = container.decodeSafe(Double.self, forKey: .balanceSickLeave)
        self.fiscalYear = container.decodeSafe(String.self, forKey: .fiscalYear)
        self.currentMonth = container.decodeSafe(String.self, forKey: .currentMonth)
        self.totalWorkingHours = container.decodeSafe(Int.self, forKey: .totalWorkingHours)
        self.totalWorkedHours = container.decodeSafe(Int.self, forKey: .totalWorkedHours)
    }
}
