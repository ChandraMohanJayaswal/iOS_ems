//
//  InputLabel.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct InputLabel: View {
    let text: String

    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(blue)

            Spacer()
        }
        .padding(.bottom, 4)
    }
}

#Preview {
    InputLabel(text: "Work Email")
        .padding()
}
