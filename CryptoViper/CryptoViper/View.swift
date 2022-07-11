//
//  View.swift
//  CryptoViper
//
//  Created by Mehmet Subaşı on 30.04.2022.
//

import Foundation
import UIKit

//Talks to -> Presenter
// Class, protocol
//View Controller 


protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    
    
    
    func update(with cryptos: [Crypto])     //crypto ile update et
    func update(with error: String)         //error ile update et
}



// EK BİR VIEWCONTROLLER EKLEME... FAKAT VIOER YAPISINA UYGUN DEĞİL. SADECE ÖRNEK ALT

class DetailViewController : UIViewController {
    
    var currency : String = ""
    var price : String = ""
    
    private let currencyLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Currency Label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Price Label"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.addSubview(priceLabel)
        view.addSubview(currencyLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currencyLabel.frame = CGRect(x: view.frame.width / 2 - 100,
                                     y: view.frame.height / 2 - 25,
                                     width: 200,
                                     height: 50)
        priceLabel.frame = CGRect(x: view.frame.width / 2 - 100,
                                     y: view.frame.height / 2 + 50,
                                     width: 200,
                                     height: 50)
        
        currencyLabel.text = currency
        priceLabel.text = price
        
        priceLabel.isHidden = false
        currencyLabel.isHidden = false
        
    }
    
}

// EK BİR VIEWCONTROLLER EKLEME... FAKAT VIOER YAPISINA UYGUN DEĞİL. SADECE ÖRNEK ÜST

class CryptoViewController : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource{

    //UIViewController önce yazılmalı
    var presenter: AnyPresenter?
    
    var cryptos : [Crypto] = []
    
    private let tableView : UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewDidLayoutSubviews() {     //Subview eklerken çağırılan fonksiyon
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100,
                                    y: view.frame.height / 2 - 25,
                                    width: 200,
                                    height: 50)
    }
    
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
     
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .yellow
        
        return cell
    }
    
    
// EK BİR VIEWCONTROLLER EKLEME... FAKAT VIOER YAPISINA UYGUN DEĞİL. SADECE ÖRNEK ALT
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextViewController = DetailViewController()
        nextViewController.currency = cryptos[indexPath.row].currency
        nextViewController.price = cryptos[indexPath.row].price
        self.present(nextViewController, animated: true, completion: nil)
    }
    
// EK BİR VIEWCONTROLLER EKLEME... FAKAT VIOER YAPISINA UYGUN DEĞİL. SADECE ÖRNEK ÜST
    
}
