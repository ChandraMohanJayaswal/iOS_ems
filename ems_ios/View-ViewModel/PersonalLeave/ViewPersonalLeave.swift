//
//  ViewPersonalLeave.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI
struct ViewPersonalLeave: View {
    @StateObject var viewModel = ViewModelPersonalLeave()
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Line Manager", selection: $viewModel.selectedLineManager){
                        ForEach(0..<3){ value in
                            Text("Something")
                                .tag(value)
                        }
                    }
                    
                    Picker("Leave Type", selection: $viewModel.selectedLeaveType){
                        Text("None Selected").tag(0)
                        ForEach(viewModel.leaveTypeList, id:\.id){ item in
                            Text("\(item.applyFor)").tag(item.id)
                        }
                    }
                    DatePicker("Date", selection: $viewModel.leaveRequestedDateTime, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("Leave From Date", selection: $viewModel.leaveFromDate, displayedComponents: [.date])
                    DatePicker("Leave To Date", selection: $viewModel.leaveToDate, displayedComponents: [.date])
                    TextField("Description", text: $viewModel.description, axis:.vertical)
                        .autocorrectionDisabled(true)
                }
                Section{
                    Button{
                        //do something here
                        print("Send data to server")
                    } label:{
                        HStack{
                            Spacer()
                            Text("Submit")
                            Image(systemName:"paperplane")
                            Spacer()
                        }
                    }
                }
            }
                .navigationTitle("Personal Leaves")
                .navigationBarTitleDisplayMode( .inline )
                .modifier(ToolbarSideMenu())
        }
        .onAppear{
            Task{
                await viewModel.fetchLeaveTypeFromServer()
            }
        }
    }
}

#Preview{
    ViewPersonalLeave()
}
