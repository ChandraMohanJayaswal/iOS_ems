//
//  DayButton.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct DayButton: View {
    let day: Date
    let isSelected: Bool
    let isPublicHoliday: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .top) {
                if isPublicHoliday {
                    Circle()
                        .fill(red)
                        .frame(width: 5, height: 5)
                        .offset(y: 2)
                }

                if Calendar.current.isDate(day, inSameDayAs: Date.now) {
                    Circle()
                        .fill(.cyan)
                        .frame(width: 5, height: 5)
                        .offset(y: 2)
                }

                Text(
                    day.formatted(.dateTime.day())
                )
                .font(.inter(isSelected ? .semibold : .regular, size: 14))
                .foregroundStyle(color)
                .frame(width: 34, height: 34)
                .background {
                    if isSelected {
                        Circle()
                            .fill(.cyan.opacity(0.18))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 34)
        }
        .buttonStyle(.plain)
    }
}