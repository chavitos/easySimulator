//
//  SimulatorInputPresenterTests.swift
//  easySimulator
//
//  Created by Tiago Chaves on 26/08/2018.
//  Copyright (c) 2018 easynvest. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import easySimulator
import XCTest

class SimulatorInputPresenterTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: SimulatorInputPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupSimulatorInputPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSimulatorInputPresenter()
    {
        sut = SimulatorInputPresenter()
    }
    
    // MARK: Test doubles
    
    class SimulatorInputDisplayLogicSpy: SimulatorInputDisplayLogic
    {
        var displaySimulationResultCalled = false
        var displayFormattedMaturityDateCalled = false
        var displayFormattedNumericFieldCalled = false
        
        var simulateViewModel:SimulatorInput.Simulation.ViewModel!
        var formatMaturityDateViewModel:SimulatorInput.FormatMaturityDate.ViewModel!
        var formatNumericFieldViewModel:SimulatorInput.FormatNumericField.ViewModel!
        
        func displaySimulationResult(viewModel: SimulatorInput.Simulation.ViewModel) {
            displaySimulationResultCalled = true
            simulateViewModel = viewModel
        }
        
        func displayFormattedMaturityDate(viewModel: SimulatorInput.FormatMaturityDate.ViewModel) {
            displayFormattedMaturityDateCalled = true
            formatMaturityDateViewModel = viewModel
        }
        
        func displayFormattedNumericField(viewModel: SimulatorInput.FormatNumericField.ViewModel) {
            displayFormattedNumericFieldCalled = true
            formatNumericFieldViewModel = viewModel
        }
    }
    
    // MARK: Tests
    
    func testPresentMaturityDateShouldConvertDateToString()
    {
        // Given
        let viewControllerSpy = SimulatorInputDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        var dateComponents = DateComponents()
        dateComponents.year = 2022
        dateComponents.month = 12
        dateComponents.day = 22
        let date = Calendar.current.date(from: dateComponents)!
        let response = SimulatorInput.FormatMaturityDate.Response(maturityDate: date)
        
        // When
        sut.presentFormatedMaturityDate(response:response)
        
        // Then
        let expectedDate = "22/12/2022"
        let returnedDate = viewControllerSpy.formatMaturityDateViewModel.formatedMaturityDate
        XCTAssertEqual(expectedDate, returnedDate, "Maturity date should be formatted as string -> \(expectedDate)")
    }
    
    func testPresentMaturityDateShouldAskViewControllerToDisplayMaturityDate() {
        
        let viewControllerSpy = SimulatorInputDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        let response = SimulatorInput.FormatMaturityDate.Response(maturityDate: Date())
        sut.presentFormatedMaturityDate(response: response)
        
        XCTAssertTrue(viewControllerSpy.displayFormattedMaturityDateCalled, "Present maturity date should ask view controller to display maturity date string")
    }
    
    func testPresentNumericFieldAmountShouldConvertNumberToCurrencyString() {
        
        let viewControllerSpy = SimulatorInputDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        let response = SimulatorInput.FormatNumericField.Response(value: "1201512", fieldType: .amount(100))
        sut.presentFormatedNumericField(response: response)
        
        let expectedAmount = "R$12.015,12"
        let expectedTag = 100
        let returnedAmount = viewControllerSpy.formatNumericFieldViewModel.formatedValue
        let returnedTag = viewControllerSpy.formatNumericFieldViewModel.tag
        
        XCTAssertEqual(expectedAmount, returnedAmount, "Amount should be formatted as String -> \(expectedAmount)")
        XCTAssertEqual(expectedTag, returnedTag, "Amount tag should be \(expectedTag)")
    }
    
    func testPresentNumericFieldRateShouldConvertNumberToCurrencyString() {
        
        let viewControllerSpy = SimulatorInputDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        let response = SimulatorInput.FormatNumericField.Response(value: "123", fieldType: .rate(101))
        sut.presentFormatedNumericField(response: response)
        
        let expectedAmount = "123"
        let expectedTag = 101
        let returnedAmount = viewControllerSpy.formatNumericFieldViewModel.formatedValue
        let returnedTag = viewControllerSpy.formatNumericFieldViewModel.tag
        
        XCTAssertEqual(expectedAmount, returnedAmount, "Rate should be formatted as String -> \(expectedAmount)")
        XCTAssertEqual(expectedTag, returnedTag, "Rate tag should be \(expectedTag)")
    }
    
    func testPresentNumericFieldShouldAskViewControllerToDisplayNumericFieldString() {
        
        let viewControllerSpy = SimulatorInputDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        let response = SimulatorInput.FormatNumericField.Response(value: "123", fieldType: .amount(100))
        sut.presentFormatedNumericField(response: response)
        
        XCTAssertTrue(viewControllerSpy.displayFormattedNumericFieldCalled, "Present numeric field should ask view controller to display numeric field string")
    }
    
    func testPresentSimulationResultSuccessShouldReturnTrueForErrorNil() {
        
        let viewControllerSpy = SimulatorInputDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        let response = SimulatorInput.Simulation.Response(result: Seeds.SimulationResults.simulationResult, error: nil)
        sut.presentSimulationResult(response: response)
        
        XCTAssertTrue(viewControllerSpy.simulateViewModel.success, "Simulation result success should be true for error = nil")
    }
    
    func testPresentSimulationResultSuccessShouldReturnFalseForAnyError() {
        
        let viewControllerSpy = SimulatorInputDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        let response = SimulatorInput.Simulation.Response(result: nil, error: SimulationError.cannotSimulate("Any error"))
        sut.presentSimulationResult(response: response)
        
        XCTAssertFalse(viewControllerSpy.simulateViewModel.success, "Simulation result success should be false for error != nil")
    }
    
    func testPresentSimulationResultShouldAskViewControllerToDisplaySimulationResult() {
        
        let viewControllerSpy = SimulatorInputDisplayLogicSpy()
        sut.viewController = viewControllerSpy
        
        let response = SimulatorInput.Simulation.Response(result: nil, error: nil)
        sut.presentSimulationResult(response: response)
        
        XCTAssertTrue(viewControllerSpy.displaySimulationResultCalled, "Present simulation result should ask view controller to display simulation result")
    }
}