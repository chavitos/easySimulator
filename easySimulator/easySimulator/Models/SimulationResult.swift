//
//  SimulationResult.swift
//  easySimulator
//
//  Created by Tiago Chaves on 23/08/2018.
//  Copyright © 2018 easynvest. All rights reserved.
//

import Foundation

struct SimulationResult:Codable,Equatable {
    
    let grossAmount:Double
    let taxesAmount:Double
    let netAmount:Double
    let grossAmountProfit:Double
    let netAmountProfit:Double
    let annualGrossRateProfit:Double
    let monthlyGrossRateProfit:Double
    let dailyGrossRateProfit:Double
    let taxesRate:Double
    let rateProfit:Double
    let annualNetRateProfit:Double
    
    let investmentParameter:SimulationInput
    
    static func == (lhs: SimulationResult, rhs: SimulationResult) -> Bool {
        return lhs.grossAmount == rhs.grossAmount &&
            lhs.taxesRate == rhs.taxesAmount  &&
            lhs.netAmount == rhs.netAmount &&
            lhs.grossAmountProfit == rhs.grossAmountProfit &&
            lhs.netAmountProfit == rhs.netAmountProfit &&
            lhs.annualGrossRateProfit == rhs.annualGrossRateProfit &&
            lhs.monthlyGrossRateProfit == rhs.monthlyGrossRateProfit &&
            lhs.dailyGrossRateProfit == rhs.dailyGrossRateProfit &&
            lhs.taxesRate == rhs.taxesRate &&
            lhs.rateProfit == rhs.rateProfit &&
            lhs.annualNetRateProfit == rhs.annualNetRateProfit &&
            lhs.investmentParameter == rhs.investmentParameter
    }
}
