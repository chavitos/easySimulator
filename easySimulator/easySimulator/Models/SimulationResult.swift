//
//  SimulationResult.swift
//  easySimulator
//
//  Created by Tiago Chaves on 23/08/2018.
//  Copyright © 2018 easynvest. All rights reserved.
//

import Foundation

struct SimulationResult:Codable {
    
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
}
