//
//  File.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//
import SwiftUI

struct ViewPublicHolidays: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelPublicHolidays()
    @State var isSheetPresented: Bool = false
    var body: some View {
        ViewCalendar(isSheetPresented: $isSheetPresented, viewModel: viewModel)
            .header(title: "Calendar")
            .sheet(isPresented: $isSheetPresented) {
                NavigationStack {
                    ViewRequestLeave()
                }
            }
    }
}
