//
//  TestViewModelLogin.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Testing
@testable import ems_ios
final class MockViewModelLoginService: ViewModelLoginServiceProtocol{
    var shouldSucceed = true
    func login(email: String, password: String) async throws{
        if shouldSucceed{
        }
        else {
            throw APIError.invalidResponse
        }
    }
}
struct TestViewModelLogin{
    let apiService: MockViewModelLoginService
    let viewModel: ViewModelLogin
    init(){
        self.apiService = MockViewModelLoginService()
        self.viewModel = ViewModelLogin(apiSerivce: apiService)
    }
    @Test func testLoginSuccess ()async{
        await viewModel.login()
        #expect(viewModel.isAuthenticated)
    }
    @Test func testLoginFailure()async{
        apiService.shouldSucceed = false
        await viewModel.login()
        #expect(!viewModel.isAuthenticated)
    }
}
