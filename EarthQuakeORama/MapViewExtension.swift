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
                let dynamicView = UIView(frame: CGRectMake(20, 20, anView.frame.size.width * 2, anView.frame.size.height * 2.5  ))
                let magLabel = UILabel(frame: CGRect(x: 10,y: 5,width: 40,height: 40))
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

