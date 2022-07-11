//
//  CryptoCurrency.swift
//  CryptoCrazy
//
//  Created by Mehmet Subaşı on 27.04.2022.
//

import Foundation

struct CryptoCurrency : Decodable { //Burada isimlerin decodable olması için JSON dosyası içindekiyle aynı olması kritik
    let currency : String
    let price : String
    
    
}
