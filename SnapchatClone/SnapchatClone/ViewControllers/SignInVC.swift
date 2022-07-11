//
//  ViewController.swift
//  SnapchatClone
//
//  Created by Mehmet Subaşı on 12.04.2022.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

 
    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var UsernameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func SignInClicked(_ sender: Any) {
        
        if PasswordText.text != "" && EmailText.text != "" {
            Auth.auth().signIn(withEmail: EmailText.text!, password: PasswordText.text!) { result, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else {
            self.makeAlert(title: "Error", message: "Username/Email/Password?")
        }
            
        
    }
    

    @IBAction func SignUpClicked(_ sender: Any) {
                
        if UsernameText.text  != "" && PasswordText.text != "" && EmailText.text != "" {
            
            Auth.auth().createUser(withEmail: EmailText.text!, password: PasswordText.text!) { auth, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }else{
                    
                    let fireStore = Firestore.firestore()
                    let userDictionary = ["email" : self.EmailText.text!, "username" : self.UsernameText.text!] as  [String : Any]
                    
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { error in
                        if error != nil {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                        }
                        
                    }
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                    
                }
            }
            
            
        }else{
            self.makeAlert(title: "Error", message: "Username/Email/Password?")
        }
        
    }
    
    
 
        
        
        
    
    
    func makeAlert (title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    


}

