//
//  SettingsVC.swift
//  SnapchatClone
//
//  Created by Mehmet Subaşı on 17.04.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LogOutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSignInVC", sender: nil)
        }catch{
            
        }
        
    }
    

}
