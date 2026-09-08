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
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                }
                ToolbarItem(placement: .bottomBar) {
                    Divider()
                }
            }
    }
}

extension View {
    func header(title: String) -> some View {
        modifier(HeaderModifier(title: title))
    }
}
