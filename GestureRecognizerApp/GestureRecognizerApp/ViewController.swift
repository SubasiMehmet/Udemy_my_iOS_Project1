//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by MSUBASI on 22.01.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var myLabel: UILabel!
    
     var isCat = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePicture))
    
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }

    
    @objc func changePicture(){
        
       
        
        if isCat == true {
            imageView.image = UIImage(named: "dog")
            myLabel.text = "dog"
            isCat = false
        }else {
            imageView.image = UIImage(named: "cat")
            myLabel.text = "cat"
            isCat = true
        }
        
       
    }
    
    
}

