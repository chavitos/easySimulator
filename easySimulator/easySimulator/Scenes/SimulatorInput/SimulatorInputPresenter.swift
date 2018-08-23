//
//  SimulatorInputPresenter.swift
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

protocol SimulatorInputPresentationLogic
{
    func presentSimulationResult(response: SimulatorInput.Simulation.Response)
    func presentFormatedMaturityDate(response: SimulatorInput.FormatMaturityDate.Response)
    func presentFormatedNumericField(response: SimulatorInput.FormatNumericField.Response)
}

class SimulatorInputPresenter: SimulatorInputPresentationLogic
{
    weak var viewController: SimulatorInputDisplayLogic?
    
    // MARK: Do something
    
    func presentSimulationResult(response: SimulatorInput.Simulation.Response)
    {
        let viewModel = SimulatorInput.Simulation.ViewModel(success: (response.error == nil))
        viewController?.displaySimulationResult(viewModel: viewModel)
    }
    
    func presentFormatedMaturityDate(response: SimulatorInput.FormatMaturityDate.Response) {
        
        let dateFormatter = DateFormatter().getDateFormatter(withFormat: "dd/MM/yyyy")
        let date = dateFormatter.string(from: response.maturityDate)
        let viewModel = SimulatorInput.FormatMaturityDate.ViewModel(formatedMaturityDate: date)
        
        viewController?.displayFormattedMaturityDate(viewModel: viewModel)
    }
    
    func presentFormatedNumericField(response: SimulatorInput.FormatNumericField.Response) {
        switch response.fieldType {
        case .amount(let tag):
            
            let formatter = NumberFormatter().getCurrencyFormatter()
//            formatter.numberStyle = .currencyAccounting
//            formatter.locale = Locale(identifier: "pt_BR")
//            formatter.maximumFractionDigits = 2
//            formatter.minimumFractionDigits = 2
            
            var amountWithPrefix = response.value
            
            // remove from String: "R$", ".", ","
            guard let regex = try? NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive) else { return }
            
            amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, response.value.count), withTemplate: "")
            
            let double = (amountWithPrefix as NSString).doubleValue
            let number = NSNumber(value: (double / 100))
            
            let viewModel = SimulatorInput.FormatNumericField.ViewModel(formatedValue: formatter.string(from: number) ?? "", tag: tag)
            viewController?.displayFormattedNumericField(viewModel: viewModel)
            return
        case .rate(let tag):
            //Apesar de funcionar como um by-pass, implementei dessa forma para demonstrar como funcionaria com tratamento de outros campos numéricos :)
            let viewModel = SimulatorInput.FormatNumericField.ViewModel(formatedValue: response.value, tag: tag)
            viewController?.displayFormattedNumericField(viewModel: viewModel)
            return
        }
    }
}
