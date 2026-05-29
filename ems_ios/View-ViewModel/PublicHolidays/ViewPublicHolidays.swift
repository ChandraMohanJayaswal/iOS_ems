//
//  File.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//
import SwiftUI

struct ViewPublicHolidays: View {
    @StateObject var viewModel = ViewModelPublicHolidays()
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.uiState == .loading {
                    ProgressView()
                } else {
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
                    .onChange(of: viewModel.selectedYear) {
                        viewModel.searchPublicHolidays()
                    }
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
                            Divider()
                        }
                    }
                }
            }
            .modifier(ToolbarSideMenu())
            .navigationTitle("Public Holidays")
            .navigationBarTitleDisplayMode(.inline)
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
            Text(
                viewModel.truncateDescription(description)
            )
            HStack {
                Spacer()
                Text(date)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .onTapGesture {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                VStack(alignment: .leading, spacing: 20) {
                    Divider()
                    Text("Date: " + date)
                    Divider()
                    Text("Fiscal year: " + showingYear)
                    Divider()
                    Text("Description: " + description)
                    Divider()
                }
                .padding()
                .toolbar {
                    Button("Close") {
                        isPresented.toggle()
                    }
                    .foregroundStyle(.red)
                }
                Spacer()
            }
        }
    }
}
