//
//  HomeHeader.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct HomeHeader: View {
    @Binding var selectedPeriod: Months
    let fiscalYear: String?
    let currentMonth: String?

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            PeriodPicker(selectedPeriod: $selectedPeriod)
            Text("\(fiscalYear ?? "") \(currentMonth ?? "")")
                .font(.inter(.semibold, size: 12))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.accentColor.opacity(0.12))
                )
                .foregroundStyle(Color.accentColor)
            Spacer()
        }
    }
}