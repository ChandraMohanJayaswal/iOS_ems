//
//  RequestLeaveForm.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct RequestLeaveForm: View {
    @ObservedObject var viewModel: ViewModelRequestLeave
    @Binding var isPartial: Bool
    let onSubmit: () -> Void

    var body: some View {
        Form {
            Section {
                MultiSelectPicker(
                    title: "Line Manager",
                    items: viewModel.lineManagers,
                    displayName: { $0.fullName ?? "NA" },
                    selection: $viewModel.selectedLineManagers
                )
                LeaveTypePicker(
                    selectedLeaveType: $viewModel.selectedLeaveType,
                    leaveTypes: viewModel.leaveTypes
                )
                PartialLeaveSection(
                    isPartial: $isPartial,
                    leaveCount: $viewModel.leaveCount
                )
                LeaveDateControls(
                    leaveFromDate: $viewModel.leaveFromDate,
                    leaveToDate: $viewModel.leaveToDate,
                    isPartial: isPartial
                )
                DescriptionField(text: $viewModel.description)
            }
            Section {
                SubmitLeaveButton(
                    isFormValid: viewModel.isFormValid,
                    action: onSubmit
                )
            }
        }
    }
}