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
        HStack(spacing: 12) {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.accentColor)
                .frame(width: 36, height: 36)
                .background(
                    Circle().fill(Color.accentColor.opacity(0.12))
                )

            VStack(alignment: .leading, spacing: 3) {
                Text(leaveType ?? "Leave")
                    .font(.headline)

                Text(dateRangeText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            statusBadge
        }
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
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
                        Button {
                            isSheetPresented.toggle()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                        .accessibilityLabel("Close")
                    }
                }
                .navigationTitle("Leave Details")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    private var dateRangeText: String {
        guard let from = leaveFromDate?.date, let to = leaveToDate?.date else {
            return createdDateTime?.date.formatted(.dateTime.day().month().year()) ?? "N/A"
        }
        return "\(from.formatted(.dateTime.day().month())) - \(to.formatted(.dateTime.day().month().year()))"
    }

    private var statusBadge: some View {
        Text(leaveStatus ?? "N/A")
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Capsule().fill(statusColor.opacity(0.12)))
            .foregroundStyle(statusColor)
    }

    private var statusColor: Color {
        switch leaveStatus {
        case "APPROVED":
            return .green
        case "PENDING":
            return .orange
        case "REJECTED":
            return .red
        default:
            return Color.accentColor
        }
    }
}