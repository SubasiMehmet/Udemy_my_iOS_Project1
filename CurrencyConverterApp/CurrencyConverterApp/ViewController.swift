//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by MSUBASI on 20.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var CADLabel: UILabel!
    
    @IBOutlet weak var CHFLabel: UILabel!
    
    @IBOutlet weak var GBPLabel: UILabel!
    
    @IBOutlet weak var JPYLabel: UILabel!
    
    @IBOutlet weak var USDLabel: UILabel!
    
    @IBOutlet weak var TRYLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    @IBAction func GetRatesClicked(_ sender: Any) {
        
        // Request & Session
        // Response & Data
        // Parsing & JSON Serialization
        
        
        //1.
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=557cb129f1d94a831bdd7dfaee7d62ea")
        
        let session = URLSession.shared
        
        
        //Closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            
            else{
                
                //2.
                if data != nil {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary <String, Any>
                        
                        //ASYNC
                        // Burada asenkron işlem yapılmasının sebebi bu işlemlerin arka planda dönmesinin istenmesidir. Yoksa uygulamayı kitleyebilir.
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? Dictionary <String, Double> { // as? [String, Double]
                                //print(rates)
                                if let cad = rates["CAD"] {
                                    self.CADLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] {
                                    self.CHFLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] {
                                    self.GBPLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] {
                                    self.JPYLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] {
                                    self.USDLabel.text = "USD: \(usd)"
                                }
                                if let try_lira = rates["TRY"] {
                                    self.TRYLabel.text = "TRY: \(try_lira)"
                                }
                                
                                
                            }
                        }
                        
                        
                    }catch{
                        print("Error")
                    }
                }
                
            }
        }
        
        task.resume()
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}

