//
//  DetailViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas retina mBP on 1/21/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    
    @IBOutlet var mapView: MKMapView!
    
    var annotationObject: Annotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(annotationObject!.title)
        
        //centers map for selected annotation.
        let initialLocation = CLLocation(latitude: annotationObject!.coordinates.latitude, longitude: annotationObject.coordinates.longitude)
        centerMapOnLocation(initialLocation)
        
        mapView.addAnnotation(annotationObject)
        
        navigationItem.title = annotationObject!.title
        

      
    }
    
    // This method centers the map on the initial location
    func centerMapOnLocation(location:CLLocation) {
        
        // This sets radius distance. I set it to 10K km.
        let regionRadius : CLLocationDistance = 500000
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        // setRegion tells the mapview to display the region.
        mapView.setRegion(coordinateRegion, animated: true)
    }


   
}
