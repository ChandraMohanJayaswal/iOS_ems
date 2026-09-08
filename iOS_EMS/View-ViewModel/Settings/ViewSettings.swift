//
//  ViewSettings.swift
//  iOS_EMS
//
//  Created by MacMini on 08/09/2026.
//

import SwiftUI

struct ViewSettings: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                settingsCard(items: settingsItems)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .header(title: "Settings")
    }

    private var settingsItems: [SettingsItem] {
        [
            SettingsItem(
                title: "Notifications",
                icon: "bell.fill",
                iconColor: blue
            ),
            SettingsItem(
                title: "About Us",
                icon: "person.2.fill",
                iconColor: blue
            ),
            SettingsItem(
                title: "Contact Us",
                icon: "paperplane",
                iconColor: blue
            ),
            SettingsItem(
                title: "Privacy Policy",
                icon: "hand.raised.fill",
                iconColor: blue
            ),
            SettingsItem(
                title: "Terms & Conditions",
                icon: "doc.text.fill",
                iconColor: blue
            )
        ]
    }

    fileprivate func settingsCard(items: [SettingsItem]) -> some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                Button {
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: item.icon)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                            .background(item.iconColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Text(item.title)
                            .foregroundStyle(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    .padding(14)
                }
                if index < items.count - 1 {
                    Divider()
                        .padding(.leading, 60)
                }
            }
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct SettingsItem {
    let title: String
    let icon: String
    let iconColor: Color
}

#Preview {
    ViewSettings()
}
