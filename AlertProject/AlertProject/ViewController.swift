//
//  ViewController.swift
//  AlertProject
//
//  Created by MSUBASI on 22.01.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordagainText: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func SignUpClicked(_ sender: Any) {
    
        /*
        let alert = UIAlertController(title: "HATA", message: "User Name Not Found", preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
        
        */
        
        
        func AlertMessage(title: String, message: String) {
            let alert  = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }

        
        if usernameText.text == "" {
            AlertMessage(title: "Error", message: "Username not found")
        }else if passwordText.text == "" {
            AlertMessage(title: "Error", message: "password not found")
        }else if passwordText.text != passwordagainText.text {
            AlertMessage(title: "Error", message: "passwords do not match")
        }else {
            AlertMessage(title: "Success", message: "User OK")
        }
            
    }
    
}

