//
//  MetricStat.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct MetricStat: View {
    let value: String
    let title: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.poppins(.bold, size: 17))
                .foregroundStyle(color)

            Text(title)
                .font(.inter(size: 12))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}