//
//  ViewController.swift
//  BitcoinTicker
//

import UIKit
import  Alamofire
import SwiftyJSON


class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let symbols=["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    
    var coins=""
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    } // to determine how many columns
    let object=Data()
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let number = currencyArray.count
        return number
    }//row no.
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    } //fill data
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // let param:[String:String]=["symbol":currencyArray[3]]
        // getCoin(url: baseURL, param: param)
        print(currencyArray[row])
        // var currencyIdentifier:String=currencyArray[row]
        
        let url = baseURL+currencyArray[row]
        getCoin(url: url)
        
        
        // object.dict=[currencyArray[row]:symbols[row]]
        
        coins=symbols[row]
        
        
    } //  tell the picker what to do when the user selects a particular row.
    
    
    
    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource=self
        currencyPicker.delegate=self
        
    }
    
    
    
    
    
    func getCoin(url : String)
    {
        Alamofire.request(url, method: .get).responseJSON {response in
            if response.result.isSuccess {
                let result:JSON=JSON(response.result.value! )
                
                print(result)
                
                self.updateCoinData(json: result)
                
            }
            else if response.result.isFailure
            {
                print(response.result.error as Any)
                self.bitcoinPriceLabel.text="Connection error"
                
                
            }
        }
    }
    
    
    
    
    
    func updateCoinData(json : JSON ) {
        
        
        if let price=json["bid"].double {
            let priceInt=Int(price)
            
            
            bitcoinPriceLabel.text=(String(priceInt)+coins)
            
            
            
        }
        
        
        
        
        
        
    }
}
