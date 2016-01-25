//
//  WebViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/25/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit


class WebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    let urlForUSGS = NSURL(string: "http://usgs.gov/aboutusgs/who_we_are/")
        let request = NSURLRequest(URL: urlForUSGS!)
        webView.loadRequest(request)
   
    }

    @IBAction func dismissWebView(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }
}
