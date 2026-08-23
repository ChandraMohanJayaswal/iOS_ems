//
//  ViewLeaveRequests.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI

struct ViewLeaveRequests: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelLeaveRequests()
    var body: some View {
        VStack {
            ZStack {
                Text("Leave Requests")
                    .font(.title2)
                    .fontWeight(.semibold)
                HStack {
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
                    Spacer()
                }
            }
            .padding([.leading, .top, .trailing], 10)
            Spacer()
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
        .refreshable {
            Task {
                await viewModel.fetchMyLeaveRequestsFromServer()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMyLeaveRequestsFromServer()
            }
        }
    }
}

