//
//  BitcoinService.swift
//  BitcoinTicker
//
//  Created by Roman Bogun on 7/9/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol AnycoinProtocol {
    
    func getCoinPrice(for currency: String, completionHandler: @escaping (BitcoinPriceDataModel?) -> Void)
}

class BitcoinService: AnycoinProtocol {
    
    private let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    func getCoinPrice(for currency: String, completionHandler: @escaping (BitcoinPriceDataModel?) -> Void) {
        
        let url = getUrl(for: currency)
        Alamofire.request(url, method: .get).responseJSON {
            response in
            
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                let model = self.convertToDataModel(json: json)
                
                completionHandler(model)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    private func getUrl(for currency: String) -> URL {
        let url = "\(baseURL)\(currency)"
        return URL(string: url)!
    }
    
    private func convertToDataModel(json: JSON) -> BitcoinPriceDataModel {
        
        let resultModel = BitcoinPriceDataModel()
        
        if let lastResult = json["last"].double {
            
            resultModel.last = lastResult
            resultModel.ask = json["ask"].doubleValue
            resultModel.bid = json["bid"].doubleValue
            resultModel.high = json["high"].doubleValue
            resultModel.low = json["low"].doubleValue
        }
        
        return resultModel
    }
}
