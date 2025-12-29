//
//  ViewPersonalLeave.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI
struct ViewPersonalLeave: View {
    var body: some View {
        NavigationStack{
            Text("Hello, World!")
                .navigationTitle("Personal Leaves")
                .navigationBarTitleDisplayMode( .inline )
                .modifier(ToolbarSideMenu())
        }
    }
}
