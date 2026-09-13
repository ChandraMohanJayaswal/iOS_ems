//
//  LeaveTypePicker.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct LeaveTypePicker: View {
    @Binding var selectedLeaveType: Int
    let leaveTypes: [LeaveType]

    var body: some View {
        Picker(
            "Leave Type",
            selection: $selectedLeaveType
        ) {
            if selectedLeaveType == 0 {
                Text("Select")
                    .font(.inter(size: 15))
                    .tag(0)
            }
            ForEach(leaveTypes, id: \.id) { item in
                Text("\(item.typeOfLeave)")
                    .font(.inter(size: 15)).tag(item.id)
            }
        }
    }
}