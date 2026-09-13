//
//  SyncStatusView.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct SyncStatusView: View {
    var body: some View {
        HStack(spacing: 7) {
            SyncIndicator()
            Text("Synchronizing attendance...")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color(.black))
        }
    }
}