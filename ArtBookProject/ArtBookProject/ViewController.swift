//
//  ViewController.swift
//  ArtBookProject
//
//  Created by MSUBASI on 3.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var TableView: UITableView!
    
    
    var nameArray = [String]()
    var idArray = [UUID]()
    
    var selectedPainting = ""
    var selectedPaintingID : UUID?
    
    
    
     
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
       
        TableView.delegate = self
        TableView.dataSource = self
        
        getData()
      
    }
    
    //Receive Notification
    override func viewWillAppear(_ animated: Bool) {
        //NotificationCenter.default.addObserver(self, selector: #selector(getData), name: <#T##NSNotification.Name?#>("newData"), object: nil) //Daha ileri sürümler için
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: Notification.Name("newData"), object: nil)
    
    }
    
                    //Kaydedilen CoreData'ya ulaşmak ve çekmek. Fetch işlemi
    @objc func getData() {
        
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                
                if let name = result.value(forKey: "name") as? String {
                    self.nameArray.append(name)
                }
            
                if let id = result.value(forKey: "id") as? UUID{
                    self.idArray.append(id)
                }
                
                self.TableView.reloadData()    //TableView'i güncellemek
              
            }
            
        } catch{
            print("error...")
        }
        
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    
    @objc func addButtonClicked() {
        selectedPainting = ""
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsVC
        destinationVC.chosenPainting = selectedPainting
        destinationVC.chosenPaintingID = selectedPaintingID
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingID = idArray[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = idArray[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            if id == idArray[indexPath.row] {       //tekrar kontrol ediyoruz
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.TableView.reloadData()
                                do {
                                    try context.save()
                                }catch {
                                    print("error")
                                }
                                
                                break
                                
                                
                                
                                
                            }
                        }
                        
                            
                    }
                }
                
            }catch {
                print("error...")
            }
            
            
            
            
        }
            
    }
    
    
}

