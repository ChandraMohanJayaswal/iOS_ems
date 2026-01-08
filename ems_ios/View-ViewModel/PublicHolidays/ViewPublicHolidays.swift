//
//  File.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//
import SwiftUI
struct ViewPublicHolidays : View{
    @StateObject var viewModel = ViewModelPublicHolidays()
    var body: some View{
        NavigationStack{
            VStack{
            if !viewModel.fiscalYearList.isEmpty && !viewModel.allpublicHolidayList.isEmpty{
                Form{
                    Picker("Select Year", selection:$viewModel.selectedYear){
                        ForEach(viewModel.fiscalYearList, id:\.self){ year in
                            Text("\(year)").tag(year)
                        }
                    }
                    .onChange(of:viewModel.selectedYear){
                        viewModel.searchPublicHolidays()
                    }
                    .pickerStyle(.menu)
                    List{
                        ForEach(viewModel.searchedPublicHolidayList.indices, id:\.self){ item in
                            PublicHolidaysCard(date: viewModel.allpublicHolidayList[item]["date"] ?? "NA", fiscalYear: viewModel.allpublicHolidayList[item]["fiscalYear"] ?? "NA", description: viewModel.allpublicHolidayList[item]["description"] ?? "NA")
                        }
                    }
                }
            }
            else {
                ProgressView()
                }
            }
            .modifier(ToolbarSideMenu())
            .navigationTitle("Public Holidays")
            .navigationBarTitleDisplayMode( .inline)
        }
        .onAppear{
            Task{
             await viewModel.fetchFiscalYearFromServer()
            await viewModel.fetchPublicHolidaysFromServer()
                 viewModel.searchPublicHolidays()
            }
        }
        .refreshable {
                        
                        Task{
                            await viewModel.fetchFiscalYearFromServer()
                            await viewModel.fetchPublicHolidaysFromServer()
                            viewModel.searchPublicHolidays()
                        }
                    }
    }
}
#Preview{
    ViewPublicHolidays()
//    PublicHolidaysCard()
}

struct PublicHolidaysCard: View{
    var date: String
    var fiscalYear: String
    var description: String
    @State var isPresented: Bool = false
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Text("Date: " + date)
                Spacer()
                Text("Fiscal year:" + fiscalYear)
            }
            Spacer()
            Text("Description: " + description)
        }
        .onTapGesture{
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented){
            NavigationStack{
                VStack(alignment:.leading){
                    HStack{
                        Text("Date: " + date)
                        Spacer()
                        Text("Fiscal year:" + fiscalYear)
                    }
                    Text("Description: " + description)
                    Spacer()
                }
                .padding()
                .toolbar{
                    Button("Close"){
                        isPresented.toggle()
                    }
                }
            }
        }
        .padding()
    }
}
