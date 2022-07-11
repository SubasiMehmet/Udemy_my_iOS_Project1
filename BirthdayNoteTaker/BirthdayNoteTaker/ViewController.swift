//
//  ViewController.swift
//  BirthdayNoteTaker
//
//  Created by MSUBASI on 18.01.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let storedName = UserDefaults.standard.object(forKey: "Name")
        let storedBirthday = UserDefaults.standard.object(forKey: "Birthday")
    
        // Casting as? vs. as!
        
        //nameLabel.text = storedName as? String
        
        if let newName = storedName as? String{
            nameLabel.text = "Name: " + newName
        }
        
        if let newBirthday = storedBirthday as? String {
            birthdayLabel.text = "Birthday: " + newBirthday
        }
    
    
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
      
        UserDefaults.standard.set(nameTextFiled.text, forKey: "Name")
        UserDefaults.standard.set(birthdayTextField.text, forKey: "Birthday")
        //UserDefaults.standard.synchronize() //Artık kullanılmıyor
        
        nameLabel.text = "Name: " + nameTextFiled.text!
        birthdayLabel.text = "Birthday: \(birthdayTextField.text!)"
        
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        
        let storedName = UserDefaults.standard.object(forKey: "Name")
        let storedBirthday = UserDefaults.standard.object(forKey: "Birthday")
        
        if (storedName as? String) != nil { //null
            UserDefaults.standard.removeObject(forKey: "Name")
        }
        
        if (storedBirthday as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "Birthay")
        }
    }
    
}

