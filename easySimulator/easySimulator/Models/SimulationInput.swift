//
//  SimulationInput.swift
//  easySimulator
//
//  Created by Tiago Chaves on 23/08/2018.
//  Copyright © 2018 easynvest. All rights reserved.
//

import Foundation

struct SimulationInput:Codable,Equatable {
    
    let investedAmount:Double
    let yearlyInterestRate:Double
    let maturityTotalDays:Int
    let maturityBusinessDays:Int
    let maturityDate:String
    let rate:Int
    let isTaxFree:Bool
    
    static func ==(lhs:SimulationInput, rhs:SimulationInput) -> Bool {
        return lhs.investedAmount == rhs.investedAmount &&
            lhs.yearlyInterestRate == rhs.yearlyInterestRate &&
            lhs.maturityDate == rhs.maturityDate &&
            lhs.maturityTotalDays == rhs.maturityTotalDays &&
            lhs.maturityBusinessDays == rhs.maturityBusinessDays &&
            lhs.rate == rhs.rate &&
            lhs.isTaxFree == rhs.isTaxFree
    }
}
