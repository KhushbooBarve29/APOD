//
//  APODSwiftTests.swift
//  APODSwiftTests
//
//  Created by Khushboo Barve on 29/03/2025.
//

import XCTest
@testable import APODSwift
class APODViewModelTests: XCTestCase {
    var viewModel: APODViewModel!
    var mockService: APODServiceMock!
    override func setUpWithError() throws {
        super.setUp()
        mockService = APODServiceMock()
        viewModel = APODViewModel(service: mockService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testStaticStrings() {
        XCTAssertEqual(viewModel.title, "NASA APOD")
        XCTAssertEqual(viewModel.alertErrorTitle, "Error")
        XCTAssertEqual(viewModel.alertErrorMessage, "Something went wrong.")
        XCTAssertEqual(viewModel.alertErrorButton, "OK")
        XCTAssertEqual(viewModel.changeDateButton, "Change Date")
        XCTAssertEqual(viewModel.videoAlternate, "Video format not supported")
        XCTAssertEqual(viewModel.tabBar, "APOD")
        XCTAssertEqual(viewModel.tabBarSetting, "Settings")
        XCTAssertEqual(viewModel.DatePickerTitle, "Pick Your Date")
        XCTAssertEqual(viewModel.DoneButton, "Done")
    }
    
    func testFetchAPODSuccess() async {
        let expectation = XCTestExpectation(description: "APOD fetch completes")
        
        // Mock Data set up
        let mockAPOD = APODModel(title: "Test APOD", date: "2025-03-29", explanation: "Sample Explanation", hdurl: nil, mediaType: "image", serviceVersion: nil, url: "https://test.url")
        mockService.mockAPOD = mockAPOD
        await viewModel.fetchAPOD(for: Date())
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(viewModel.apod?.title, "Test APOD")
    }
    
    func testFetchAPODFailureWithBadResponse() async {
        mockService.APIError = APIError.badResponse
        let expectation = self.expectation(description: "APOD fetch should fail")
        await viewModel.fetchAPOD(for: Date())
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.errorMessage, APIError.badResponse.description(), "The error message should match the bad response error description")
            expectation.fulfill()
        }
        
        // Waiting for expectation to be fulfilled within timeout
        await waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchAPODFailureWithNoData() async {
        mockService.APIError = APIError.noData
        let expectation = self.expectation(description: "APOD fetch should fail")
        await viewModel.fetchAPOD(for: Date())
        DispatchQueue.main.async {
            XCTAssertEqual(self.viewModel.errorMessage, APIError.noData.description(), "The error message should match the no data error description")
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 2, handler: nil)
    }
    
}
