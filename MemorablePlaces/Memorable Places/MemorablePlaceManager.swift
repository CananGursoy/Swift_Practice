//
//  MemorablePlaceManager.swift
//  Memorable Places
//
//  Created by Hatice Gursoy on 8/14/16.
//  Copyright © 2016 Hatice Gursoy. All rights reserved.
//

import UIKit
import CoreData

class MemorablePlaceManager{
    //Singleton
    static let sharedInstance = MemorablePlaceManager()
    
 
    
    var memorablePlaces = [MemorablePlace]()
    
    var count: Int {
        get {
            return memorablePlaces.count
        }
    }
    
    func removememorablePlaceAt(_ index:Int){
         removeMemorablePlaceFromDatabase(index)
         memorablePlaces.remove(at: index)
        
        }
    
    func removeMemorablePlaceFromDatabase(_ index:Int){
        let mobj = getMemorablePlaceAtIndex(index)
        let cordinates = mobj.coordinates
        
        let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        
        request.predicate = NSPredicate(format: "coordinate = %@", cordinates)
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                    
                     do {
                     
                     try context.save()
                     
                     } catch {
                     
                     }
                }
                
            }
            
        } catch {
            
            print("Fetch Failed")
        }
        
}
    
    func getMemorablePlaceAtIndex(_ index:Int) -> MemorablePlace {
        return memorablePlaces[index]
    }
    
    func addMemorablePlace(_ name: String,lat:Double, long:Double){
       //add to array
        memorablePlaces.append(MemorablePlace(locationName: name, latitude: lat, longitude: long))
        
        //add to core data
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        
        let entity =  NSEntityDescription.entity(forEntityName: "Places",
                                                        in:managedContext)
        
        let place = NSManagedObject(entity: entity!,
                                    insertInto: managedContext)
       
        let coordinate = "\(lat)\(long)"
        
        place.setValue(name, forKey: "locationName")
        place.setValue(lat, forKey: "lat")
        place.setValue(long, forKey: "long")
        place.setValue(nil, forKey: "usernote")
        place.setValue(coordinate, forKey: "coordinate")
        
        do {
            
            try managedContext.save()
            
        } catch {
            
            print("There was a problem!")
            
        }
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try managedContext.fetch(request)
           
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    print(result.value(forKey: "locationName")!)
                    print(result.value(forKey: "lat")!)
                    print(result.value(forKey: "lat")!)
                    print(result.value(forKey: "coordinate")!)
                    print("")
                    
                }
                
            }
            
        } catch {
            
            print("Fetch Failed")
        }
        

    
    }
    
    func fetchMemorablePlacesDatabase(){
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
    
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        
        request.returnsObjectsAsFaults = false
    
        
        do {
            
            _ = try managedContext.fetch(request)
            // let temp = results
            
            
        } catch {
            
            print("Fetch Failed")
        }
}

  
    
    //MARK: Init
    fileprivate init(){
        if memorablePlaces.isEmpty{
            memorablePlaces.append(MemorablePlace(locationName: "Central Park", latitude:40.7824813985303, longitude:-73.9655608927305))
        }
    }
}
