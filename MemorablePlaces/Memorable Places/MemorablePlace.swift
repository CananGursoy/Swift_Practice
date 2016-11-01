//
//  MemorablePlace.swift
//  Memorable Places
//
//  Created by Hatice Gursoy on 8/14/16.
//  Copyright © 2016 Hatice Gursoy. All rights reserved.
//

import UIKit

class MemorablePlace{
    var locationName:String
    var latitude:Double
    var longitude:Double
    var userNote:String?
    var coordinates:String
    
    init(locationName:String,latitude:Double,longitude:Double){
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
        self.userNote = nil
        self.coordinates = "\(latitude)\(longitude)"
        
    }
    
    func setLocationName(_ locationName:String){
        self.locationName = locationName
    
    }
    
    func setuserNote(_ userNote:String){
        self.userNote = userNote 
    
    }
    
    

}
