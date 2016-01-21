//
//  InformationTableViewViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/20/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit

class InformationTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrayHolder = NSMutableArray()
    
    @IBOutlet var tableView: UITableView!
   
    @IBAction func dismissView(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clearColor()
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        //really want to return the array.count, when i manage to get it over.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("infoTableCellReuse") as? InformationTVCell
        cell?.locationLabel.text =  "California"
        cell?.backgroundColor = UIColor.clearColor()
        return cell!
    }

   
}
