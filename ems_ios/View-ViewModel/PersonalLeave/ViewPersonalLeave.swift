//
//  ViewPersonalLeave.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI

struct ViewPersonalLeave: View {
    @StateObject var viewModel = ViewModelPersonalLeave()
    @State var isAlertShown = false
    var body: some View {
        HeaderView(viewModel: viewModel)
        Spacer()
        Form {
            Section {
                Picker(
                    "Line Manager",
                    selection: $viewModel.selectedLineManager
                ) {
                    ForEach(0..<3) { value in
                        Text("Something")
                            .tag(value)
                    }
                }

                Picker("Leave Type", selection: $viewModel.selectedLeaveType) {
                    Text("None Selected").tag(0)
                    ForEach(viewModel.leaveTypeList, id: \.id) { item in
                        Text("\(item.typeOfLeave)").tag(item.id)
                    }
                }
                DatePicker(
                    "Leave From Date",
                    selection: $viewModel.leaveFromDate,
                    displayedComponents: [.date]
                )
                DatePicker(
                    "Leave To Date",
                    selection: $viewModel.leaveToDate,
                    displayedComponents: [.date]
                )
                TextField(
                    "Description",
                    text: $viewModel.description,
                    axis: .vertical
                )
                .autocorrectionDisabled(true)
            }
            Section {
                Button {
                    isAlertShown = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Submit")
                        Image(systemName: "paperplane")
                        Spacer()
                    }
                }
            }
        }
        .alert("Send leave request?", isPresented: $isAlertShown) {
            Button("Cancel") {
                isAlertShown.toggle()
            }
            .foregroundStyle(.red)

            Button("Submit") {
                Task {
                    await viewModel.postPersonalLeaveToServer()
                }
            }
            .foregroundStyle(COLOR_BLUE)
        }
        .onAppear {
            Task {
                await viewModel.fetchLeaveTypeFromServer()
            }
        }
    }
}

#Preview {
    ViewPersonalLeave()
}

struct HeaderView: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @ObservedObject var viewModel: ViewModelPersonalLeave
    var body: some View {
        ZStack {
            VStack {
                Text("Personal Leave")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
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
                            .foregroundStyle(COLOR_BLACK)
                    }
                )
                Spacer()
            }
        }
        .padding([.leading, .top, .trailing], 10)
    }
}
