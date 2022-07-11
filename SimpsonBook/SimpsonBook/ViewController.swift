//
//  ViewController.swift
//  SimpsonBook
//
//  Created by MSUBASI on 2.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {


    
    
    @IBOutlet weak var TableView: UITableView!
    
    
    var SimpsonArray = [Simpsons]()
    var chosenSimpson : Simpsons?

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        
        
        //Simpson Objects
        
        let homer = Simpsons(name: "Homer Simpson", job: "Nuclear Safety", image: UIImage(named: "Homer")!)
        let marge = Simpsons(name: "Marge Simpson", job: "Housewife",  image: UIImage(named: "Marge")!)
        let bart = Simpsons(name: "Bart Simpson", job: "Student", image: UIImage(named: "Bart")!)
        let lisa = Simpsons(name: "Lisa Simpson", job: "Student", image: UIImage(named: "Lisa")!)
        let maggie = Simpsons(name: "Maggie Simpson", job: "Baby", image: UIImage(named: "Maggie")!)
        

        SimpsonArray.append(homer)
        SimpsonArray.append(marge)
        SimpsonArray.append(bart)
        SimpsonArray.append(lisa)
        SimpsonArray.append(maggie)
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SimpsonArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = SimpsonArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSimpson = SimpsonArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {  //ÖNEMLİ
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! detailsVC
            destinationVC.selectedSimpson = chosenSimpson
        }
    }
    
        
    





}

