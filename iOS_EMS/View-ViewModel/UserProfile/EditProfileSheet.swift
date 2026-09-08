//
//  EditProfileSheet.swift
//  iOS_EMS
//
//  Created by MacMini on 07/09/2026.
//

import SwiftUI

struct EditProfileSheet: View {
    @ObservedObject var viewModel: ViewModelUserProfile
    let onSave: () -> Void
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        TextField("First Name", text: $viewModel.firstName)
                            .font(.inter(size: 17))
                        TextField("Last Name", text: $viewModel.lastName)
                            .font(.inter(size: 17))
                        Picker("Gender", selection: $viewModel.gender) {
                            ForEach(Gender.allCases) { gender in
                                Text("\(gender.rawValue)")
                                    .font(.inter(size: 15)).tag(gender)
                            }
                        }
                        .font(.inter(size: 17))
                        .pickerStyle(.segmented)
                        DatePicker("Date of birth", selection: $viewModel.dob, displayedComponents: [.date])
                            .font(.inter(size: 17))
                        TextField("Mobile Number", text: $viewModel.mobileNumber)
                            .font(.inter(size: 17))
                        TextField("Email Address", text: $viewModel.emailAddress)
                            .textInputAutocapitalization(.never)
                            .font(.inter(size: 17))
                    }
                }
                Button(action: onSave) {
                    HStack {
                        Text("Save")
                            .font(.inter(.semibold, size: 17))
                        Image(systemName: "opticaldisc")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}