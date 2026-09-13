//
//  PeriodPicker.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct PeriodPicker: View {
    @Binding var selectedPeriod: Months

    var body: some View {
        Menu {
            Picker("Period", selection: $selectedPeriod) {
                ForEach(Months.allCases) { period in
                    Text(period.title)
                        .tag(period)
                }
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                Text(selectedPeriod.title)
                    .font(.inter(.semibold, size: 12))
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption2.weight(.bold))
                    .opacity(0.7)
            }
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.accentColor.opacity(0.12))
            )
            .foregroundStyle(Color.accentColor)
        }
        .fixedSize()
    }
}

#Preview {
    PeriodPickerPreview()
}

private struct PeriodPickerPreview: View {
    @State private var selectedPeriod: Months = .fullYear

    var body: some View {
        PeriodPicker(selectedPeriod: $selectedPeriod)
            .padding()
    }
}
