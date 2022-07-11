//
//  ViewController.swift
//  CatchTheFlintstone
//
//  Created by MSUBASI on 25.01.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var HighscoreLabel: UILabel!
    
    @IBOutlet weak var Fred1: UIImageView!
    @IBOutlet weak var Fred2: UIImageView!
    @IBOutlet weak var Fred3: UIImageView!
    @IBOutlet weak var Fred4: UIImageView!
    @IBOutlet weak var Fred5: UIImageView!
    @IBOutlet weak var Fred6: UIImageView!
    @IBOutlet weak var Fred7: UIImageView!
    @IBOutlet weak var Fred8: UIImageView!
    @IBOutlet weak var Fred9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var timeCounter = 10
    var fredArray = [UIImageView]()   //Decleration -- UIImageView tipinde boş tek boyutlu bir dizi
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Highscore Check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            HighscoreLabel.text = "Highscore: \(highScore)"
        }
        
        
        
        
        if let newScore = storedHighScore as? Int{
                
            
            highScore = newScore
            HighscoreLabel.text = "Highscore: \(highScore)"
            print("hello \(highScore)")
        }
            
        
                
        
        //GestureRecognizer
        Fred1.isUserInteractionEnabled = true
        Fred2.isUserInteractionEnabled = true
        Fred3.isUserInteractionEnabled = true
        Fred4.isUserInteractionEnabled = true
        Fred5.isUserInteractionEnabled = true
        Fred6.isUserInteractionEnabled = true
        Fred7.isUserInteractionEnabled = true
        Fred8.isUserInteractionEnabled = true
        Fred9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        Fred1.addGestureRecognizer(gestureRecognizer1)
        Fred2.addGestureRecognizer(gestureRecognizer2)
        Fred3.addGestureRecognizer(gestureRecognizer3)
        Fred4.addGestureRecognizer(gestureRecognizer4)
        Fred5.addGestureRecognizer(gestureRecognizer5)
        Fred6.addGestureRecognizer(gestureRecognizer6)
        Fred7.addGestureRecognizer(gestureRecognizer7)
        Fred8.addGestureRecognizer(gestureRecognizer8)
        Fred9.addGestureRecognizer(gestureRecognizer9)
        
        
        //Timers
        ScoreLabel.text = "Score: \(score)"
        TimeLabel.text = String(timeCounter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFred), userInfo: nil, repeats: true)
        
        
        //Fred Array
        fredArray = [Fred1, Fred2, Fred3, Fred4, Fred5, Fred6, Fred7, Fred8, Fred9]
        
        
        
        
        hideFred()
        
    }
    
    @objc func hideFred (){
        for fred in fredArray{
            fred.isHidden = true
        }
        
        //Random
        
        let random = Int(arc4random_uniform(UInt32(fredArray.count - 1)))  //Uniform random
        fredArray[random].isHidden = false
    }
    
    //Increase Score
    @objc func increaseScore(){
        
        score += 1
        ScoreLabel.text = "Score: \(score)"
    }
    
    //Count Down & Finish Alert
    @objc func countDown(){
        
        TimeLabel.text = String(timeCounter)
        timeCounter -= 1
        
        if(timeCounter == -2) {
            timer.invalidate()
            hideTimer.invalidate()
            TimeLabel.text = "Time's Over"
            TimeLabel.font = UIFont(name: "System", size: 20)
            
            
        for fred in fredArray{
            fred.isHidden = true
        }
            
            //Highscore
            
            if self.score > self.highScore{
                self.highScore = self.score
                HighscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            //Alert
            let alert = UIAlertController(title: "Time's Over!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                self.score = 0
                self.ScoreLabel.text = "Score: \(self.score)"
                self.timeCounter = 10
                self.TimeLabel.text = String(self.timeCounter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFred), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    


}

