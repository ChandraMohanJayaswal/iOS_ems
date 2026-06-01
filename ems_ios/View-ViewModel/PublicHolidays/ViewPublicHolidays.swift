//
//  File.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//
import SwiftUI

struct ViewPublicHolidays: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelPublicHolidays()
    var body: some View {
        VStack {
            if viewModel.uiState == .loading {
                ProgressView()
            } else {
                ZStack {
                    VStack {
                        Text("Public Holidays")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Button(
                            action: {
                                withAnimation(.easeInOut) {
                                    coordinator.navigate(to: .sideMenu)
                                }
                            },
                            label: {
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                    .frame(width: 25, height: 15)
                                    .foregroundStyle(COLOR_BLACK)
                            }
                        )
                        Spacer()
                        Picker(
                            "Select Year",
                            selection: $viewModel.selectedYear
                        ) {
                            Text("All")
                                .tag("All")
                            ForEach(viewModel.fiscalYearList) { item in
                                Text("\(item.showingYear ?? "NA")").tag(
                                    item.fiscalYear ?? "NA"
                                )
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                }
                .padding([.leading, .top, .trailing], 10)
                Spacer()
                ScrollView {
                    ForEach(viewModel.searchedPublicHolidayList) {
                        item in
                        PublicHolidaysCard(
                            date: item.date,
                            showingYear: item.fiscalYear?.showingYear
                                ?? "NA",
                            description: item.description ?? "NA",
                            viewModel: viewModel
                        )
                    }
                }
            }
        }
        .onChange(of: viewModel.selectedYear) {
            viewModel.searchPublicHolidays()
        }
        .onAppear {
            Task {
                await viewModel.fetchFiscalYearFromServer()
                await viewModel.fetchPublicHolidaysFromServer()
                viewModel.searchPublicHolidays()
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchFiscalYearFromServer()
                await viewModel.fetchPublicHolidaysFromServer()
                viewModel.searchPublicHolidays()
            }
        }
    }
}
#Preview {
    ViewPublicHolidays()
    //    PublicHolidaysCard()
}

struct PublicHolidaysCard: View {
    var date: String?
    var showingYear: String
    var description: String
    @ObservedObject var viewModel: ViewModelPublicHolidays
    @State var isPresented: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Button(
                action: { isPresented = true },
                label: {
                    HStack {
                        Text(
                            description
                        )
                        Spacer()
                        if let date = date, let dateString = date.stringToDate()
                        {
                            Text(dateString, style: .date)
                        }
                    }
                }
            )
            Divider()
                .background(COLOR_GRAY)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                VStack(alignment: .leading, spacing: 20) {
                    if let date = date, let dateString = date.stringToDate() {
                        Text(dateString, style: .date)
                    }
                    Divider()
                        .background(COLOR_GRAY)
                    Text(showingYear)
                    Divider()
                        .background(COLOR_GRAY)
                    Text(description)
                    Divider()
                        .background(COLOR_GRAY)
                }
                .presentationDetents([.medium, .large])
                .presentationBackground(.ultraThinMaterial)
                .presentationCornerRadius(10)
                .padding()
                .toolbar {
                    Button(
                        action: {
                            isPresented.toggle()
                        },
                        label: {
                            Image(systemName: "xmark")
                        }
                    )
                }
                Spacer()
            }
        }
    }
}
