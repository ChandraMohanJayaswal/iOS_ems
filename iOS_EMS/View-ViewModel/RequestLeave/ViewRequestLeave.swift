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
            Form {
                Section {
                    MultiSelectPicker(
                        title: "Line Manager",
                        items: viewModel.lineManagers,
                        displayName: { $0.fullName ?? "NA" },
                        selection: $viewModel.selectedLineManagers
                    )

                    Picker(
                        "Leave Type",
                        selection: $viewModel.selectedLeaveType
                    ) {
                        if viewModel.selectedLeaveType == 0 {
                            Text("Select")
                                .font(.inter(size: 15))
                                .tag(0)
                        }
                        ForEach(viewModel.leaveTypes, id: \.id) { item in
                            Text("\(item.typeOfLeave)")
                                .font(.inter(size: 15)).tag(item.id)
                        }
                    }
                    Toggle("Partial Leave", isOn: $isPartial)
                        .font(.inter(size: 15))
                        .toggleStyle(.automatic)
                    if isPartial {
                        Picker("Duration", selection: $viewModel.leaveCount) {
                            Text("Select")
                                .font(.inter(size: 15))
                                .tag(nil as Double?)
                            Text("Quarter day")
                                .font(.inter(size: 15))
                                .tag(0.25 as Double?)
                            Text("Half day")
                                .font(.inter(size: 15))
                                .tag(0.5 as Double?)
                        }
                    }
                    DatePicker(
                        "Leave From Date",
                        selection: $viewModel.leaveFromDate,
                        displayedComponents: [.date]
                    )
                    .font(.inter(size: 15))
                    if !isPartial {
                        DatePicker(
                            "Leave To Date",
                            selection: $viewModel.leaveToDate,
                            displayedComponents: [.date]
                        )
                        .font(.inter(size: 15))
                    }
                    TextField(
                        "Description",
                        text: $viewModel.description,
                        axis: .vertical
                    )
                    .autocorrectionDisabled(true)
                    .font(.inter(size: 15))
                }
                Section {
Button {
                    isAlertShown = true
                } label: {
                    HStack {
                        Spacer()
                        Text("Submit")
                            .font(.inter(.semibold, size: 17))
                        Image(systemName: "paperplane")
                        Spacer()
                    }
                }
                .disabled(!viewModel.isFormValid)
                }
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
        .onChange(of: isPartial) {
            if isPartial == false {
                viewModel.leaveCount = nil
            }
        }
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
struct MultiSelectPicker<Item: Identifiable>: View {
    let title: String
    let items: [Item]
    let displayName: (Item) -> String

    @Binding var selection: Set<Item.ID>
    var body: some View {
        Menu {
            ForEach(items) { item in
                Button {
                    toggle(item)
                } label: {
                    HStack {
                        Text(displayName(item))
                        Spacer()
                        if selection.contains(item.id) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text(title)
                    .font(.inter(size: 15))
                    .foregroundStyle(.black)
                Spacer()

                if selection.isEmpty {
                    Text("Select")
                        .font(.inter(size: 15))
                        .foregroundStyle(.primary)
                } else {
                    Text("\(selection.count) selected")
                        .font(.inter(size: 15))
                        .foregroundStyle(.primary)
                }

                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
        }
    }

    private func toggle(_ item: Item) {
        if selection.contains(item.id) {
            selection.remove(item.id)
        } else {
            selection.insert(item.id)
        }
    }
}
