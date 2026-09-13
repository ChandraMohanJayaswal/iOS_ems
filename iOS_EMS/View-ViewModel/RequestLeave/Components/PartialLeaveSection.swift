//
//  PartialLeaveSection.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct PartialLeaveSection: View {
    @Binding var isPartial: Bool
    @Binding var leaveCount: Double?

    var body: some View {
        Toggle("Partial Leave", isOn: $isPartial)
            .font(.inter(size: 15))
            .toggleStyle(.automatic)
            .onChange(of: isPartial) {
                if !isPartial {
                    leaveCount = nil
                }
            }
        if isPartial {
            Picker("Duration", selection: $leaveCount) {
                Text("Select")
                    .font(.inter(size: 15))
                    .tag(nil as Double?)
                Text("Quarter day")
                    .font(.inter(size: 15))
                    .tag(0.25 as Double?)
                Text("Half day")
                    .font(.inter(size: 15))
                    .tag(0.5 as Double?)
            }
        }
    }
}