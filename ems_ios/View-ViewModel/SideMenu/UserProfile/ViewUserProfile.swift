//
//  ViewUserProfile.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI

struct ViewUserProfile: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelUserProfile()
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Role: ")
                    Spacer()
                    Text("\(viewModel.role)")
                }
                HStack {
                    Text("Name:")
                    Spacer()
                    Text("\(viewModel.firstName) \(viewModel.lastName)")
                }
                HStack {
                    Text("Gender:")
                    Spacer()
                    Text("\(viewModel.gender.rawValue)")
                }
                HStack {
                    Text("Date of Birth:")
                    Spacer()
                    Text(viewModel.dob, format: .dateTime.day().month().year())
                }
                HStack {
                    Text("Mobile No:")
                    Spacer()
                    Text("\(viewModel.mobileNumber)")
                }
                HStack {
                    Text("Email Address:")
                    Spacer()
                    Text("\(viewModel.emailAddress)")
                }
            }
            Button {
                    viewModel.isSheetShown.toggle()
                } label: {
                    Text("Edit Info")
                    Image(systemName: "pencil")
                        .frame(width: 30, height: 30)
                }
            .sheet(isPresented: $viewModel.isSheetShown) {
                VStack {
                    Form {
                        Section {
                            TextField("First Name", text: $viewModel.firstName)
                            TextField("Last Name", text: $viewModel.lastName)
                            Picker("Gender", selection: $viewModel.gender) {
                                ForEach(Gender.allCases) { gender in
                                    Text("\(gender.rawValue)").tag(gender)
                                }
                            }.pickerStyle(.segmented)
                            DatePicker("Date of birth", selection: $viewModel.dob, displayedComponents: [.date])
                            TextField("Mobile Number", text: $viewModel.mobileNumber)
                            TextField("Email Address", text: $viewModel.emailAddress)
                                .textInputAutocapitalization(.never)
                        }
                    }
                    Button {
                        viewModel.isSheetShown = false
                    } label: {
                        HStack {
                            Text("Save")
                            Image(systemName: "opticaldisc")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
            }
                .navigationTitle("Profile Details")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation(.easeInOut) {
                                coordinator.navigate(to: .tabbar)
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                        }
                    }
                }
        }
    }
}
#Preview{
    ViewUserProfile()
}
