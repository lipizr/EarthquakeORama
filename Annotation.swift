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
    
    init(magnitude: Double,coordinates: CLLocationCoordinate2D, title: String ,desc: String, time: String, date: String ) {
        self.magnitude = magnitude
        self.coordinates = coordinates
        self.title = title
        self.desc = desc
        self.time = time
        self.date = date
        
        
        super.init()
    }
    
    var subTitle : Double {
        return magnitude!
    }
    
    
    // Since the class conformas to MKAnnotation you must return a CLLocation Object
    var coordinate:CLLocationCoordinate2D {
        return coordinates
    }
    
    

}
