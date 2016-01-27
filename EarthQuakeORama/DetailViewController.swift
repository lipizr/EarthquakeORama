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
        
 
        // Change the magnitude image depending on the magnitude. Try Refactor with Dict.
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
        
        let regionRadius : CLLocationDistance = 500000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
   
}
