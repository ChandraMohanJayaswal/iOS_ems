//
//  CustomToolbarSideMenu.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI
struct ToolbarSideMenu: ViewModifier {
    @EnvironmentObject var coordinator: RouteCoordinator
    func body(content: Content)-> some View{
        content
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation(.easeInOut){
                            coordinator.navigate(to:.sideMenu)
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
    }
}
