//
//  StatRow.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct StatData {
    let value: String
    let title: String
    let color: Color
}

struct StatRow: View {
    let stats: [StatData]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(stats.enumerated()), id: \.offset) { index, stat in
                if index > 0 {
                    Divider()
                        .frame(height: 35)
                }
                MetricStat(
                    value: stat.value,
                    title: stat.title,
                    color: stat.color
                )
            }
        }
    }
}

#Preview {
    StatRow(stats: [
        StatData(value: "15", title: "Worked", color: .green),
        StatData(value: "2", title: "Leave", color: orange),
        StatData(value: "3", title: "Casual", color: red)
    ])
    .padding()
}
