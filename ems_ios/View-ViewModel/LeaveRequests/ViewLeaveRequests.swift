//
//  ViewLeaveRequests.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI
struct ViewLeaveRequests: View {
    @StateObject var viewModel = ViewModelLeaveRequests()
    var body: some View {
        NavigationStack{
            List{
                    ForEach(viewModel.leaveRequests){ item in
                        LeaveRequestsListView(leaveType:item.leaveTypeRes.typeOfLeave, leaveRequestedDate: item.leaveRequestedDate, leaveRequestedTime: item.leaveRequestedTime, leaveFromDate: item.leaveFromDate, leaveToDate: item.leaveToDate, description: item.description, leaveStatus: item.leaveStatusRes.statusType, comment: item.statusComment)
                    }
            }
                .navigationTitle("Leave Requests")
                .navigationBarTitleDisplayMode( .inline )
                .modifier(ToolbarSideMenu())
        }.refreshable {
            Task{
                await viewModel.fetchMyLeaveRequestsFromServer()
            }
        }
        .onAppear{
            Task{
                await viewModel.fetchMyLeaveRequestsFromServer()
            }
        }
    }
}
struct LeaveRequestsListView: View{
    let leaveType: String
    let leaveRequestedDate: String
    let leaveRequestedTime: String
    let leaveFromDate: String
    let leaveToDate: String
    let description: String
    let leaveStatus: String
    let comment: String
    @State var isSheetPresented: Bool = false
    var body :some View{
        VStack{
            Text("Requested Date: \(leaveRequestedDate)" )
            Text("Click to detail view...")
                .foregroundStyle(.gray)
        }.onTapGesture{
            isSheetPresented = true
        }
        .sheet(isPresented: $isSheetPresented){
            NavigationStack{
                VStack(alignment:.leading){
                    Form{
                        HStack{
                            Text("Leave Type: ")
                            Spacer()
                            Text("\(leaveType)")
                        }
                        HStack{
                            Text("Requested Date:")
                            Spacer()
                            Text("\(leaveRequestedDate)")
                        }
                        HStack{
                            Text("Requested Time: ")
                            Spacer()
                            Text("\(leaveRequestedTime)")
                        }
                        HStack{
                            Text("From Date: ")
                            Spacer()
                            Text("\(leaveFromDate)")
                        }
                        HStack{
                            Text("To Date:")
                            Spacer()
                            Text("\(leaveToDate)")
                        }
                        HStack{
                            Text("Description: ")
                            Spacer()
                            Text("\(description)")
                        }
                        HStack{
                            Text("Leave Status: ")
                            Spacer()
                            Text("\(leaveStatus)")
                        }
                        HStack{
                            Text("Comment: ")
                            Spacer()
                            Text("\(comment)")
                        }
                    }.toolbar{
                        Button("Close"){
                            isSheetPresented.toggle()
                        }
                        .foregroundStyle(.red)
                    }
                }
            }
        }
    }
}
