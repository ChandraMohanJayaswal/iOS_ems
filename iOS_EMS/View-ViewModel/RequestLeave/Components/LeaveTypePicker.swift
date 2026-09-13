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

#Preview {
    @Previewable @State var selectedLeaveType = 0
    LeaveTypePicker(
        selectedLeaveType: $selectedLeaveType,
        leaveTypes: [
            LeaveType(id: 1, typeOfLeave: "Casual Leave"),
            LeaveType(id: 2, typeOfLeave: "Sick Leave"),
            LeaveType(id: 3, typeOfLeave: "Annual Leave")
        ]
    )
    .padding()
}
