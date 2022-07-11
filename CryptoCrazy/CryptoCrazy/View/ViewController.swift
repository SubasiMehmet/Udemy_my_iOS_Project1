//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by Mehmet Subaşı on 27.04.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
 
    
    @IBOutlet weak var TableView: UITableView!
    private var cryptoListViewModel : CryptoListViewModel!
    
    
    var colorArray = [UIColor]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableView.delegate = self
        TableView.dataSource = self
        
        self.colorArray = [
            UIColor(red: 75/255, green: 55/255, blue: 135/255, alpha: 1.0),
            UIColor(red: 15/255, green: 40/255, blue: 105/255, alpha: 1.0),
            UIColor(red: 57/255, green: 150/255, blue: 15/255, alpha: 1.0),
            UIColor(red: 90/255, green: 146/255, blue: 184/255, alpha: 1.0),
            UIColor(red: 200/255, green: 156/255, blue: 224/255, alpha: 1.0),
            UIColor(red: 130/255, green: 4/255, blue: 40/255, alpha: 1.0)
        ]
        
        getData()
        
     
        
    }

    
    
    func getData(){
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
       
        
        WebService().downloadCurrencies(url: url) { cryptos in
            if let cryptos = cryptos {
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
                
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell

        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        
        cell.PriceText.text = cryptoViewModel.price
        cell.CurrencyText.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 6 ]
        
        return cell
    }


}
