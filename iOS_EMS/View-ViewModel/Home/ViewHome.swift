//
//  ViewHome.swift
//  iOS_EMS
//
//  Created by MacMini on 25/12/2025.
//

import SwiftUI

struct ViewHome: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel: ViewModelHome = .init()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HomeHeader(
                    selectedPeriod: $viewModel.selectedPeriod,
                    fiscalYear: viewModel.metrics?.fiscalYear,
                    currentMonth: viewModel.metrics?.currentMonth
                )
                AttendanceCard(
                    chartData: viewModel.data,
                    totalWorkingDays: viewModel.metrics?.totalWorkingDays,
                    totalWorkedDays: viewModel.metrics?.totalWorkedDays,
                    totalLeave: viewModel.metrics?.totalLeave,
                    casualLeaveBalance: viewModel.metrics?.balanceCasualLeave,
                    sickLeaveBalance: viewModel.metrics?.balanceSickLeave
                )
                HoursCard(
                    hoursData: viewModel.hoursData,
                    workedHours: viewModel.metrics?.totalWorkedHours,
                    workingHours: viewModel.metrics?.totalWorkingHours
                )
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .refreshable {
            await viewModel.getMetrics()
        }
        .task {
            await viewModel.getMetrics()
        }
        .onChange(of: viewModel.selectedPeriod) { _, _ in
            Task {
                await viewModel.getMetrics()
            }
        }
        .header(title: "Home")
        .background(Color(uiColor: .systemGroupedBackground))
    }
}
#Preview {
    ViewHome()
        .environmentObject(RouteCoordinator())
}