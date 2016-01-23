//
//  Annotations.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/19/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//


import MapKit

class Annotation: NSObject, MKAnnotation {
    
    
    let magnitude: Double?
    let coordinates: CLLocationCoordinate2D
    var title: String?
    let desc:String?
    let time: String?
    let date: String?
    let updatedTime: String?
    var descriptionArray: [String] = ["Earthquakes like this with a magnitude of about 2.0 or less are usually called microearthquakes; they are not commonly felt by people and are generally recorded only on local seismographs.", "Felt indoors by many, outdoors by few during the day. At night, some awakened. Dishes, windows, doors disturbed; walls make cracking sound. Sensation like heavy truck striking building. Standing motor cars rocked noticeably.", "Damage negligible in buildings of good design and construction; slight to moderate in well-built ordinary structures; considerable damage in poorly built or badly designed structures; some chimneys broken."]

    
    init(magnitude: Double,coordinates: CLLocationCoordinate2D, title: String ,desc: String, time: String, date: String, updatedTime: String) {
        self.magnitude = magnitude
        self.coordinates = coordinates
        self.title = title
        self.desc = desc
        self.time = time
        self.date = date
        self.updatedTime = updatedTime
        
        
        
        super.init()
    }
    
    var subTitle : Double {
        return magnitude!
    }
    
    
    // Since the class conformas to MKAnnotation you must return a CLLocation Object
    var coordinate:CLLocationCoordinate2D {
        return coordinates
    }
    
    var descriptions:[String]{
        return descriptionArray
    }
    
    

}
