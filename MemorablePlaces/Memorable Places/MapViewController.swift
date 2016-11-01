//
//  MapViewController.swift
//  Memorable Places
//
//  Created by Hatice Gursoy on 8/1/16.
//  Copyright © 2016 Hatice Gursoy. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager: CLLocationManager!
    
    @IBOutlet var map: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        if activePlace == -1 {
            
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            
        } else {
            
             let latitude = MemorablePlaceManager.sharedInstance.getMemorablePlaceAtIndex(activePlace).latitude
            
    
            
            let longitude = MemorablePlaceManager.sharedInstance.getMemorablePlaceAtIndex(activePlace).longitude
            
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            let latDelta:CLLocationDegrees = 0.01
            
            let lonDelta:CLLocationDegrees = 0.01
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
            
            self.map.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            
            annotation.title = MemorablePlaceManager.sharedInstance.getMemorablePlaceAtIndex(activePlace).locationName
            
            self.map.addAnnotation(annotation)
            
        }
        
        
        
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action:#selector(ViewController.action(_:)))
        
        uilpgr.minimumPressDuration = 1.0
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func action(_ gestureRecognizer:UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = gestureRecognizer.location(in: self.map)
            
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                
                
                var title:String = ""
                var locality:String = ""
                var name:String = ""
                
                if (error == nil) {
                    
                    if let p = placemarks?[0] {

    
                        if p.name != nil {
                            name = (p.name)!
                           }
                        
                        if p.locality != nil {
                            locality =  p.locality!
                           
                        }
                        
                     
                        title = "\(name) \(locality)"
                        
                     
                        
                    }
                }
                
                if title.trimmingCharacters(in: CharacterSet.whitespaces) == "" {
                    
                    title = "Added \(DateFormatter.Style.short)"
                   
                }
                
                
             
              
                MemorablePlaceManager.sharedInstance.addMemorablePlace(title, lat: newCoordinate.latitude, long: newCoordinate.longitude)
    
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                
                annotation.title = title
                
                self.map.addAnnotation(annotation)
                
                
            })
            
            
            
        }
        
        
    }
    
    func formatAddressFromPlacemark(_ placemark: CLPlacemark) -> String {
        return (placemark.addressDictionary!["FormattedAddressLines"] as!
            [String]).joined(separator: ", ")
    }
    
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
      
        let userLocation:CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        
        let longitude = userLocation.coordinate.longitude
        
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latDelta:CLLocationDegrees = 0.01
        
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        self.map.setRegion(region, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    
}

