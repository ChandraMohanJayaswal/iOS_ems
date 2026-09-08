//
//  ProfileForm.swift
//  iOS_EMS
//
//  Created by MacMini on 07/09/2026.
//

import SwiftUI

struct ProfileForm: View {
    @ObservedObject var viewModel: ViewModelUserProfile
    var body: some View {
        Form {
            ProfileRow(title: "Role", value: viewModel.role)
            ProfileRow(title: "Name", value: "\(viewModel.firstName) \(viewModel.lastName)")
            ProfileRow(title: "Gender", value: viewModel.gender.rawValue)
            ProfileRow(title: "Date of Birth", value: viewModel.dob.formatted(.dateTime.day().month().year()))
            ProfileRow(title: "Mobile No", value: viewModel.mobileNumber)
            ProfileRow(title: "Email Address", value: viewModel.emailAddress)
        }
    }
}