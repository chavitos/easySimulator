//
//  SimulatorInputRouter.swift
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

@objc protocol SimulatorInputRoutingLogic
{
    func routeToSimulatorResult(segue: UIStoryboardSegue?)
}

protocol SimulatorInputDataPassing
{
    var dataStore: SimulatorInputDataStore? { get }
}

class SimulatorInputRouter: NSObject, SimulatorInputRoutingLogic, SimulatorInputDataPassing
{
    weak var viewController: SimulatorInputViewController?
    var dataStore: SimulatorInputDataStore?
    
    // MARK: Routing
    
    func routeToSimulatorResult(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            let destinationVC = segue.destination as! SimulatorResultViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSimulatorResult(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "SimulatorResultViewController") as! SimulatorResultViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSimulatorResult(source: dataStore!, destination: &destinationDS)
            navigateToSimulatorResult(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Navigation
    
    func navigateToSimulatorResult(source: SimulatorInputViewController, destination: SimulatorResultViewController)
    {
      source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToSimulatorResult(source: SimulatorInputDataStore, destination: inout SimulatorResultDataStore)
    {
        destination.simulationResult = source.simulationResult
    }
}
