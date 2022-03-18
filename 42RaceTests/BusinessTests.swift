//
//  BusinessTests.swift
//  42Race
//
//  Created by BeLive on 3/18/22.
//

import XCTest

enum AppDataServiceError : Error {
    case invalidResponse
}

class BusinessTests: XCTestCase {

    var vm: BusinessViewModel!
    var mockDataService: MockDataService!
    var responseMonitor: MonitorBusinessViewModelDelegate!

    override func setUp() {
        super.setUp()
        // setting up mock environment and response monitor
        mockDataService = MockDataService()
        responseMonitor = MonitorBusinessViewModelDelegate()
        vm = BusinessViewModel(mockDataService)
        vm.delegate = responseMonitor
    }

    override func tearDown() {
        super.tearDown()
        mockDataService = nil
        vm = nil
        responseMonitor = nil
    }
    /// After successfully loading Business list
    /// Expected behaviour:
    /// - only show loading should be true and started loading should be called
    /// - items loaded should be called and items count should be correct
    func testDataLoadSuccessfully() {

        // setting up expectation
        let startedLoadingExpectation = expectation(description: "got callback start loading")
        let itemsLoadedExpectation = expectation(description: "items loaded expectation")
        // simulating the enviornment
        mockDataService.error = nil
        mockDataService.business = [BusinessModel()]

        // setting up response monitors
        responseMonitor.didStartLoadingCallback = {
            XCTAssert(self.vm.showLoading, "Loading flag should be true")
            XCTAssert(!self.vm.showError, "Error flag should not be true")
            startedLoadingExpectation.fulfill()
        }
        responseMonitor.errorDidOccurCallback = { error in
            XCTAssert(false, "Invalid error callback")
        }
        responseMonitor.itemsLoadedCallback = {
            XCTAssert(!self.vm.showLoading, "Loading flag should not be true")
            XCTAssert(!self.vm.showError, "Error flag should not be true")
            XCTAssert(self.vm.business.count == 1, "Invalid items loaded")
            itemsLoadedExpectation.fulfill()
        }

        // performing action
        vm.searchBusiness(text: "sample")

        // check for expectation
        wait(for: [
            startedLoadingExpectation,
            itemsLoadedExpectation
            ], timeout: 1, enforceOrder: true)
    }

    /// Loading Business list ends with error
    /// Expected behaviour:
    /// - showError should be true and only error did occure should be called
    /// - errorMessage should say "Unable to load Business. Please try again !"
    func testDataLoadedWithError() {

        // setting up expectation
        let startedLoadingExpectation = expectation(description: "got callback start loading.")
        let errorOccuredExpectation = expectation(description: "loading error expectation.")

        // simulating the enviornment
        mockDataService.error = AppDataServiceError.invalidResponse
        
        // setting up response monitors
        responseMonitor.didStartLoadingCallback = {
            XCTAssert(self.vm.showLoading, "Loading flag should be true.")
            XCTAssert(!self.vm.showError, "Error flag should not be true.")
            startedLoadingExpectation.fulfill()
        }
        responseMonitor.errorDidOccurCallback = { error in
            XCTAssert(!self.vm.showLoading, "Loading flag should not be true.")
            XCTAssert(self.vm.showError, "Error flag should be true.")
            XCTAssert(self.vm.business.count == 0, "Items count should be 0.")
            errorOccuredExpectation.fulfill()
        }
        responseMonitor.itemsLoadedCallback = {

            XCTAssert(false, "Items loaded callback should not be called.")
        }

        // performing action
        vm.searchBusiness(text: "abc")

        // check for expectation
        wait(for: [
            startedLoadingExpectation,
            errorOccuredExpectation
        ], timeout: 1, enforceOrder: true)
    }

    /// Loaded Business list is empty
    /// Expected behaviour:
    /// - showError should be true and only error did occure should be called
    /// - errorMessage should say "No Business available at the moment."
    func testDataLoadedWithEmptyList() {

        // setting up expectation
        let startedLoadingExpectation = expectation(description: "got callback start loading.")
        let errorOccuredExpectation = expectation(description: "loading error expectation.")

        // simulating the enviornment
        mockDataService.error = nil
        mockDataService.business = []

        // setting up response monitors
        responseMonitor.didStartLoadingCallback = {
            XCTAssert(self.vm.showLoading, "Loading flag should be true.")
            XCTAssert(!self.vm.showError, "Error flag should not be true.")
            startedLoadingExpectation.fulfill()
        }
        responseMonitor.errorDidOccurCallback = { error in

            XCTAssert(!self.vm.showLoading, "Loading flag should not be true.")
            XCTAssert(self.vm.showError, "Error flag should be true.")
            XCTAssert(self.vm.business.count == 0, "Items count should be 0.")
            errorOccuredExpectation.fulfill()
        }
        responseMonitor.itemsLoadedCallback = {
            XCTAssert(true, "Items loaded callback should be called.")
        }

        // performing action
        vm.searchBusiness(text: "sample")

        // check for expectation
        wait(for: [
            startedLoadingExpectation,
            errorOccuredExpectation
        ], timeout: 1, enforceOrder: true)
    }
}
