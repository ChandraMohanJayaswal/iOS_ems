//
//  CardHeader.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct CardHeader: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.caption.weight(.bold))
                .foregroundStyle(blue)
            Text(title)
                .font(.poppins(.semibold, size: 16))
            Spacer()
        }
    }
}