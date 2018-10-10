//
//  coinDataModel.swift
//  BitcoinCounter2.0
//
//  Created by Cristian villanueva on 6/9/18.
//  Copyright © 2018 Cristian villanueva. All rights reserved.
//

import Foundation
import UIKit

class coinDataModel{
    
    var currentCoin = "bitcoin"
    
    var coinPrice : String = "0.0000"
    var ethCoinPrice : String = "0.0000"
    var ltcCoinPrice : String = "0.0000"
    
    var coinName : String = "Bitcoin"
    var coinImage : UIImage = #imageLiteral(resourceName: "bitPNG")
    
    
    
    
    init(price : String, name : String, image : UIImage) {
        coinName = name
        coinPrice = price
        coinImage = image
    }
    init(price : String) {
        coinPrice = price
    }
}
