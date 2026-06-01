//
//  Header.swift
//  ems_ios
//
//  Created by MacMini on 01/06/2026.
//

import SwiftUI
struct Header: View {
    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .padding(.trailing, 20)
            Text("Page Title")
            Spacer()
            Image(systemName: "magnifyingglass")
        }
        .padding()
    }
}

#Preview {
    Header()
}
