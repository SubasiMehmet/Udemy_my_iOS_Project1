//
//  DetailsVC.swift
//  ArtBookProject
//
//  Created by MSUBASI on 3.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var ArtistText: UITextField!
    @IBOutlet weak var YearText: UITextField!
        
    @IBOutlet weak var SaveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingID : UUID?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //CORE DATA
        //ID'ye göre CoreData çekmek
        if chosenPainting != "" {
            
            SaveButton.isHidden = true
            
            
            // Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings") //DİKKAT
            
            fetchRequest.returnsObjectsAsFaults = false
            
            //Filtreleme
            
            let idString = chosenPaintingID?.uuidString
        
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0  {
                    
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            NameText.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            ArtistText.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            YearText.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            ImageView.image = UIImage(data: imageData)
                        }
                        
                        
                    
                    }
                
                
                }
                
                
            }catch{
                print("error...")
            }
            
            
            
            
            
        } else{
            SaveButton.isHidden = false
            SaveButton.isEnabled = false
        }
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))  //Burada gestureRecognizer "View"in kendisi için yapılıyor
        view.addGestureRecognizer(gestureRecognizer)                                                   //View'e ekleniyor. Amaç klavyeyi saklamak.
        
        
        ImageView.isUserInteractionEnabled = true //Kullanıcı resme tıklayabiliyor mu?
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        ImageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    
    //Entity'i Core Data olarak kaydetmek. import CoreData demeyi unutmayalım!
    //context değişkeni içerisine kaydediyoruz.
    //Tüm bunlar save tuşuna basıldığında olacağı için buttonClicked içersinde yazıyoruz
    
    @IBAction func SaveButtonClicled(_ sender: Any) {
        
       //Datayı kaydetmek
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       let context = appDelegate.persistentContainer.viewContext
       
       let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
       
        
        //Attributes
        
        newPainting.setValue(NameText.text, forKey: "name")
        newPainting.setValue(ArtistText.text, forKey: "artist")
        
        if let year = Int(YearText.text!){
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = ImageView.image?.jpegData(compressionQuality: 0.5)       //resim kalitesini düşürmek
        
        newPainting.setValue(data, forKey: "image")
                                                        //Context içerisine kaydetme
                                                        // DoCatch yapısı kullanımı
        do{
            try context.save()
                print("success")
        }  catch{
                print("error")
            }
        
       
      
        
        NotificationCenter.default.post(name: Notification.Name("newData"), object: nil)
        
        self.navigationController?.popViewController(animated: true)  // İlk Ekrana geri dön
        
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //PICKER
    //Picker with gestureRecognizer
    
    @objc func selectImage() {                  //Görsel seçim
        let picker = UIImagePickerController()  //Picker ile KAMERAYA veya GALERİ'ye gilidip geri gelinecek. Kütüphaneler de yukarıda eklendi
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true             //Kullanıcı seçtiği resmi editleyebilir.
        present(picker, animated: true, completion: nil)
        
    }
        //seçilen görselin ne yapılacağı
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ImageView.image = info[.editedImage] as? UIImage
        SaveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)  //picker'ı kapatmak için
    }
    
    

    

}
