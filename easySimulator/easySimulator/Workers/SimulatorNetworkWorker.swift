//
//  SimulatorWorker.swift
//  easySimulator
//
//  Created by Tiago Chaves on 23/08/2018.
//  Copyright (c) 2018 easynvest. All rights reserved.
//

import Foundation

enum SimulatorNetworkURLs:String {
    
    case getSimulationResult = "/calculator/simulate"
    
    func getUrl() -> String {
        return BaseURLs.prod.rawValue + self.rawValue
    }
}

class SimulatorNetworkWorker:SimulatorInputWorkerProtocol {
    
    func getSimulationResult(withInvestedAmount investedAmount: Double, rate: Int, andMaturityDate maturityDate: Date, completionHandler: @escaping (() throws -> SimulationResult) -> Void) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let url = SimulatorNetworkURLs.getSimulationResult.getUrl()
        
        let params = ["investedAmount":"\(investedAmount)",
            "index":"CDI",
            "rate":"\(rate)",
            "isTaxFree":"false",
            "maturityDate":formatter.string(from: maturityDate)]
        
        
        let networkManager = NetworkManager()
        
        networkManager.getData(toUrl: url, withParams: params) { (response) in
            switch response {
            case .success(let dataResponse):
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(SimulationResult.self, from: dataResponse.data)
                    completionHandler{ return responseModel }
                    
                } catch let error as NSError? {
                    completionHandler{ throw SimulationError.cannotSimulate("CannotSimulate \(String(describing: error)), \(String(describing: error?.userInfo))") }
                }
                break
            case .fail(let serviceError):
                if let error = serviceError {
                    completionHandler { throw error }
                }
                completionHandler { throw SimulationError.cannotSimulate("CannotSimulate") }
                break
            }
        }
    }
}
