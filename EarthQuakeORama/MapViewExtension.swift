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
        
        // change annotation for my current location to be default.
        if annotation.isKindOfClass(MKUserLocation){
            return nil
        }else {
            
            if let anView = anView {
                
                anView.image = UIImage(named: "annotationPin")
                anView.backgroundColor = UIColor.clearColor()
                anView.canShowCallout = true
                anView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                //set up blue view to the left
                let dynamicView = UIView(frame: CGRectMake(0, 0, 60,50  ))
                let magLabel = UILabel(frame: CGRectMake(0, 0, dynamicView.frame.size.width, dynamicView.frame.size.height))
                magLabel.textAlignment = .Center
                let magIndex =  annotation as! Annotation
                magLabel.text = "\(magIndex.magnitude!)"
                magLabel.textColor = UIColor.whiteColor()
                dynamicView.addSubview(magLabel)
                dynamicView.backgroundColor = UIColor.appleBlue()
                anView.leftCalloutAccessoryView?.backgroundColor = UIColor.appleBlue()
                //anView.leftCalloutAccessoryView.
                anView.leftCalloutAccessoryView = dynamicView
                                        }
            return anView!
        }
        
       
    }

    
}

