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
            if !viewModel.fiscalYearList.isEmpty && !viewModel.publicHolidayList.isEmpty{
                Picker("Select Year", selection:$viewModel.selectedYear){
                    ForEach(Array(viewModel.fiscalYearList), id:\.self){ year in
                        Text("\(year)").tag(year)
                    }
                }.pickerStyle(.menu)
                List{
                    ForEach(viewModel.publicHolidayList.indices, id:\.self){ item in
                        PublicHolidaysCard(date: viewModel.publicHolidayList[item]["date"] ?? "NA", fiscalYear: viewModel.publicHolidayList[item]["fiscalYear"] ?? "NA", description: viewModel.publicHolidayList[item]["description"] ?? "NA")
                    }
                }
            }
            else {
                ProgressView()
            }
        }.navigationTitle("Public Holidays")
        .onAppear{
            Task{
             await viewModel.fetchFiscalYearFromServer()
            await viewModel.fetchPublicHolidaysFromServer()
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
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Text("Date: " + date)
                Spacer()
                Text("Fiscal year:" + fiscalYear)
            }
            Text("Description: " + description)
        }.padding()
    }
}
