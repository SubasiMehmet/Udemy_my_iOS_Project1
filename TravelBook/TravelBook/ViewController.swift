//
//  ViewController.swift
//  TravelBook
//
//  Created by MSUBASI on 12.02.2022.
//  Copyright © 2022 MSUBASI. All rights reserved.
//

import UIKit
import MapKit  //Haritalar
import CoreLocation // Kullanıcının konumunu almak
import CoreData // CoreData kullanımı için

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var CommentText: UITextField!
    
    
    @IBOutlet weak var MapView: MKMapView!  //Map
    
    var locationManager = CLLocationManager() // Kullanıcı konumu
    
    
    //****// VERİYİ INITIALIZE ETMEDEN TANIMALAMAK
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    var selectedTitle = ""
    var selectedId : UUID?
    
    var annotationTitle = ""
    var annotationSubtitle = ""
    var annotationLongitude = Double()
    var annotationLatitude = Double()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Best en iyidir ama fazla şarj tüketir.
        locationManager.requestWhenInUseAuthorization() // App kullanılırken konumu kullanmak
        locationManager.startUpdatingLocation() // Kullanıcı yeri alınmaya başlar
        
        
        //Uzun basarak pin ekleme
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gesture_recognizer:))) // Uzun basma gestureRecognizerı
        gestureRecognizer.minimumPressDuration = 3  //Basma Süresi
        MapView.addGestureRecognizer(gestureRecognizer) // MapView'e gestureRecognizerı ekledik
        
        //Core Data'yı çekmek ***
        if selectedTitle != "" {
          
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedId!.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        if let title = result.value(forKey: "title") as? String {
                            annotationTitle = title
                            
                            if let subtitle = result.value(forKey: "subtitle") as? String {
                                annotationSubtitle = subtitle
                                
                                if let longitude = result.value(forKey: "longitude") as? Double {
                                    annotationLongitude = longitude
                                    
                                    if let latitude = result.value(forKey: "latitude") as? Double {
                                        annotationLatitude = latitude

                                        let annotation = MKPointAnnotation()
                                        annotation.title = annotationTitle
                                        annotation.subtitle = annotationSubtitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                                        annotation.coordinate = coordinate
                                        
                                        self.MapView.addAnnotation(annotation)
                                        NameText.text = annotationTitle
                                        CommentText.text = annotationSubtitle
                                        
                                        //Annotation lokasyonunu göstermek için güncel lokasyonu almayı bırakıyoruz ve regionımızı annotation regionı olarak tanımlıyoruz.
                                        locationManager.stopUpdatingLocation()
                                        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        MapView.setRegion(region, animated: true)
                                        
                                    }
                                }
                            }
                        }
                    }
                }
                
                
                
            } catch{
                print("error...")
            }

        }
        else {
            // Add new Data
        }
        
    }


    
    
    
    //Locationı kullanmak için gerekli fonksiyon
    //Standart bir fonksiyon
    //Güncellenen lokasyonları dizi halinde verir. Son lokasyon bizim için yeterli.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (selectedTitle == "") {
            
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude) // locations[0] son koordinatı verir.
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) //span zoomlama seviyesidir
            let region = MKCoordinateRegion(center: location, span: span)
            MapView.setRegion(region, animated: true)
          
        }
        else {
            
        }
        
        
    }
    
    // Annotation'ı özelleştirme
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black
            
            let button  = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }
        
        else{
            pinView?.annotation = annotation
            
        }
        
        return pinView
    }
    
    

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if selectedTitle != "" {
            
            let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                //closure
                
                if let placemark = placemarks {
                    
                
                
                    if placemark.count  > 0 {
                    
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        item.name = self.annotationTitle

                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOptions)
                    
                    }
                    
                    
                }
                
                
            }
            
            
        }
        
    }
        
    
    
    
    // longpress_GestureRecognizer fonksiyonu
    @objc func chooseLocation(gesture_recognizer : UILongPressGestureRecognizer) {
        
        if(gesture_recognizer.state == .began) {                              // Tıklama başladıysa
            let touchedPoint = gesture_recognizer.location(in: self.MapView)  // MapView üzerindeki dokunulan noktaları alıyoruz
            let touchedCoordinates = self.MapView.convert(touchedPoint, toCoordinateFrom: self.MapView)  //Dokunulan noktayı koordinata çevirir
            
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            //Annotation ekleme // Haritaya Pin Ekleme
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = NameText.text
            annotation.subtitle = CommentText.text
            self.MapView.addAnnotation(annotation)
            
        }
    }
    
    
    
    
    //Core Data RECORD ****
    @IBAction func SaveButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        newPlace.setValue(NameText.text, forKey: "title")
        newPlace.setValue(CommentText.text, forKey: "subtitle")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
        }catch{
            print("error...")
        }
        
        //Notification Center
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
        
        
        
    }
    

    
    
    
    
    

}

