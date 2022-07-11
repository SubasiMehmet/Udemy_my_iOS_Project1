//
//  ListViewController.swift
//  TravelBook
//
//  Created by MSUBASI on 13.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var TableView: UITableView!
    
    //****// DİZİYİ INITIALIZE ETMEDEN TANIMLAMAK
    var titleArray = [String]()
    var idArray = [UUID]()
    
    var chosenTitle = ""
    var chosenTitleId : UUID?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        
        TableView.delegate = self
        TableView.dataSource = self
        
        
        getData()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
    }
    
    
    @objc func addButtonClicked (){
        chosenTitle = ""
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    // CoreData'da tüm datayı tabloya çekmek ***********////*****
    @objc func getData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            if results.count > 0 {
                                    //Dublicate olmaması için tablo sıfırlanır
                self.titleArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject]{
                    if let title = result.value(forKey: "title") as? String {
                        self.titleArray.append(title)
                    }
                
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    
                    //Her yeni veride tablo kendini güncelleyecek
                    
                    TableView.reloadData()
                
                }
                
                
            }
            
            
        } catch {
            print("error...")
        }
        
        
    }
    

    
    
    
    
    //Tablo fonksiyonları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenTitle = titleArray[indexPath.row]
        chosenTitleId = idArray[indexPath.row]
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toViewController" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.selectedTitle = chosenTitle
            destinationVC.selectedId = chosenTitleId
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            
            let idstring = idArray[indexPath.row].uuidString
            fetchRequest.predicate  = NSPredicate(format: "id = %@", idstring)
            
            fetchRequest.returnsObjectsAsFaults = false
            
            
            do {
                    let results = try context.fetch(fetchRequest)
                if  results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? UUID{
                            
                            if id == idArray[indexPath.row] {
                                context.delete(result)
                                idArray.remove(at: indexPath.row)
                                titleArray.remove(at: indexPath.row)
                                self.TableView.reloadData()
                                
                                
                                do {
                                    try context.save()
                                } catch{
                                    print("error...")
                                }
                                
                                break
                                
                            }
                        }
                        
                        
                        
                    }
                    
                }
                
                
            }catch{
                print("error...")
            }
            
            
            
        
            
        }
        
        
    }
    
    
    
    
    


}
