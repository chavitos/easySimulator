//
//  SimulatorResultViewController.swift
//  easySimulator
//
//  Created by Tiago Chaves on 23/08/2018.
//  Copyright (c) 2018 easynvest. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SimulatorResultDisplayLogic: class
{
    func displaySimulationResult(viewModel: SimulatorResult.GetSimulationResult.ViewModel)
}

class SimulatorResultViewController: UIViewController, SimulatorResultDisplayLogic
{
    var interactor: SimulatorResultBusinessLogic?
    var router: (NSObjectProtocol & SimulatorResultRoutingLogic & SimulatorResultDataPassing)?
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = SimulatorResultInteractor()
        let presenter = SimulatorResultPresenter()
        let router = SimulatorResultRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getSimulationResult()
    }
    
    // MARK: - Get Simulation Result
    func getSimulationResult()
    {
        interactor?.getSimulationResult()
    }
    
    // MARK: - Display Simulation Result
    func displaySimulationResult(viewModel: SimulatorResult.GetSimulationResult.ViewModel)
    {
        
    }
}
