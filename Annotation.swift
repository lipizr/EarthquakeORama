//
//  Annotations.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/19/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//


import MapKit

class Annotation: NSObject, MKAnnotation {
    
    
    let magnitude: Int?
    let coordinates: CLLocationCoordinate2D
    let title: String?
    let desc:String?
    
    
    
    //let date: NSDate?
    //let time: NSDate?
    
    init(magnitude: Int,coordinates: CLLocationCoordinate2D, title: String ,desc: String ) {
        self.magnitude = magnitude
        self.coordinates = coordinates
        self.title = title
        self.desc = desc
        
        
        
        
        //self.date = date
        //self.time = time
        
        super.init()
    }
    
    var subTitle : Int {
        return magnitude!
    }
    
    // Since the class conformas to MKAnnotation you must return a CLLocation Object
    var coordinate:CLLocationCoordinate2D {
        return coordinates
    }
    
    

}
