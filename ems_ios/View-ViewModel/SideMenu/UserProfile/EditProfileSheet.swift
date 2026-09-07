//
//  EditProfileSheet.swift
//  ems_ios
//
//  Created by MacMini on 07/09/2026.
//

import SwiftUI

struct EditProfileSheet: View {
    @ObservedObject var viewModel: ViewModelUserProfile
    let onSave: () -> Void
    var body: some View {
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
            Button(action: onSave) {
                HStack {
                    Text("Save")
                    Image(systemName: "opticaldisc")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            }
        }
    }
}