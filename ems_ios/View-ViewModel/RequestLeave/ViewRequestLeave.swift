//
//  ViewPersonalLeave.swift
//  ems_ios
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
                                .tag(0)
                        }
                        ForEach(viewModel.leaveTypes, id: \.id) { item in
                            Text("\(item.typeOfLeave)").tag(item.id)
                        }
                    }
                    Toggle("Partial Leave", isOn: $isPartial)
                        .toggleStyle(.automatic)
                    if isPartial {
                        Picker("Duration", selection: $viewModel.leaveCount) {
                            Text("Select")
                                .tag(nil as Double?)
                            Text("Quarter day")
                                .tag(0.25 as Double?)
                            Text("Half day")
                                .tag(0.5 as Double?)
                        }
                    }
                    DatePicker(
                        "Leave From Date",
                        selection: $viewModel.leaveFromDate,
                        displayedComponents: [.date]
                    )
                    if !isPartial {
                        DatePicker(
                            "Leave To Date",
                            selection: $viewModel.leaveToDate,
                            displayedComponents: [.date]
                        )
                    }
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
            .foregroundStyle(.red)

            Button("Submit") {
                Task {
                    await viewModel.postPersonalLeave()
                }
            }
            .foregroundStyle(colorBlue)
        }
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
                    .foregroundStyle(.black)
                Spacer()

                if selection.isEmpty {
                    Text("Select")
                        .foregroundStyle(.primary)
                } else {
                    Text("\(selection.count) selected")
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
