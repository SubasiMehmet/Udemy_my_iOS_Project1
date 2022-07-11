//
//  UploadVC.swift
//  SnapchatClone
//
//  Created by Mehmet Subaşı on 17.04.2022.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var UploadImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        UploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        UploadImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    //PICKER
    @objc func choosePicture(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        UploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func UploadClicked(_ sender: Any) {
        
        
        //STORAGE
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        
        if let data = UploadImageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpeg")
            
            
            imageReferance.putData(data, metadata: nil) { metadata, error in    //Bu işlem datayı kaydeder.
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }else{
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            
                            
                            
                            //FIRESTORE DATABASE //Collections
                            
                            let fireStore = Firestore.firestore()
                            
                            //Database içinde kullanıcıya ait snap var mı diye bakar
                            fireStore.collection("mySnaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.userName).getDocuments { snapshot, error in
                                if error != nil {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                }else{
                                 
                                    if snapshot?.isEmpty == false && snapshot != nil {  //daha önceden yayımlı snap varsa
                                        for document in snapshot!.documents {       //varsa documentID'yi alır
                                            let documentID = document.documentID
                                                                                    //içerisindeki imageURLArray'i alır
                                            if var imageURLArray = document.get("imageURLArray") as? [String] {
                                                imageURLArray.append(imageURL!)
                                                
                                                let additionalDictionary = ["imageURLArray" : imageURLArray] as? [String: Any]
                                                                                    //imageURLArray'e merge ile diğerlerini silmeden ekleme yapar
                                                fireStore.collection("mySnaps").document(documentID).setData(additionalDictionary!, merge: true) { error in
                                                    if error == nil {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.UploadImageView.image = UIImage(named: "select")
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }else { //eski snap yoksa
                                                
                                        let snapDictionary = ["imageURLArray" : [imageURL!], "snapOwner" : UserSingleton.sharedUserInfo.userName, "date" : FieldValue.serverTimestamp()] as [String : Any]
                                        
                                                                //Snaps isimli bir collection oluşturur ve imageURL'yi array'de tutar
                                    
                                        fireStore.collection("mySnaps").addDocument(data: snapDictionary) { error in
                                            if error != nil {
                                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                            }else{
                                                self.tabBarController?.selectedIndex = 0
                                                self.UploadImageView.image = UIImage(named: "select")
                                                
                                            }
                                        }
                                    }
                                }
                            }
                           
                            

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
    
    
  

}
