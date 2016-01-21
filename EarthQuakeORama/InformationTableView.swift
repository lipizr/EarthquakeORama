//
//  InformationTableViewViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/20/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit

class InformationTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {

     var tableViewDataArray = NSMutableArray()
    
    @IBOutlet var tableView: UITableView!
   
    @IBAction func dismissView(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clearColor()
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataArray.count
        //really want to return the array.count, when i manage to get it over.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let titleArray = NSMutableArray();
        
        let cell = tableView.dequeueReusableCellWithIdentifier("infoTableCellReuse") as? InformationTVCell
        for item in tableViewDataArray {
            
            if let places = item["properties"]!!["place"] as! NSString? {
                titleArray.addObject(places)
                
            }
            
        }
        
        cell?.locationLabel?.text = titleArray[indexPath.row] as? String
        cell?.backgroundColor = UIColor.clearColor()
        cell?.accessoryType = .DisclosureIndicator
        return cell!
    }

   
}
