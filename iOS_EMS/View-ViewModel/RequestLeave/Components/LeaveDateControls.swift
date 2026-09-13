//
//  LeaveDateControls.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct LeaveDateControls: View {
    @Binding var leaveFromDate: Date
    @Binding var leaveToDate: Date
    let isPartial: Bool

    var body: some View {
        DatePicker(
            "Leave From Date",
            selection: $leaveFromDate,
            displayedComponents: [.date]
        )
        .font(.inter(size: 15))
        .tint(blue)
        if !isPartial {
            DatePicker(
                "Leave To Date",
                selection: $leaveToDate,
                displayedComponents: [.date]
            )
            .font(.inter(size: 15))
            .tint(blue)
        }
    }
}

#Preview {
    @Previewable @State var leaveFromDate = Date()
    @Previewable @State var leaveToDate = Date()
    VStack {
        LeaveDateControls(
            leaveFromDate: $leaveFromDate,
            leaveToDate: $leaveToDate,
            isPartial: false
        )
        Divider()
        LeaveDateControls(
            leaveFromDate: $leaveFromDate,
            leaveToDate: $leaveToDate,
            isPartial: true
        )
    }
    .padding()
}
