//
//  ViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/19/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit
//Step 1: Import MapKit
import MapKit



class ViewController: UIViewController {

    
    
    
    //Step 2: Create an outlet for your map
    @IBOutlet var mapView: MKMapView!
    
    // Change Map Type
    @IBAction func segControlTapped(sender: UISegmentedControl) {
    
        switch sender.selectedSegmentIndex {
            case 0:
                mapView.mapType = MKMapType.Standard
                sender.tintColor = UIColor.blueColor()
            
            case 1:
                mapView.mapType = MKMapType.Satellite
                sender.tintColor = UIColor.whiteColor()
            
            default:
                mapView.mapType = MKMapType.Standard
        }
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let array = API.getEarthquakeInformation()
        print(array)
        
        
        
        
        //Step 3: Set Initial Location
        let initialLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        // This calls the helper method to zoom into the initialLocation.
        centerMapOnLocation(initialLocation)
        
        // This creates a new annotations object and adds an annotation to the map view
        let annotation = Annotations(locationName: "Bay Area", coordinates: CLLocationCoordinate2D(latitude: 37.7833, longitude: -122.4167),title: "Bay Area State Park")
        // Add the annotation to the map.
        mapView.addAnnotation(annotation)
        
        mapView.delegate = self
        
    }
    
    
    

    // This method centers the map on the initial location
    func centerMapOnLocation(location:CLLocation) {
        
        // This sets radius distance. I set it to 10K km.
        let regionRadius : CLLocationDistance = 10500
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        // setRegion tells the mapview to display the region.
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
  }

