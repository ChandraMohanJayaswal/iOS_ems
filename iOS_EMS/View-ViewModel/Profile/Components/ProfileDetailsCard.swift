//
//  ProfileDetailsCard.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct ProfileDetailsCard: View {
    let role: String
    let gender: String
    let mobileNumber: String
    let emailAddress: String

    var body: some View {
        VStack(spacing: 10) {
            ProfileRow(title: "Role", value: role)
            Divider().padding(.leading, 16)
            ProfileRow(title: "Gender", value: gender)
            Divider().padding(.leading, 16)
            ProfileRow(title: "Mobile No", value: mobileNumber)
            Divider().padding(.leading, 16)
            ProfileRow(title: "Email Address", value: emailAddress)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ProfileDetailsCard(
        role: "Admin",
        gender: "Male",
        mobileNumber: "+91 9876543210",
        emailAddress: "johndoe@example.com"
    )
}
