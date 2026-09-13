//
//  DateInfoCard.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct DateInfoCard: View {
    let selectedDate: Date
    let holidayNames: [String]
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if Calendar.current.isDate(
                selectedDate,
                inSameDayAs: Date.now
            ) {
                Text("Today")
                    .font(.poppins(.bold, size: 20))
            } else {
                Text(
                    selectedDate.formatted(
                        .dateTime
                            .weekday(.wide)
                            .day()
                            .month(.wide)
                    )
                )
                .font(.poppins(.bold, size: 20))
            }

            HStack(alignment: .top, spacing: 12) {
                Text(
                    holidayNames.joined(separator: "\n")
                )
                .padding(.leading)
                .font(.inter(size: 15))
                .foregroundStyle(.secondary)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
                .overlay(alignment: .leading) {
                    Capsule()
                        .fill(color)
                        .frame(width: 4)
                }
                Spacer()
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
#Preview {
    VStack(spacing: 12) {
        DateInfoCard(
            selectedDate: Date.now,
            holidayNames: ["Dashain Holiday", "Tihar Day"],
            color: orange
        )
        DateInfoCard(
            selectedDate: Date.now.addingTimeInterval(86400),
            holidayNames: [],
            color: blue
        )
    }
    .padding()
    .background(Color(uiColor: .systemGroupedBackground))
}
