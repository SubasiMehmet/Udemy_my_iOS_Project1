//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Mehmet Subaşı on 17.04.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    
    let TableView : UITableView = {
        let TableView = UITableView()
        TableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        return TableView
    }()
    
    
    
    let firestoreDatabase = Firestore.firestore()
    var snapArray = [Snap]()
    var chosenSnap : Snap?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        TableView.backgroundColor = .white
        view.addSubview(TableView)
        

        getSnapsFromFirebase()
        getUser()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        TableView.dataSource = self
        TableView.delegate = self
        TableView.frame = view.bounds
    }
    
//FIRESTORE VERİ ÇEKMEK
    
    func getSnapsFromFirebase(){
        firestoreDatabase.collection("mySnaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }else{
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        let documentID = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageURLArray = document.get("imageURLArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    //24 saate ne kadar kaldı
                                    //Kaydedilen zamandan şu anki zamana kadarki zamanı hesaplayıp saate çeviriyor.
                                    //24 saati geçen siliniyor
                                    
                                   
            
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour{
                                        //let diff_int = Int(difference)
                                        //print("diffff: \(diff_int)")
                                        
                                        if difference >= 24 {
                                            self.firestoreDatabase.collection("mySnaps").document(documentID).delete { error in
                                                if error != nil {
                                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                                }
                                            }
                                        }else{
                                                //TIMELEFT ---> snapvc
                                                
                                                let snap = Snap(username: username, imageURLArray: imageURLArray, date: date.dateValue(), timeDifference: 24-difference)
                                                self.snapArray.append(snap)
                                            
                                           
                                        }
                                        
                                      

                                    }

                                    

                                    

                                }
                            }
                        }
                        
                    }
                    self.TableView.reloadData()
                }
            }
        }
        
    }
    
    func getUser(){
        
               
        firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email as Any).getDocuments { snapshot, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }else{
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        if let userName = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.userName = userName
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
            
                        }
                    }
                }
            }
        }
        
    }
    
    
    func makeAlert (title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.FeedUserNameLabel.text = snapArray[indexPath.row].username
        cell.FeedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageURLArray.last!))
        cell.FeedImageView.frame = CGRect(x: 10,
                                          y: cell.FeedUserNameLabel.frame.maxY + 10,
                                          width: cell.contentView.frame.size.width - 20,
                                          height: cell.contentView.frame.size.width * 0.1)
        
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destinationVC = segue.destination as! SnapVC
            destinationVC.selectedSnap = chosenSnap

            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 2
    }
    
    

    
    
    

}
