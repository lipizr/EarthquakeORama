//
//  MapViewExtension.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/19/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import Foundation
import MapKit

// This class extends MapViewController***
extension ViewController: MKMapViewDelegate {
    
    // /this is the view that pop up when you touch the annotation
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationReuseId = "pin"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationReuseId)
        
              if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
        } else {
            anView!.annotation = annotation
        }
        
        if let anView = anView {
            
            anView.image = UIImage(named: "annotationPin")
            anView.backgroundColor = UIColor.clearColor()
            anView.canShowCallout = true
            anView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
        }
        return anView!
    }

    
}

