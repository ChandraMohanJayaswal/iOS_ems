//
//  Header.swift
//  ems_ios
//
//  Created by MacMini on 01/06/2026.
//

import SwiftUI
struct HeaderModifier: ViewModifier {
    let title: String
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                Divider()
                    .frame(maxWidth: .infinity)
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.poppins(.bold, size: 22))
                }
            }
    }
}

extension View {
    func header(title: String) -> some View {
        modifier(HeaderModifier(title: title))
    }
}
