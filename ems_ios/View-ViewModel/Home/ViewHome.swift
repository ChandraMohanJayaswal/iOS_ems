//
//  ViewHome.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//

import SwiftUI

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
                attendanceCard
                leaveSection
                statisticsSection
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
        .header(title: "Home")
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ViewHome()
        .environmentObject(RouteCoordinator())
}

extension ViewHome {
    fileprivate var header: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text(viewModel.metrics?.currentMonth ?? "")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(alignment: .center) {
                Text("👋")
                Text(UserDefaults.standard.string(forKey: "firstName") ?? "NA")
                    .font(.largeTitle.bold())
                Spacer()
                Text(viewModel.metrics?.fiscalYear ?? "")
                    .font(.caption.weight(.semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(Color.accentColor.opacity(0.12))
                    )
                    .foregroundStyle(Color.accentColor)
            }
        }
    }
}

extension ViewHome {
    fileprivate var attendanceCard: some View {
        VStack(spacing: 20) {

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Attendance")
                        .font(.headline)

                    Text("Fiscal year \(viewModel.metrics?.fiscalYear ?? "-")")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "calendar.badge.checkmark")
                    .font(.title3)
                    .foregroundStyle(.green)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(.green.opacity(0.12))
                    )
            }

            Gauge(value: attendanceProgress) {
                EmptyView()
            } currentValueLabel: {
                VStack(spacing: 2) {
                    Text("\(viewModel.metrics?.totalWorkedDays ?? 0)")
                        .font(
                            .system(size: 38, weight: .bold, design: .rounded)
                        )

                    Text("days worked")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .gaugeStyle(.accessoryCircularCapacity)
            .tint(.green)
            .scaleEffect(1.35)
            .frame(height: 150)

            HStack(spacing: 0) {

                attendanceStat(
                    value: "\(viewModel.metrics?.totalWorkedDays ?? 0)",
                    title: "Worked",
                    color: .green
                )

                Divider()
                    .frame(height: 35)

                attendanceStat(
                    value: "\(viewModel.metrics?.totalWorkingDays ?? 0)",
                    title: "Working",
                    color: .blue
                )

                Divider()
                    .frame(height: 35)

                attendanceStat(
                    value: "\(viewModel.metrics?.totalLeave ?? 0)",
                    title: "Leave",
                    color: .orange
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

extension ViewHome {

    fileprivate var leaveSection: some View {
        VStack(alignment: .leading, spacing: 14) {

            Text("Leave Balance")
                .font(.title3.bold())

            HStack(spacing: 14) {

                leaveCard(
                    title: "Casual Leave",
                    value: viewModel.metrics?.balanceCasualLeave ?? 0,
                    icon: "figure.walk",
                    color: .orange
                )

                leaveCard(
                    title: "Sick Leave",
                    value: viewModel.metrics?.balanceSickLeave ?? 0,
                    icon: "cross.case.fill",
                    color: .red
                )
            }
        }
    }

    fileprivate func leaveCard(
        title: String,
        value: Double,
        icon: String,
        color: Color
    ) -> some View {

        VStack(alignment: .leading, spacing: 16) {

            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.tertiary)
            }

            Spacer()

            Text(value.formatted(.number.precision(.fractionLength(1))))
                .font(.system(size: 30, weight: .bold, design: .rounded))

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .padding(18)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(alignment: .bottom) {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 2)
                    .fill(color)
                    .frame(width: geometry.size.width * 0.45, height: 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 4)
            .padding(.horizontal, 18)
            .padding(.bottom, 10)
        }
    }
}

extension ViewHome {

    fileprivate var statisticsSection: some View {
        VStack(alignment: .leading, spacing: 14) {

            Text("Overview")
                .font(.title3.bold())

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 14
            ) {

                metricCard(
                    title: "Working Days",
                    value: "\(viewModel.metrics?.totalWorkingDays ?? 0)",
                    icon: "calendar",
                    color: .blue
                )

                metricCard(
                    title: "Days Worked",
                    value: "\(viewModel.metrics?.totalWorkedDays ?? 0)",
                    icon: "checkmark.circle.fill",
                    color: .green
                )

                metricCard(
                    title: "Total Leave",
                    value: "\(viewModel.metrics?.totalLeave ?? 0)",
                    icon: "airplane.departure",
                    color: .orange
                )

                metricCard(
                    title: "Attendance",
                    value: "\(Int(attendanceProgress * 100))%",
                    icon: "chart.bar.fill",
                    color: .purple
                )
            }
        }
    }

    fileprivate func metricCard(
        title: String,
        value: String,
        icon: String,
        color: Color
    ) -> some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack {
                Image(systemName: icon)
                    .foregroundStyle(color)

                Spacer()
            }

            Text(value)
                .font(.system(size: 26, weight: .bold, design: .rounded))

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
