//
//  ViewController.swift
//  LandmarkBook
//
//  Created by MSUBASI on 31.01.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var TableView: UITableView!
    
    
    var landmarkNames = [String]()
    var landmarkImages = [UIImage]()
    
    var chosenLandmarkNames = ""
    var chosenLandmarkImages = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableView.delegate = self
        TableView.dataSource = self
        
        //Landmark Book DATA
        
        landmarkNames.append("Colosseum")
        landmarkNames.append("GreatWall")
        landmarkNames.append("Kremlin")
        landmarkNames.append("StoneHenge")
        landmarkNames.append("TajMahal")
        landmarkNames.append("Eiffel")
        
        
        landmarkImages.append(UIImage(named: "Colosseum")!)
        landmarkImages.append(UIImage(named: "GreatWall")!)
        landmarkImages.append(UIImage(named: "Kremlin")!)
        landmarkImages.append(UIImage(named: "StoneHenge")!)
        landmarkImages.append(UIImage(named: "TajMahal")!)
        landmarkImages.append(UIImage(named: "Eiffel")!)
        
        navigationItem.title = "Landmark Book"
                
        
    }
    
    //For editing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            landmarkNames.remove(at: indexPath.row)
            landmarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
    
    //Hücrelerde ne yazacağı - Zorunlu
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = landmarkNames[indexPath.row]
        return cell
    
    }
    
    // Satır Sayısı - Zorunlu
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkImages.count
    }
    
    //Seçildiğinde ne olacağı
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLandmarkNames = landmarkNames[indexPath.row]
        chosenLandmarkImages = landmarkImages[indexPath.row]
        
        performSegue(withIdentifier: "toImageViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImageViewController" {
            let destinationVC = segue.destination as! ImageViewContoller
            destinationVC.selectedLandmarkName = chosenLandmarkNames
            destinationVC.selectedLandmarkImage = chosenLandmarkImages
        }
    }
    


}

