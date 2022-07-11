//
//  Interactor.swift
//  CryptoViper
//
//  Created by Mehmet Subaşı on 30.04.2022.
//

import Foundation

//Class, Protocol
//Talks to -> Presenter


protocol AnyInteractor{
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        else {
            print("URL Error...")
            return
        }
        let task  = URLSession.shared.dataTask(with: url) { [weak self] data, response , error in
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            }catch{
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
                
            }
            
            
        }.resume()
        
        //veya task.resume()
    }
    
    
    
}
