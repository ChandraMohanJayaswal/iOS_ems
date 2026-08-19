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
    var body: some View {
        VStack {
            ViewCalendar(viewModel: viewModel)
            Spacer()
        }
        .task {
            await viewModel.fetchPublicHolidaysFromServer()
        }
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
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
