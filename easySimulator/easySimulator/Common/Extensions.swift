//
//  Extensions.swift
//  easySimulator
//
//  Created by Tiago Chaves on 23/08/2018.
//  Copyright © 2018 easynvest. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    func getCurrencyFormatter() -> NumberFormatter {
    
        self.numberStyle = .currencyAccounting
        self.locale = Locale(identifier: "pt_BR")
        self.maximumFractionDigits = 2
        self.minimumFractionDigits = 2
        
        return self
    }
    
    func getPercentFormatter() -> NumberFormatter {
        
        self.numberStyle = .percent
        self.locale = Locale(identifier: "pt_BR")
        self.maximumFractionDigits = 2
        self.minimumFractionDigits = 2
        
        return self
    }
}

extension DateFormatter {
    
    func getDateFormatter(withFormat format:String) -> DateFormatter {
        
        self.dateFormat = format
        return self
    }
}
