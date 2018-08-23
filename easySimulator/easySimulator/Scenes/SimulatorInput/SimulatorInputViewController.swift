//
//  SimulatorInputViewController.swift
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
import Foundation

protocol SimulatorInputDisplayLogic: class
{
    func displaySimulationResult(viewModel: SimulatorInput.Simulation.ViewModel)
    func displayFormattedMaturityDate(viewModel: SimulatorInput.FormatMaturityDate.ViewModel)
    func displayFormattedNumericField(viewModel: SimulatorInput.FormatNumericField.ViewModel)
}

class SimulatorInputViewController: UIViewController, SimulatorInputDisplayLogic
{
    var interactor: SimulatorInputBusinessLogic?
    var router: (NSObjectProtocol & SimulatorInputRoutingLogic & SimulatorInputDataPassing)?
    
    // MARK: Object lifecycle
    
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
        let interactor = SimulatorInputInteractor()
        let presenter = SimulatorInputPresenter()
        let router = SimulatorInputRouter()
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
        maturityDateTextField.inputView = maturityDatePicker
        investedAmountTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        rateTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
     
    }
    
    // MARK: - Outlets and Actions
    @IBOutlet weak var investedAmountTextField: UITextField!
    @IBOutlet weak var maturityDateTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var simulatingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var maturityDatePicker: UIDatePicker!
    
    @IBAction func maturityDateValueChanged(_ sender: Any) {
        let request  = SimulatorInput.FormatMaturityDate.Request(maturityDate: maturityDatePicker.date)
        interactor?.formatMaturityDate(request: request)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == investedAmountTextField {
            let request = SimulatorInput.FormatNumericField.Request(value: textField.text!, fieldType: .amount(textField.tag))
            interactor?.formatNumericField(request: request)
        }else if textField == rateTextField {
            let request = SimulatorInput.FormatNumericField.Request(value: textField.text!, fieldType: .rate(textField.tag))
            interactor?.formatNumericField(request: request)
        }
    }
    
    @IBAction func requestSimulation(_ sender: Any) {
        
        let investedAmount = investedAmountTextField.text ?? "0"
        let maturityDate = maturityDatePicker.date
        let rate = rateTextField.text ?? "0"
        
        let request = SimulatorInput.Simulation.Request(investedAmount: investedAmount, rate: rate, maturityDate: maturityDate)
        interactor?.simulate(request: request)
        simulatingActivityIndicator.startAnimating()
    }
    
    //MARK: - SimulatorInputDisplayLogic
    func displaySimulationResult(viewModel: SimulatorInput.Simulation.ViewModel)
    {
        DispatchQueue.main.async {
            self.simulatingActivityIndicator.stopAnimating()
        }
        
        if !viewModel.success {
            let alert = UIAlertController(title: "Atenção", message: "Erro ao tentar simular rendimento.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else{
            //TODO - Fazer routing para próxima scene
        }
    }
    
    func displayFormattedMaturityDate(viewModel: SimulatorInput.FormatMaturityDate.ViewModel) {
        
        maturityDateTextField.text = viewModel.formatedMaturityDate
    }
    
    func displayFormattedNumericField(viewModel: SimulatorInput.FormatNumericField.ViewModel) {
        
        let tag = viewModel.tag
        let text = viewModel.formatedValue
        
        if let textField = view.viewWithTag(tag) as? UITextField{
            textField.text = text
        }
    }
}

//MARK: - UITextFieldDelegate
extension SimulatorInputViewController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = (strcmp(char, "\\b") == -92)
        
        if textField == investedAmountTextField && textField.text!.count >= 13 && !isBackSpace {
            return false
        }else if textField == rateTextField && textField.text!.count >= 3 && !isBackSpace {
            return false
        }
        
        return true
    }
}
