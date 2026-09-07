//
//  ProfileHeader.swift
//  ems_ios
//
//  Created by MacMini on 07/09/2026.
//

import SwiftUI

struct ProfileHeader: ToolbarContent {
    let title: String
    let onBack: () -> Void
    let onEdit: () -> Void
    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
        }
        ToolbarItem(placement: .topBarLeading) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(colorBlack)
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: onEdit) {
                Image(systemName: "pencil")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(colorBlack)
            }
        }
    }
}