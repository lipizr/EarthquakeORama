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
  
    @IBOutlet var activityInd: UIActivityIndicatorView!
    @IBOutlet var updatedLabel: UILabel!
    let manager = CLLocationManager()
    var selectedMapIndex = 0
    var Infoarray = NSMutableArray()
    var annotationsObjectsArray = [Annotation]()
    
    // Create an outlet for your map
    @IBOutlet var mapView: MKMapView!
    // Change Map Type
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
        activityInd.hidesWhenStopped = true
        activityInd.startAnimating()
        activityInd.color = UIColor.appleBlue()
        
        //set the delegate of the map
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
    //Call the api method after the viewDidAppear.
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
        Networking.getEarthquakeInformation(saveInfoArray)
        
    }
    
    //Refreshes the Api call
    @IBAction func refreshTapped(sender: AnyObject) {
    Networking.getEarthquakeInformation(saveInfoArray)
    mapView.reloadInputViews()
    
    }
    //Centers View to your current location
    @IBAction func locationTapped(sender: AnyObject) {
        
       centerMapOnLocation(mapView.userLocation.location!)
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //define a var to store annotation inside of annotation view
        let selectedAnnotation = view.annotation
        //loop thru the annotationArray to match the annotation
        for annot in annotationsObjectsArray{
            
            if annot.title == selectedAnnotation!.title! {
            
                // Check to see if the title of the annotation matches the title of the one selected.
                performSegueWithIdentifier("toDetail", sender: annot)
                break
            
            }
        }
    }
    
    // Parse JsonReturn info here, and then call the method in VDL
    func saveInfoArray(dataArray: NSMutableArray) {
        Infoarray = dataArray
        
       for item in Infoarray {
            
            let locationName = item["properties"]!!["place"] as! String
            let magnitude = item["properties"]!!["mag"] as? Double
            let time = item["properties"]!!["time"] as? NSTimeInterval
            let updatedTime = item["properties"]!!["updated"] as? NSTimeInterval
            let timeFormatter = NSDateFormatter()
            let dateFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "h:mm a"
            timeFormatter.timeZone = NSTimeZone(name: "GMT")
            dateFormatter.dateFormat = "MM/dd/yyy"
            dateFormatter.timeZone = NSTimeZone(name: "GMT")
            let dateTime = NSDate(timeIntervalSince1970: time! / 1000)
            let updateTime = NSDate(timeIntervalSince1970: updatedTime! / 1000) as NSDate
            let stringTime = timeFormatter.stringFromDate(dateTime)
            let stringDate = dateFormatter.stringFromDate(dateTime)
            let stringUpdated = timeFormatter.stringFromDate(updateTime)
            // Latitude and Longitude must be binded to not show as optionals.
            if let lat = item["geometry"]!!["coordinates"]!![1] as? CLLocationDegrees {
                if let long = item["geometry"]!!["coordinates"]!![0] as? CLLocationDegrees {
                    
                    let annotation = Annotation(magnitude: magnitude!, coordinates: CLLocationCoordinate2D(latitude: lat , longitude: long),title: locationName, desc: "", time: stringTime, date: stringDate, updatedTime: stringUpdated)
                    
                    // Perform a loop and append object to annotationsArray. This array gets sent to the appropriate classes in line 164-182
                    annotationsObjectsArray.append(annotation)
                    
                    // Add the annotation to the map. Update annotations to map on MAIN THREAD
                    dispatch_async(dispatch_get_main_queue()) {
                       self.mapView.addAnnotation(annotation)
                       self.activityInd.stopAnimating()
                        
                    }
                    
                }
            }
        updatedLabel.text = "Updated At: \(stringUpdated)"
        
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
    
    // This is a helper method that gets called when user wants to see current location.
    func centerMapOnLocation(location:CLLocation) {
        
        // This sets radius distance.
        let regionRadius : CLLocationDistance = 500000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        // setRegion tells the mapview to display the region.
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}

