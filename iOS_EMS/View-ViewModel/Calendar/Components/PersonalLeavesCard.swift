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
#Preview {
    PersonalLeavesCardPreview()
}

private struct PersonalLeavesCardPreview: View {
    @State private var selectedFilter: LeaveStatusType = .all

    private var sampleLeaves: [PersonalLeave] {
        let now = Date().timeIntervalSince1970 * 1000
        let json = """
        [
            {
                "id": 1,
                "createdDateTime": \(now),
                "leaveFromDate": \(now),
                "leaveToDate": \(now + 2 * 86400_000),
                "leaveTypeRes": { "applyFor": "Annual Leave", "id": 1 },
                "description": "Family vacation",
                "leaveStatusRes": { "statusType": "APPROVED" },
                "statusComment": "Enjoy your break"
            },
            {
                "id": 2,
                "createdDateTime": \(now),
                "leaveFromDate": \(now + 3 * 86400_000),
                "leaveToDate": \(now + 4 * 86400_000),
                "leaveTypeRes": { "applyFor": "Sick Leave", "id": 2 },
                "description": "Not feeling well",
                "leaveStatusRes": { "statusType": "PENDING" },
                "statusComment": null
            }
        ]
        """
        return (
            try? JSONDecoder().decode(
                [PersonalLeave].self,
                from: Data(json.utf8)
            )
        ) ?? []
    }

    var body: some View {
        PersonalLeavesCard(
            selectedFilter: $selectedFilter,
            leaveRequests: sampleLeaves,
            onAddLeave: {}
        )
        .padding()
        .background(Color(uiColor: .systemGroupedBackground))
    }
}
