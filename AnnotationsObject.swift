//
//  Annotations.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/19/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//


import MapKit

class Annotations: NSObject, MKAnnotation {
    
    
    let locationName: String?
    let coordinates: CLLocationCoordinate2D
    let title: String?
    //let date: NSDate?
    //let time: NSDate?
    
    init(locationName: String,coordinates: CLLocationCoordinate2D, title: String /*time: NSDate*/) {
        self.locationName = locationName
        self.coordinates = coordinates
        self.title = title
        //self.date = date
        //self.time = time
        
        super.init()
    }
    
    // Since the class conformas to MKAnnotation you must return a CLLocation Object
    var coordinate:CLLocationCoordinate2D {
        return coordinates
    }
    
    var subTitle:String {
        
        return locationName!
    }
    

}
