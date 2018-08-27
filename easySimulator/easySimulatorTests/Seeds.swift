//
//  Seeds.swift
//  easySimulatorTests
//
//  Created by Tiago Chaves on 26/08/2018.
//  Copyright © 2018 easynvest. All rights reserved.
//

@testable import easySimulator
import Foundation

struct Seeds{
    struct SimulationResults {
        static let simulationResult = SimulationResult(grossAmount: 60528.20, taxesAmount: 4230.78,
                                                       netAmount: 56297.42, grossAmountProfit: 28205.20,
                                                       netAmountProfit: 23974.42, annualGrossRateProfit: 87.26,
                                                       monthlyGrossRateProfit: 0.76, dailyGrossRateProfit: 0.000445330025305748,
                                                       taxesRate: 15.0, rateProfit: 9.5512, annualNetRateProfit: 74.17,
                                                       investmentParameter: SimulationInput(investedAmount: 32323.0, yearlyInterestRate: 9.5512, maturityTotalDays: 1981, maturityBusinessDays: 1409, maturityDate: "2023-03-03T00:00:00", rate: 123, isTaxFree: false))
    }
}
