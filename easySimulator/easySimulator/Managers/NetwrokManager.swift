//
//  NetwrokManager.swift
//  easySimulator
//
//  Created by Tiago Chaves on 23/08/2018.
//  Copyright © 2018 easynvest. All rights reserved.
//

import Foundation

enum BaseURLs:String {
    case prod = "https://api-simulator-calc.easynvest.com.br"
    case local = "http://localhost:5000"
}

enum Response {
    case success(DataResponse)
    case fail(Error?)
}

struct DataResponse {
    let data:Data
    let urlResponse:URLResponse
    
    init(_ data:Data, _ urlResponse:URLResponse) {
        self.data = data
        self.urlResponse = urlResponse
    }
}

class NetworkManager {
    
    lazy var session = URLSession.shared
    
    func getData(toUrl urlString:String, withParams params:[String:String]?, callback:@escaping ((Response)->Void)) {
        
        guard var urlComponents = URLComponents(string: urlString) else {return}
        
        if let params = params {
            var queryItems:[URLQueryItem] = []
            for param in params {
                
                let queryItem = URLQueryItem(name: param.key, value: param.value)
                queryItems.append(queryItem)
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else { return }
        
        session.dataTask(with: url) { (data, response, error) in
            
            if let data = data,
                let response = response as? HTTPURLResponse,
                (200..<300) ~= response.statusCode,
                error == nil {
                
                let dataResponse = DataResponse(data, response)
                callback(Response.success(dataResponse))
            }else{
                callback(Response.fail(error))
            }
        }.resume()
    }
}
