//
//  ProfileCard.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct ProfileCard: View {
    let onEdit: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 52))
                .foregroundStyle(blue)
            VStack(alignment: .leading, spacing: 4) {
                Text(
                    "\(EMSManager.shared.loggedUser?.firstName ?? "NA") \(EMSManager.shared.loggedUser?.lastName ?? "NA")"
                )
                .font(.poppins(.bold, size: 20))
                .foregroundStyle(.primary)
                Text(
                    "\(EMSManager.shared.loggedUser?.role?.title ?? "NA")"
                )
                .font(.inter(size: 15))
                .foregroundStyle(.secondary)
            }
            Spacer()
            Button(action: onEdit) {
                Image(systemName: "pencil")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(blue)
                    .clipShape(Circle())
            }
        }
        .padding(16)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}