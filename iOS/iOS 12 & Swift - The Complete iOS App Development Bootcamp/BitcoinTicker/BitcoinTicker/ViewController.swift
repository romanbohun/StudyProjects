//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","UAH","USD","ZAR"]
    private let currencySignArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "₴", "$", "R"]
    
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    private var coinService: AnycoinProtocol! = BitcoinService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        initScreenState()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        getBitcoinPrice(for: currencyArray[row])
    }

    private func initScreenState() {
        
        let index = currencyArray.count - 3
        currencyPicker.selectRow(index, inComponent: 0, animated: true)
        getBitcoinPrice(for: currencyArray[index])
    }
    
    private func getBitcoinPrice(for currency: String) {
        
        coinService.getCoinPrice(for: currency) { [weak self] dataModel in

            if let data = dataModel {
                
                let priceString = String(data.last!)
                let currencySign = self?.getCurrencySign(for: currency)
                let finalString = "\(currencySign!) \(priceString)"
                self?.updateCoinPrice(price: finalString)
            } else {
                
                self?.updateCoinPrice(price: "Unavailable")
            }
        }
    }
    
    private func getCurrencySign(for currency: String) -> String {
        
        let index = currencyArray.firstIndex(of: currency)!
        return currencySignArray[index]
    }
    
    private func updateCoinPrice(price: String) {
        
        DispatchQueue.main.async {
            self.bitcoinPriceLabel.text = price
        }
    }
}

