//
//  ProfileRow.swift
//  iOS_EMS
//
//  Created by MacMini on 07/09/2026.
//

import SwiftUI

struct ProfileRow: View {
    let title: String
    let value: String
    var body: some View {
        HStack {
            Text("\(title):")
            Spacer()
            Text(value)
        }
        .font(.inter(size: 15))
    }
}