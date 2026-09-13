//
//  HoursCard.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import Charts
import SwiftUI

struct HoursCard: View {
    let hoursData: [(String, Int)]
    let workedHours: Int?
    let workingHours: Int?

    var body: some View {
        HomeCard {
            CardHeader(icon: "clock.fill", title: "Monthly Hours")

            Chart(hoursData, id: \.0) { item in
                SectorMark(
                    angle: .value("Hours", item.1),
                    innerRadius: .ratio(0.62),
                    angularInset: 3
                )
                .cornerRadius(6)
                .foregroundStyle(by: .value("Type", item.0))
            }
            .chartForegroundStyleScale([
                "Worked": blue,
                "Remaining": red
            ])
            .frame(height: 200)

            StatRow(stats: [
                StatData(
                    value: "\(workedHours ?? 0)",
                    title: "Worked Hours",
                    color: blue
                ),
                StatData(
                    value: "\(workingHours ?? 0)",
                    title: "Total Working Hours",
                    color: .green
                ),
            ])
        }
    }
}