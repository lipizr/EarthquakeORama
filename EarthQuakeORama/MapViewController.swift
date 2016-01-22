//
//  ViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/19/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit
import Foundation
//Step 1: Import MapKit
import MapKit


class ViewController: UIViewController {
  
    let manager = CLLocationManager()
    var selectedMapIndex = 0
    var Infoarray = NSMutableArray()
    var annotationsObjectsArray = [Annotation]()
    
    //Step 2: Create an outlet for your map
    @IBOutlet var mapView: MKMapView!
    
    @IBAction func segControlTapped(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = MKMapType.Standard
            
        case 1:
            mapView.mapType = MKMapType.SatelliteFlyover
            
        default:
            mapView.mapType = MKMapType.SatelliteFlyover
        }
    
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "EarthQuake-O-Rama"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Step 3: Set Initial Location
        let initialLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        // This calls the helper method to zoom into the initialLocation.
        centerMapOnLocation(initialLocation)
        
        //set the delegate of the map to equal self. (this class)
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        // Request Permission to use location.
        if CLLocationManager.locationServicesEnabled(){
            
            manager.startUpdatingLocation()
        }
        
        if CLLocationManager.authorizationStatus() == .NotDetermined{
            // only request permission when in use so as not to run in background.
            manager.requestWhenInUseAuthorization()
        }
        
        func locationManager(manager: CLLocationManager!,didChangeAuthorizationStatus status: CLAuthorizationStatus){
            
            if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
                manager.startUpdatingLocation()
                
                
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        API.getEarthquakeInformation(saveInfoArray)
    }
    
    @IBAction func locationTapped(sender: AnyObject) {
        
       centerMapOnLocation(mapView.userLocation.location!)
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //define a var to store annotation inside of annotation view
        let selectedAnnotation = view.annotation
        //loop thru the annotationArray to match the annotation
        for annot in annotationsObjectsArray{
            
            if annot.title == selectedAnnotation!.title! {
            
                //break the loop and send, and sender is going to be annot I found
                performSegueWithIdentifier("toDetail", sender: annot)
                break
            
            }
            
        }
        
    }
    
    // Parse JsonReturn info here, and then call the method in VDL
    func saveInfoArray(dataArray: NSMutableArray) {
        Infoarray = dataArray
        print(Infoarray)
       
        for item in Infoarray {
            
            let locationName = item["properties"]!!["place"] as? String
            let subtitle = item["properties"]!!["mag"] as? Double
            let time = item["properties"]!!["time"] as? NSTimeInterval
            // Date Parsing.
            let timeFormatter = NSDateFormatter()
            let dateFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            dateFormatter.dateStyle = .ShortStyle
            let dateTime = NSDate(timeIntervalSince1970: time!) as NSDate
            let stringTime = timeFormatter.stringFromDate(dateTime)
            let stringDate = dateFormatter.stringFromDate(dateTime)
            
            
            if let lat = item["geometry"]!!["coordinates"]!![1] as? CLLocationDegrees {
                if let long = item["geometry"]!!["coordinates"]!![0] as? CLLocationDegrees {
                    
                    let annotation = Annotation(magnitude: subtitle!, coordinates: CLLocationCoordinate2D(latitude: lat , longitude: long),title: locationName!, desc: "this is a description", time: stringTime, date: stringDate)
                    
                    print("\(stringTime) and \(stringDate)")
                    // Perform a loop and append object to annotationsArray. This array gets sent to the appropriate classes in line 138-152
                    annotationsObjectsArray.append(annotation)
                    
                    // Add the annotation to the map. Update annotations to map on MAIN THREAD
                    dispatch_async(dispatch_get_main_queue()) {
                       self.mapView.addAnnotation(annotation)
                    }
                    
                }
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        /*In order to segue in a more effficient way, all segues are done through the presenting view controller (this VC). i.e: In InformationTableView in didSelect, "mapViewController.performSegueWithIdentifier("toDetail", sender: self.annotationsArray[indexPath.row])"  */
        if segue.identifier == "toTableView"{
            
            let seg = segue.destinationViewController as? InformationTableView
            // Send in all annotations currenty on map as an array to destination.
            seg?.annotationsArray = annotationsObjectsArray
 
        }
        
        if segue.identifier == "toDetail" {
            let detSeg = segue.destinationViewController as? DetailViewController
            //send in sender as an annotation object and it should work.
            detSeg?.annotationObject = sender as? Annotation
            
            self.navigationItem.title = ""
            
            
        }
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

