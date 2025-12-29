//
//  ViewHome.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//

import SwiftUI
struct ViewHome: View{
    var body: some View{
            NavigationStack{
                Text("This is home")
                Text("Hello")
                    .navigationTitle(Text("Home"))
                    .navigationBarTitleDisplayMode(.inline)
                    .modifier(ToolbarSideMenu())
            }
        }
}
#Preview{
    ViewHome()
        .environmentObject(RouteCoordinator())
}

