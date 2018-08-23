//
//  SimulationInput.swift
//  easySimulator
//
//  Created by Tiago Chaves on 23/08/2018.
//  Copyright © 2018 easynvest. All rights reserved.
//

import Foundation

struct SimulationInput:Codable {
    
    let investedAmount:Double
    let yearlyInterestRate:Double
    let maturityTotalDays:Int
    let maturityBusinessDays:Int
    let maturityDate:String
    let rate:Int
    let isTaxFree:Bool
}
