//
//  ViewController.swift
//  TimerProject
//
//  Created by MSUBASI on 23.01.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimeLabel: UILabel!
    
    
    var timer = Timer()
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        TimeLabel.text = "Time:  \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
                    //timer 1 saniyede bir kendi viewcontrollerinde timerFunction'u çalıştıracak ve tekrarlayacak (true)
        
    }

    
    @objc func timerFunction(){
        
        TimeLabel.text = "Time:  \(counter)"
        counter -= 1
        
        if counter == 0 {
            timer.invalidate() //Timer'ı bitirir.
            TimeLabel.text = "Time is over"
        }
        
    }
    
    @IBAction func ButtonClicked(_ sender: Any) {
        
        print("button clicked")
    }
    
}

