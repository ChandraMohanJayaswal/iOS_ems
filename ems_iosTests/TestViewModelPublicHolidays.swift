//
//  TestViewModelPublicHolidays.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Testing
@testable import ems_ios
final class MockViewModelPublicHolidaysService: ViewModelPublicHolidaysServiceProtocol{
    var shouldSucceed  = true
    func getFiscalYear(completion: @escaping ([FiscalYear]) -> Void) async {
        if shouldSucceed{
            completion([FiscalYear.mock])
        }
    }
    func getPublicHolidays(completion: @escaping ([PublicHolidaysAPIResponseDetails]) -> Void) async {
        if shouldSucceed{
            completion([PublicHolidaysAPIResponseDetails.mock])
        }
    }
}
struct TestViewModelPublicHolidays {
    let apiService: MockViewModelPublicHolidaysService
    let viewModel: ViewModelPublicHolidays
    init(){
        self.apiService = MockViewModelPublicHolidaysService()
        self.viewModel = ViewModelPublicHolidays(apiService: apiService)
    }
    @Test func testFetchFiscalYearFromServerSuccess() async{
        await viewModel.fetchFiscalYearFromServer()
        #expect(!viewModel.fiscalYearList.isEmpty)
    }
    @Test func testFetchFiscalYearFromServerFailure() async{
        apiService.shouldSucceed = false
        await viewModel.fetchFiscalYearFromServer()
        #expect(viewModel.fiscalYearList.isEmpty)
    }
    @Test func testFetchPublichHolidaysFromServerSuccess() async{
        await viewModel.fetchPublicHolidaysFromServer()
        #expect(!viewModel.allpublicHolidayList.isEmpty)
    }
    
    @Test func testFetchPublichHolidaysFromServerFailure() async{
        apiService.shouldSucceed = false
        await viewModel.fetchPublicHolidaysFromServer()
        #expect(viewModel.allpublicHolidayList.isEmpty)
    }
    @Test func testTruncateDescription(){
        var description = "This is a mock description"
        description = viewModel.truncateDescription(description)
        #expect(description.count <= 10)
    }
}

