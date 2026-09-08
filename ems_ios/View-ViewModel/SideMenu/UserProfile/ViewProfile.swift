//
//  ViewProfile.swift
//  ems_ios
//
//  Created by MacMini on 08/09/2026.
//

import SwiftUI

struct ViewProfile: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelUserProfile()
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                profileCard
                detailsCard
                signOutButton
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .header(title: "Profile")
        .sheet(isPresented: $viewModel.isSheetShown) {
            EditProfileSheet(viewModel: viewModel) {
                viewModel.isSheetShown = false
            }
        }
    }

    fileprivate var profileCard: some View {
        HStack(spacing: 14) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 52))
                .foregroundStyle(darkBlue)
            VStack(alignment: .leading, spacing: 4) {
                Text(
                    "\(EMSManager.shared.currentUser?.firstName ?? "NA") \(EMSManager.shared.currentUser?.lastName ?? "NA")"
                )
                .font(.title3.bold())
                .foregroundStyle(.primary)
                Text(
                    "\(EMSManager.shared.currentUser?.role?.title ?? "NA")"
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            Spacer()
            Button {
                viewModel.isSheetShown = true
            } label: {
                Image(systemName: "pencil")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 32, height: 32)
                    .background(darkBlue)
                    .clipShape(Circle())
            }
        }
        .padding(16)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    fileprivate var detailsCard: some View {
        VStack(spacing: 0) {
            detailRow(title: "Role", value: viewModel.role)
            Divider().padding(.leading, 16)
            detailRow(title: "Gender", value: viewModel.gender.rawValue)
            Divider().padding(.leading, 16)
            detailRow(title: "Mobile No", value: viewModel.mobileNumber)
            Divider().padding(.leading, 16)
            detailRow(title: "Email Address", value: viewModel.emailAddress)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    fileprivate func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.trailing)
        }
        .padding(16)
    }

    fileprivate var signOutButton: some View {
        Button {
            signOut()
        } label: {
            HStack {
                Image(systemName: "door.right.hand.open")
                Text("Sign Out")
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(darkRed)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .accessibilityIdentifier("signOutButton")
        .padding(.top, 8)
    }

    private func signOut() {
        EMSManager.shared.signOut()
        coordinator.selectedTab = TABINDEX.HOME.rawValue
        coordinator.navigate(to: .login)
    }
}

#Preview {
    ViewProfile()
        .environmentObject(RouteCoordinator())
}