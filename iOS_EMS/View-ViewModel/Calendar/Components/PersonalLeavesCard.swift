//
//  PersonalLeavesCard.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct PersonalLeavesCard: View {
    @Binding var selectedFilter: LeaveStatusType
    let leaveRequests: [PersonalLeave]
    let onAddLeave: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Personal Leaves")
                    .font(.poppins(.bold, size: 20))
                Spacer()
                Button(action: onAddLeave) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 30)
                        .background(.cyan)
                        .clipShape(Circle())
                }
                .accessibilityIdentifier(
                    "requestALeaveButton"
                )
            }

            Picker(
                "Leave Status",
                selection: $selectedFilter
            ) {
                ForEach(LeaveStatusType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            }
            .pickerStyle(.segmented)

            LazyVStack(
                alignment: .leading,
                spacing: 8
            ) {
                ForEach(leaveRequests) { item in
                    LeaveRequestItem(
                        leaveType: item.leaveTypeRes?.typeOfLeave,
                        createdDateTime: item.createdEpoch,
                        leaveFromDate: item.leaveFromDate,
                        leaveToDate: item.leaveToDate,
                        description: item.description,
                        leaveStatus: item.leaveStatusRes?.statusType?
                            .rawValue,
                        comment: item.statusComment
                    )
                }
            }
        }
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}