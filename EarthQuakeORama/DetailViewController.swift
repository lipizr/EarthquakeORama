//
//  DetailViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas retina mBP on 1/21/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

     var annotationArray = [Annotation]()
    var annotationObject: Annotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(annotationObject?.title)

      
    }

   
}
