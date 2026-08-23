//
//  Header.swift
//  ems_ios
//
//  Created by MacMini on 01/06/2026.
//

import SwiftUI
struct HeaderModifier: ViewModifier {
    @EnvironmentObject var coordinator: RouteCoordinator
    let title: String
    func body(content: Content) -> some View {
        content
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(
                        action: {
                            withAnimation(.easeInOut) {
                                coordinator.navigate(to: .sideMenu)
                            }
                        },
                        label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .frame(width: 25, height: 15)
                                .foregroundStyle(colorBlack)
                        }
                    )
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        action: {
                            withAnimation(.easeInOut) {
                                //                            coordinator.navigate(to: .sideMenu)
                            }
                        },
                        label: {
                            Image(systemName: "bell")
                                .resizable()
                                .foregroundStyle(colorBlack)
                        }
                    )
                }
            }
    }
}

extension View {
    func header(title: String) -> some View {
        modifier(HeaderModifier(title: title))
    }
}
