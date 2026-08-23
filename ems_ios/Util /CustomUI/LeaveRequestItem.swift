//
//  LeaveRequestsListView.swift
//  ems_ios
//
//  Created by MacMini on 23/08/2026.
//

import SwiftUI

struct LeaveRequestItem: View {
    let leaveType: String?
    let createdDateTime: Double?
    let leaveFromDate: Double?
    let leaveToDate: Double?
    let description: String?
    let leaveStatus: String?
    let comment: String?
    @State var isSheetPresented: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            if let createdDateTime = createdDateTime {
                Text(
                    createdDateTime.date.formatted(
                        .dateTime.day().month().year()
                    )
                )
            }
            Text("Click for detail view...")
                .foregroundStyle(.gray)
        }.onTapGesture {
            isSheetPresented = true
        }
        .sheet(isPresented: $isSheetPresented) {
            NavigationStack {
                VStack(alignment: .leading) {
                    Form {
                        HStack {
                            Text("Leave Type: ")
                            Spacer()
                            Text("\(leaveType ?? "N/A")")
                        }
                        HStack {
                            Text("Requested Date Time:")
                            Spacer()
                            Text(
                                createdDateTime?.date.formatted(
                                    .dateTime
                                        .year()
                                        .month()
                                        .day()
                                ) ?? ""
                            )
                        }
                        HStack {
                            Text("From Date: ")
                            Spacer()
                            Text(
                                leaveFromDate?.date.formatted(
                                    date: .complete,
                                    time: .shortened
                                ) ?? "N/A"
                            )
                        }
                        HStack {
                            Text("To Date:")
                            Spacer()
                            Text(
                                leaveToDate?.date.formatted(
                                    date: .complete,
                                    time: .shortened
                                ) ?? "N/A"
                            )
                        }
                        HStack {
                            Text("Description: ")
                            Spacer()
                            Text(description ?? "N/A")
                        }
                        HStack {
                            Text("Leave Status: ")
                            Spacer()
                            Text(leaveStatus ?? "N/A")
                        }
                        HStack {
                            Text("Comment: ")
                            Spacer()
                            Text(comment ?? "N/A")
                        }
                    }.toolbar {
                        Button("Close") {
                            isSheetPresented.toggle()
                        }
                        .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}
