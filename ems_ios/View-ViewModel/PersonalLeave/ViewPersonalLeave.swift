//
//  ViewPersonalLeave.swift
//  ems_ios
//
//  Created by MacMini on 23/08/2026.
//

import SwiftUI

struct ViewPersonalLeave: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel: ViewModelPersonalLeave = .init()
    var body: some View {
        VStack {
            if viewModel.leaveRequests.isEmpty {
                Image(systemName: "tray")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.gray)
                Text("No Leave Requests")
                    .foregroundStyle(.gray)
                Spacer()
            } else {
                List {
                    ForEach(viewModel.leaveRequests) { item in
                        LeaveRequestItem(
                            leaveType: item.leaveTypeRes?.typeOfLeave,
                            createdDateTime: item.createdEpoch,
                            leaveFromDate: item.leaveFromDate,
                            leaveToDate: item.leaveToDate,
                            description: item.description,
                            leaveStatus: item.leaveStatusRes?.statusType?.rawValue,
                            comment: item.statusComment
                        )
                    }
                }
            }
        }
        .task {
            await viewModel.getLeaveRequests()
        }
        .navigationTitle("Personal Leaves")
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
