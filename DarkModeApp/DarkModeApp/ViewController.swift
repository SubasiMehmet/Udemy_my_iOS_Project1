//
//  ViewController.swift
//  DarkModeApp
//
//  Created by MSUBASI on 19.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var ChangeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        //Aşağıdaki satır ile bu view controller'i kullanıcı seçiminden bağımsız olarak dark moda (veya light mode) alırız.
        // Bunu kodda yaparsak tüm view controller için yazmak gerekecektir.
        // YA DA "info.plist" üzerinden "Userinterface"e dark ya da light yazarak tüm uygulamayı kullanıcının telefon ayarlarındaki seçiminden bağımsız olarak o moda geçirebiliriz.
        
        overrideUserInterfaceStyle = .dark
        
    }
    
    //Dark mode'a geçilirse uygulama geçildiği an anlar ve tepki verir

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if userInterfaceStyle == .dark {
            
            ChangeButton.tintColor = UIColor.white
        } else {
            ChangeButton.tintColor = UIColor.blue
        }
                
    }


}

