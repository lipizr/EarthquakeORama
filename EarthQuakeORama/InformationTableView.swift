//
//  InformationTableViewViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/20/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit
import MapKit

class InformationTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {

        @IBAction func tapGestureTapped(sender: AnyObject) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        var annotationsArray = [Annotation]()
        @IBOutlet var tableView: UITableView!
        @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clearColor()
        tableView.layer.borderColor = UIColor.lightGrayColor().CGColor
        tableView.layer.borderWidth = 0.5
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotationsArray.count
       
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let mapViewController = (self.presentingViewController as! UINavigationController).viewControllers[0]
            self.dismissViewControllerAnimated(true) {
            mapViewController.performSegueWithIdentifier("toDetail", sender: self.annotationsArray[indexPath.row])
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("infoTableCellReuse") as! InformationTVCell
        cell.locationLabel?.text = annotationsArray[indexPath.row].title!
        cell.magLabel?.text = "MAG: \(annotationsArray[indexPath.row].magnitude!)"
        cell.timeLabel.text = annotationsArray[indexPath.row].time
        //TODO: FIX DATE TIME.
        cell.dateLabel.text = annotationsArray[indexPath.row].date
        cell.backgroundColor = UIColor.clearColor()
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
}
