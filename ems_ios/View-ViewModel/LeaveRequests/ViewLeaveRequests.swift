//
//  ViewLeaveRequests.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI
struct ViewLeaveRequests: View {
    var body: some View {
        NavigationStack{
            Text("Leave Requests")
                .navigationTitle("Leave Requests")
                .navigationBarTitleDisplayMode( .inline )
                .modifier(ToolbarSideMenu())
        }
    }
}
