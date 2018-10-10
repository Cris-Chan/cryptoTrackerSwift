//
//  ViewController.swift
//  BitcoinCounter2.0
//
//  Created by Cristian villanueva on 6/9/18.
//  Copyright © 2018 Cristian villanueva. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    //----------------------------------------------------<
    
    let coinUrl = "https://api.coindesk.com/v1/bpi/currentprice.json"
    let altURL = "https://min-api.cryptocompare.com/data/pricemulti"
    var data = coinDataModel(price: "0.0000")
    let btcParams: [String : String] = ["fsyms" : "ETH,BTC,LTC", "tsyms" : "USD"]
    
    
    @IBOutlet weak var ltcCoinImage: UIImageView!
    @IBOutlet weak var ethCoinImage: UIImageView!
    @IBOutlet weak var coinimage: UIImageView!
    @IBOutlet weak var coinText: UILabel!
    @IBOutlet weak var liteCoinText: UILabel!
    @IBOutlet weak var ethCoinText: UILabel!
    @IBOutlet weak var ethCoinValue: UILabel!
    @IBOutlet weak var ltcCoinValue: UILabel!
    @IBOutlet weak var coinValue: UILabel!
    var idealCenter = CGFloat(0)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idealCenter = coinimage.center.x
        updateJsonData(url: altURL, parameters: btcParams)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

    //------------------------------------------------------>
    
    
    
    //NETWORK REQUEST and parseing --------------------------------<
    
    func updateJsonData(url : String, parameters : [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            if response.result.isSuccess{
                print("Success in communicating with server")
                
                let coinJson : JSON = JSON(response.result.value!)
                self.coinJsonParse(json: coinJson)
                
            }
            else{
                print ("**<error making request>**")
            }
            
        }
    }
    
    
    
    
    
    func coinJsonParse(json : JSON){
        
        if let price = json["BTC"]["USD"].float{
            print("JSON Request returned valid data")
            
            //now we update the data model with bitcoin price only since other deafult settings are already on Bitcoin
            data.coinPrice = String(price)
            updateUiWithDataModel()
            print(data.coinPrice)
            
        }else{
            print("<**JSON request return data INVALID BTC**>")
        }
        
        if let price = json["ETH"]["USD"].float{
            data.ethCoinPrice = String(price)
            updateUiWithDataModel()
            print(data.ethCoinPrice)
        }else{
            print("<**JSON request return data INVALID ETH**>")
        }
        
        if let price = json["LTC"]["USD"].float{
            data.ltcCoinPrice = String(price)
            updateUiWithDataModel()
            print(data.ltcCoinPrice)
            
        }else{
            print("<**JSON request return data INVALID LTC**>")
        }
        
        
    }
    
    //------------------------------------------------->
    
    
    
    
    
    
    //UpdateUI------------------------<
    
    func updateUiWithDataModel(){
        coinimage.image = data.coinImage
        coinText.text = data.coinName
        coinValue.text = String(data.coinPrice)
        
        ethCoinValue.text = data.ethCoinPrice
        
        ltcCoinValue.text = data.ltcCoinPrice
        
        
    }
    
    
    //------------------------>
    
    
    
    //REFRESH
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refresh(_ sender: UIButton) {
        
        updateJsonData(url: altURL, parameters: btcParams)
        
    }
    
    
    
    
    //--------------------------
    // COIN TRANSITIONS
    
    
    @IBOutlet weak var selectionBar: UIView! // this shows what coin is currently displaying on the screeen
    var animationOffset = 44
    var currentCoin = "BTC"
    
    
    
    @IBAction func transitionToETH(_ sender: UIButton) {
        let idealRight = self.idealCenter + 1000
        let idealLeft = self.idealCenter - 1000
        UIView.animate(withDuration: 0.4, delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        self.selectionBar.center.x = CGFloat((144 + self.animationOffset))
                        if(self.currentCoin == "BTC"){
                            self.ethCoinImage.center.x = self.idealCenter
                            self.ethCoinText.center.x = self.idealCenter
                            self.ethCoinValue.center.x = self.idealCenter
                            
                            self.coinimage.center.x = idealLeft
                            self.coinValue.center.x = idealLeft
                            self.coinText.center.x = idealLeft
                        }
                        else if(self.currentCoin == "LTC"){
                            self.ethCoinImage.center.x = self.idealCenter
                            self.ethCoinText.center.x = self.idealCenter
                            self.ethCoinValue.center.x = self.idealCenter
                            
                            self.ltcCoinValue.center.x = idealRight
                            self.ltcCoinImage.center.x = idealRight
                            self.liteCoinText.center.x = idealRight
                        }
                        self.currentCoin = "ETH"
        },
                       completion: nil
        )
        
        
        
    }
    
    @IBAction func transitionToLTC(_ sender: UIButton) {
        
        let idealLeft = self.idealCenter - 1000
        UIView.animate(withDuration: 0.4, delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        self.selectionBar.center.x = CGFloat((231 + self.animationOffset))
                        if(self.currentCoin == "BTC"){
                            self.ltcCoinImage.center.x = self.idealCenter
                            self.liteCoinText.center.x = self.idealCenter
                            self.ltcCoinValue.center.x = self.idealCenter
                            
                            self.coinimage.center.x = idealLeft
                            self.coinValue.center.x = idealLeft
                            self.coinText.center.x = idealLeft
                            self.ethCoinImage.center.x = idealLeft
                            self.ethCoinValue.center.x = idealLeft
                            self.ethCoinText.center.x = idealLeft
                        }
                        else if(self.currentCoin == "ETH"){
                            self.ltcCoinImage.center.x = self.idealCenter
                            self.liteCoinText.center.x = self.idealCenter
                            self.ltcCoinValue.center.x = self.idealCenter
                            
                            self.ethCoinValue.center.x = idealLeft
                            self.ethCoinText.center.x = idealLeft
                            self.ethCoinImage.center.x = idealLeft
                        }
                        self.currentCoin = "LTC"
        },
                       completion: nil
        )
        
    }
    
    @IBAction func transitionToBTC(_ sender: UIButton) {
        
        let idealRight = self.idealCenter + 1000
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseInOut], animations: {
            self.selectionBar.center.x = CGFloat((57 + self.animationOffset))
            if(self.currentCoin == "ETH"){
                self.coinimage.center.x = self.idealCenter
                self.coinText.center.x = self.idealCenter
                self.coinValue.center.x = self.idealCenter
                
                self.ethCoinValue.center.x = idealRight
                self.ethCoinText.center.x = idealRight
                self.ethCoinImage.center.x = idealRight
            }
            else if(self.currentCoin == "LTC"){
                self.coinimage.center.x = self.idealCenter
                self.coinText.center.x = self.idealCenter
                self.coinValue.center.x = self.idealCenter
                
                self.ltcCoinValue.center.x = idealRight
                self.ltcCoinImage.center.x = idealRight
                self.liteCoinText.center.x = idealRight
                self.ethCoinValue.center.x = idealRight
                self.ethCoinText.center.x = idealRight
                self.ethCoinImage.center.x = idealRight
            }
            self.currentCoin = "BTC"
        }, completion: nil)
    }
    
    
    
    
    //-------------------------
}

