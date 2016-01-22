//
//  DetailViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas retina mBP on 1/21/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class DetailViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var bottomViewHolder: UIView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var magLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var magImage: UIImageView!
    var annotationObject: Annotation!
    
    //move this to object
//    let descriptionArray: [String] = ["Earthquakes like this with a magnitude of about 2.0 or less are usually called microearthquakes; they are not commonly felt by people and are generally recorded only on local seismographs.", "Felt indoors by many, outdoors by few during the day. At night, some awakened. Dishes, windows, doors disturbed; walls make cracking sound. Sensation like heavy truck striking building. Standing motor cars rocked noticeably.", "Damage negligible in buildings of good design and construction; slight to moderate in well-built ordinary structures; considerable damage in poorly built or badly designed structures; some chimneys broken."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(annotationObject!.title)
        
        //centers map for selected annotation.
        let initialLocation = CLLocation(latitude: annotationObject!.coordinates.latitude, longitude: annotationObject.coordinates.longitude)
        centerMapOnLocation(initialLocation)
        mapView.addAnnotation(annotationObject)
        navigationItem.title = annotationObject!.title
        magLabel.text = "Magnitude: \(annotationObject.magnitude!)"
        timeLabel.text = annotationObject.time
        
        bottomViewHolder.layer.borderWidth = 0.5
        bottomViewHolder.layer.borderColor = UIColor.blackColor().CGColor
        
 
        // change the magnitude image depending on the magnitude
        if annotationObject.magnitude < 2.0{
                magImage.image = UIImage(named: "greenMarker")
                descriptionLabel.text = annotationObject.descriptionArray[0]

        } else if (annotationObject.magnitude > 2.0 && annotationObject.magnitude < 5.0) {
                magImage.image = UIImage(named: "yellowMarker")
                descriptionLabel.text = annotationObject.descriptionArray[1]

        
        } else {
                magImage.image = UIImage(named: "redMarker")
                descriptionLabel.text = annotationObject.descriptionArray[2]

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
