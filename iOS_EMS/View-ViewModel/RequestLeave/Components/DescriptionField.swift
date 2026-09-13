//
//  DescriptionField.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct DescriptionField: View {
    @Binding var text: String

    var body: some View {
        TextField(
            "Description",
            text: $text,
            axis: .vertical
        )
        .autocorrectionDisabled(true)
        .font(.inter(size: 15))
    }
}

#Preview {
    @Previewable @State var text = ""
    DescriptionField(text: $text)
        .padding()
}