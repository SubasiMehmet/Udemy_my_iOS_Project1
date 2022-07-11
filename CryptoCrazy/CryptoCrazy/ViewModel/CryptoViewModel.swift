//
//  CryptoViewModel.swift
//  CryptoCrazy
//
//  Created by Mehmet Subaşı on 29.04.2022.
//

import Foundation

struct CryptoListViewModel {
    let cryptoCurrencyList : [CryptoCurrency]
    

}

extension CryptoListViewModel {
    func numberOfRowsInSection() -> Int {
        
        return self.cryptoCurrencyList.count
    }
    
    func cryptoAtIndex(_ index: Int) -> CryptoViewModel {           //Alttaki ve bu structı birbirine bağladık
        
        let crypto = self.cryptoCurrencyList[index]
        return CryptoViewModel(cryptoCurrency: crypto)
    }
    
}





struct CryptoViewModel {
    let cryptoCurrency : CryptoCurrency
}

extension CryptoViewModel {
    var name : String {
        return self.cryptoCurrency.currency
    }
    
    var price : String {
        return self.cryptoCurrency.price
    }
}





extension Int{
    func square(){
        print(self*self)
        
    }
    
}
