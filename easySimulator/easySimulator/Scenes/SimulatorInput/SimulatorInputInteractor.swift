//
//  SimulatorInputInteractor.swift
//  easySimulator
//
//  Created by Tiago Chaves on 22/08/2018.
//  Copyright (c) 2018 easynvest. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SimulatorInputBusinessLogic
{
    func simulate(request: SimulatorInput.Simulation.Request)
    func formatMaturityDate(request: SimulatorInput.FormatMaturityDate.Request)
    func formatNumericField(request: SimulatorInput.FormatNumericField.Request)
}

protocol SimulatorInputDataStore
{
    var simulationResult: SimulationResult? { get set }
}

class SimulatorInputInteractor: SimulatorInputBusinessLogic, SimulatorInputDataStore
{
    var simulationResult: SimulationResult?
    var presenter: SimulatorInputPresentationLogic?
    var worker: SimulatorInputWorker? = SimulatorInputWorker(SimulatorNetworkWorker())
    
    // MARK: Do something
    
    func simulate(request: SimulatorInput.Simulation.Request)
    {
        
        let formatter = NumberFormatter().getCurrencyFormatter()
        
        guard let investedAmount = formatter.number(from: request.investedAmount)?.doubleValue,
            let rate = Int(request.rate) else{
                
                let response = SimulatorInput.Simulation.Response(result: nil, error: SimulationError.cannotSimulate("CannotSimulate"))
                self.presenter?.presentSimulationResult(response: response)
                return
        }
        
        worker?.getSimulationResult(withInvestedAmount: investedAmount, rate: rate, andMaturityDate: request.maturityDate, completionHandler: { (simulationResult, error) in
            
            let response:SimulatorInput.Simulation.Response
            
            if let result = simulationResult {
                self.simulationResult = result
                response = SimulatorInput.Simulation.Response(result: result, error: nil)
            }else{
                response = SimulatorInput.Simulation.Response(result: nil, error: error)
            }
            
            self.presenter?.presentSimulationResult(response: response)
        })
    }
    
    func formatMaturityDate(request: SimulatorInput.FormatMaturityDate.Request) {
        
        let response = SimulatorInput.FormatMaturityDate.Response(maturityDate: request.maturityDate)
        presenter?.presentFormatedMaturityDate(response: response)
    }
    
    func formatNumericField(request: SimulatorInput.FormatNumericField.Request) {
        let response = SimulatorInput.FormatNumericField.Response(value: request.value, fieldType: request.fieldType)
        presenter?.presentFormatedNumericField(response: response)
    }
}
