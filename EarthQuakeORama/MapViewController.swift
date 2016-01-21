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

    var toggleState = 1
    var Infoarray = NSMutableArray()
    
    @IBOutlet var containerView: UIView!
    
    
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
        
        

        
        //Step 3: Set Initial Location
        let initialLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        // This calls the helper method to zoom into the initialLocation.
        centerMapOnLocation(initialLocation)
        
        //set the delegate of the map to equal self. (this class)
        mapView.delegate = self
        
        API.getEarthquakeInformation(saveInfoArray)
    }
   
    
    // this is the method that is printing the information.
    func saveInfoArray(dataArray: NSMutableArray)  {
        
        Infoarray = dataArray
        
        for item in Infoarray {
            
            let locationName = item["properties"]!!["place"] as? String
            let subtitle = item["properties"]!!["mag"] as? Int
            
            if let lat = item["geometry"]!!["coordinates"]!![1] as? CLLocationDegrees {
                if let long = item["geometry"]!!["coordinates"]!![0] as? CLLocationDegrees {
                    print("lat: \(lat)")
                    print("long: \(long)")
                    //loop through the lats and longs and add annotation to map. MAGNITUDE IS NOT WORKING *******
                    let annotation = Annotation(magnitude: subtitle!, coordinates: CLLocationCoordinate2D(latitude: lat , longitude: long),title: locationName!, desc: "this is a description")
                    // Add the annotation to the map.
                    mapView.addAnnotation(annotation)
                    
                }
            }
        }
        
        //print(Infoarray)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let seg = segue.destinationViewController as? InformationTableView
        seg?.tableViewDataArray = Infoarray
        
    }
    
    
    // This method centers the map on the initial location
    func centerMapOnLocation(location:CLLocation) {
        
        // This sets radius distance. I set it to 10K km.
        let regionRadius : CLLocationDistance = 300000
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        // setRegion tells the mapview to display the region.
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}

