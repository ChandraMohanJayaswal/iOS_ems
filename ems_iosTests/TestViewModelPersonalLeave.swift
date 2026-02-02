//
//  TestViewModelPersonalLeave.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Foundation
import Testing
@testable import  ems_ios
final class MockViewModelPersonalLeaveService: ViewModelPersonalLeaveServiceProtocol{
    var shouldSucceed: Bool = true
    var sendDataSuccessful: Bool = true
    func getLeaveType(completion: @escaping ([LeaveType])-> Void) async{
        if shouldSucceed{
            completion([LeaveType.mock])
            sendDataSuccessful = true
        }
        else{
            sendDataSuccessful = false
        }
    }
    func postPersonalLeave(selectedLeaveType: Int, leaveFromDate: String, leaveToDate: String, description: String) async {
        if shouldSucceed{
            sendDataSuccessful = true
        }
        else {
            sendDataSuccessful = false
        }
    }
}

struct TestViewModelPersonalLeave {
    let apiService: MockViewModelPersonalLeaveService
    let viewModel: ViewModelPersonalLeave
    init(){
        apiService = MockViewModelPersonalLeaveService()
        viewModel = ViewModelPersonalLeave(apiService: apiService)
    }
    @Test func testFetchLeaveTypeFromServerSuccess() async{
        await viewModel.fetchLeaveTypeFromServer()
        #expect(!viewModel.leaveTypeList.isEmpty)
    }
    @Test func testFetchLeaveTypeFromServerFailure() async{
        apiService.shouldSucceed = false
        await viewModel.fetchLeaveTypeFromServer()
        #expect(viewModel.leaveTypeList.isEmpty)
    }
    @Test func testPostPersonalLeaveToServerSuccess() async{
        viewModel.selectedLeaveType = 0
        viewModel.leaveFromDate = Date.now
        viewModel.leaveToDate = Date.now
        viewModel.description = "Mock description"
        await viewModel.postPersonalLeaveToServer()
        #expect(apiService.sendDataSuccessful)
    }
    @Test func testPostPersonalLeaveToServerFailure() async{
        viewModel.selectedLeaveType = 0
        viewModel.leaveFromDate = Date.now
        viewModel.leaveToDate = Date.now
        viewModel.description = "Mock description"
        apiService.shouldSucceed = false
        await viewModel.postPersonalLeaveToServer()
        #expect(!apiService.sendDataSuccessful)
    }
}
