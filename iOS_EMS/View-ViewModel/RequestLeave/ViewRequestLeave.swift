//
//  ViewPersonalLeave.swift
//  iOS_EMS
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI

struct ViewRequestLeave: View {
    @StateObject var viewModel = ViewModelRequestLeave()
    @EnvironmentObject var coordinator: RouteCoordinator
    @State var isAlertShown = false
    @State var isPartial: Bool = false
    var body: some View {
        VStack {
            RequestLeaveForm(
                viewModel: viewModel,
                isPartial: $isPartial
            ) {
                isAlertShown = true
            }
        }
        .navigationTitle("Request a Leave")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Send leave request?", isPresented: $isAlertShown) {
            Button("Cancel") {
                isAlertShown.toggle()
            }
            .foregroundStyle(red)

            Button("Submit") {
                Task {
                    await viewModel.postPersonalLeave()
                }
            }
            .foregroundStyle(blue)
        }
        .toast(isPresented: $viewModel.showToast, message: "Leave request submitted", icon: "checkmark")
        .onAppear {
            Task {
                await viewModel.getLeaveTypes()
                await viewModel.getLineManagers()
            }
        }
    }
}

#Preview {
    ViewRequestLeave()
}
