//
//  AttendanceCard.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import Charts
import SwiftUI

struct AttendanceCard: View {
    let chartData: [(String, Double)]
    let totalWorkingDays: Int?
    let totalWorkedDays: Int?
    let totalLeave: Double?
    let casualLeaveBalance: Double?
    let sickLeaveBalance: Double?

    var body: some View {
        HomeCard {
            CardHeader(icon: "calendar", title: "Monthly Attendance")

            Chart(chartData, id: \.0) { item in
                BarMark(
                    x: .value("Type", item.0),
                    y: .value("Days", item.1)
                )
                .foregroundStyle(by: .value("Type", item.0))
            }
            .chartForegroundStyleScale([
                "Working": blue,
                "Worked": .green,
                "Leave": orange
            ])
            .frame(height: 250)

            StatRow(stats: [
                StatData(
                    value: "\(totalWorkingDays ?? 0)",
                    title: "Working",
                    color: blue
                ),
                StatData(
                    value: "\(totalWorkedDays ?? 0)",
                    title: "Worked",
                    color: .green
                ),
                StatData(
                    value: "\(totalLeave ?? 0)",
                    title: "Leave",
                    color: orange
                )
            ])

            StatRow(stats: [
                StatData(
                    value: "\(casualLeaveBalance ?? 0)",
                    title: "Casual leave",
                    color: red
                ),
                StatData(
                    value: "\(sickLeaveBalance ?? 0)",
                    title: "Sick leave",
                    color: amber
                )
            ])
        }
    }
}

#Preview {
    AttendanceCard(
        chartData: [
            ("Working", 20),
            ("Worked", 15),
            ("Leave", 2)
        ],
        totalWorkingDays: 20,
        totalWorkedDays: 15,
        totalLeave: 2,
        casualLeaveBalance: 3,
        sickLeaveBalance: 4
    )
    .padding()
    .background(Color(uiColor: .systemGroupedBackground))
}
