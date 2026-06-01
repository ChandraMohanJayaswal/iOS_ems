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
                HStack {
                    Button(
                        action: {
                            withAnimation(.easeInOut) {
                                coordinator.navigate(to: .sideMenu)
                            }
                        },
                        label: {
                            Image(systemName: "line.3.horizontal")
                                .padding(.trailing, 20)
                                .foregroundStyle(COLOR_BLACK)
                        }
                    )
                    Text("Public Holidays")
                    Spacer()
                    Text("Year:")
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
                }
                .padding([.leading, .top, .trailing], 10)
                .pickerStyle(.menu)
                ScrollView {
                    ForEach(viewModel.searchedPublicHolidayList) {
                        item in
                        PublicHolidaysCard(
                            date: item.date ?? "NA",
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
    var date: String
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
                        Text(date)
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
                    Text("Date: " + date)
                    Divider()
                        .background(COLOR_GRAY)
                    Text("Fiscal year: " + showingYear)
                    Divider()
                        .background(COLOR_GRAY)
                    Text("Description: " + description)
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
