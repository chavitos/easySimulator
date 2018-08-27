//
//  SimulatorResultPresenter.swift
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

protocol SimulatorResultPresentationLogic
{
    func presentSimulationResult(response: SimulatorResult.GetSimulationResult.Response)
}

class SimulatorResultPresenter: SimulatorResultPresentationLogic
{
    weak var viewController: SimulatorResultDisplayLogic?
    
    // MARK: Do something
    
    func presentSimulationResult(response: SimulatorResult.GetSimulationResult.Response)
    {
        
        getDisplaySimulationResult(ofSimulationResult: response.simulationResult) { (displayResult) in
            let viewModel = SimulatorResult.GetSimulationResult.ViewModel(displayResult: displayResult)
            self.viewController?.displaySimulationResult(viewModel: viewModel)
        }
    }
    
    func getDisplaySimulationResult(ofSimulationResult simulationResult:SimulationResult, completionHandler:@escaping ((DisplaySimulationResult) -> Void)) {
        
        DispatchQueue.global(qos: .background).async {
            
            let currencyFormatter    = NumberFormatter().getCurrencyFormatter()
            let dateFormatterService = DateFormatter().getDateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
            let dateFormatterUser    = DateFormatter().getDateFormatter(withFormat: "dd/MM/yyyy")
            
            let date = dateFormatterService.date(from: simulationResult.investmentParameter.maturityDate)
            
            //R$ Valor aplicado inicialmente
            let investedAmount:String = currencyFormatter.string(from: NSNumber(value:simulationResult.investmentParameter.investedAmount)) ?? "R$ 0,00"
            //R$ Valor bruto do investimento
            let grossAmount:String = currencyFormatter.string(from: NSNumber(value:simulationResult.grossAmount)) ?? "R$ 0,00"
            //R$ Valor do rendimento
            let grossAmountProfit:String = currencyFormatter.string(from: NSNumber(value: simulationResult.grossAmountProfit)) ?? "R$ 0,00"
            //R$ Valor do IR
            let taxesAmount:String = currencyFormatter.string(from: NSNumber(value: simulationResult.taxesAmount)) ?? "R$ 0,00"
            //% IR
            let taxesRate:String = String(format: "%.2f%%", simulationResult.taxesRate)
            //R$ Valor líquido
            let netAmount:String = currencyFormatter.string(from: NSNumber(value: simulationResult.netAmount)) ?? "R$ 0,00"
            
            //Data de vencimento
            let maturityDate:String = dateFormatterUser.string(from: date!)
            // Dias corridos
            let maturityTotalDays:String = "\(simulationResult.investmentParameter.maturityTotalDays)"
            //% Rentabilidade bruta mensal
            let monthlyGrossRateProfit:String =  String(format: "%.2f%%", simulationResult.monthlyGrossRateProfit)
            //% Percentual do CDI
            let rate:String = String(format: "%ld%%", simulationResult.investmentParameter.rate)
            //% Rentabilidade bruta anual
            let annualGrossRateProfit:String = String(format: "%.2f%%", simulationResult.annualGrossRateProfit)
            //% Rentabilidade no período
            let rateProfit:String = String(format: "%.2f%%", simulationResult.rateProfit)
            
            let displayResult = DisplaySimulationResult(investedAmount: investedAmount,
                                                        grossAmount: grossAmount,
                                                        grossAmountProfit: grossAmountProfit,
                                                        taxesAmount: taxesAmount,
                                                        taxesRate: taxesRate,
                                                        netAmount: netAmount,
                                                        maturityDate: maturityDate,
                                                        maturityTotalDays: maturityTotalDays,
                                                        monthlyGrossRateProfit: monthlyGrossRateProfit,
                                                        rate: rate,
                                                        annualGrossRateProfit: annualGrossRateProfit,
                                                        rateProfit: rateProfit)
            completionHandler(displayResult)
        }
    }
}
