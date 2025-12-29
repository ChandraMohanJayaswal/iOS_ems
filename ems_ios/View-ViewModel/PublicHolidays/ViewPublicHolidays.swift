//
//  File.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//
import SwiftUI
struct ViewPublicHolidays : View{
    var body: some View{
        NavigationStack{
            Text("Public Holidays")
                .navigationTitle(Text("Public Holidays"))
                .navigationBarTitleDisplayMode(.inline)
                .modifier(ToolbarSideMenu())
        }
    }
}
#Preview{
    ViewPublicHolidays()
}
