//
//  API.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/19/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit

class API: NSObject {
    
    static func getEarthquakeInformation(completionHandler: (informationArray: NSMutableArray) -> ())  {
        
        let session = NSURLSession.sharedSession()
        let urlString = "http://ehp2-earthquake.wr.usgs.gov/fdsnws/event/1/query?format=geojson&limit=40"
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request){ data,response,downloadError in
            
            if let error = downloadError {
                print("could not complete the request\(error)")
            } else {
                
                let parsedResult = try! NSJSONSerialization.JSONObjectWithData(data! , options: NSJSONReadingOptions.AllowFragments)
                let dataDict = parsedResult as! NSDictionary
                
                // This holds all the information we need from the API.
                if let result = dataDict["features"] as? NSMutableArray {
                    
                    completionHandler(informationArray: result)
                } else {
                    print("error")
                }
                
            }
            
        }
        
        task.resume()
        
        
    }
    
    
}
