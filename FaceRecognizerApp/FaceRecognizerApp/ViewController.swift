//
//  ViewController.swift
//  FaceRecognizerApp
//
//  Created by MSUBASI on 19.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit
import LocalAuthentication // FaceRecognition için ekledik

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func SignInClicked(_ sender: Any) {
        
        //print("success")
        
        //FaceID kullanımı
        
        let authContext = LAContext()
        
        var error: NSError?
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it really you?") { (success, error) in
                if success == true {
                    //successful auth
                    DispatchQueue.main.async {      // Aşağıdaki fonksiyonu main thread'de yapman gerekli. Bu sebeple hatayı önlemek için DispatchQueue içinde yapıyoruz.
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        self.myLabel.text = "error!"
                    }
                    
                    
                    
                    
                }
                
            }
            
        }
        
    }
    
}

