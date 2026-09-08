//
//  ViewHome.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//

import SwiftUI
import Charts

struct ViewHome: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel: ViewModelHome = .init()
    private var attendanceProgress: Double {
        guard let worked = viewModel.metrics?.totalWorkedDays,
            let working = viewModel.metrics?.totalWorkingDays,
            working > 0
        else {
            return 0
        }

        return min(Double(worked) / Double(working), 1)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                VStack(alignment: .leading, spacing: 14) {
                    Text(statisticsTitle)
                        .font(.title3.bold())
                    attendanceCard
                }
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

extension ViewHome {
    fileprivate var header: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Hi, \(EMSManager.shared.currentUser?.firstName ?? "NA")")
                .font(.system(size: 22, weight: .bold))
            HStack(alignment: .center, spacing: 10) {
                periodPicker
                Text("\(viewModel.metrics?.fiscalYear ?? "") \(viewModel.metrics?.currentMonth ?? "")")
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.accentColor.opacity(0.12))
                    )
                    .foregroundStyle(Color.accentColor)
                Spacer()
            }
        }
    }

    fileprivate var periodPicker: some View {
        Menu {
            Picker("Period", selection: $viewModel.selectedPeriod) {
                ForEach(HomeMetricsPeriod.allCases) { period in
                    Text(period.title)
                        .tag(period)
                }
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                Text(viewModel.selectedPeriod.title)
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption2.weight(.bold))
                    .opacity(0.7)
            }
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.accentColor.opacity(0.12))
            )
            .foregroundStyle(Color.accentColor)
        }
        .fixedSize()
    }
}

extension ViewHome {
    fileprivate var statisticsTitle: String {
        switch viewModel.selectedPeriod {
        case .fullYear:
            return "Statistics for this Year"
        default:
            return "Statistics for \(viewModel.selectedPeriod.title)"
        }
    }

    fileprivate var attendanceCard: some View {

        VStack(spacing: 20) {
            Chart(viewModel.data, id: \.0) { item in
                BarMark(
                    x: .value("Type", item.0),
                    y: .value("Days", item.1)
                )
                .foregroundStyle(by: .value("Type", item.0))
            }
            .chartForegroundStyleScale([
                "Working": .blue,
                "Worked": .green,
                "Leave": .orange
            ])
            .frame(height: 250)
            Spacer()
            HStack(spacing: 0) {

                attendanceStat(
                    value: "\(viewModel.metrics?.totalWorkingDays ?? 0)",
                    title: "Working",
                    color: .blue
                )

                Divider()
                    .frame(height: 35)

                attendanceStat(
                    value: "\(viewModel.metrics?.totalWorkedDays ?? 0)",
                    title: "Worked",
                    color: .green
                )

                Divider()
                    .frame(height: 35)

                attendanceStat(
                    value: "\(viewModel.metrics?.totalLeave ?? 0)",
                    title: "Leave",
                    color: .orange
                )
            }
            HStack(spacing: 0) {

                attendanceStat(
                    value: "\(viewModel.metrics?.balanceCasualLeave ?? 0)",
                    title: "Casual leave",
                    color: .red
                )

                Divider()
                    .frame(height: 35)

                attendanceStat(
                    value: "\(viewModel.metrics?.balanceSickLeave ?? 0)",
                    title: "Sick leave",
                    color: .yellow
                )
            }
        }
        .padding(20)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(
            color: .black.opacity(0.04),
            radius: 12,
            y: 5
        )
    }

    fileprivate func attendanceStat(
        value: String,
        title: String,
        color: Color
    ) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .foregroundStyle(color)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
