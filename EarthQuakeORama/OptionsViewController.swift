//
//  OptionsViewController.swift
//  EarthQuakeORama
//
//  Created by Dimas Lipiz on 1/21/16.
//  Copyright © 2016 Dimas Lipiz. All rights reserved.
//

import UIKit
import MessageUI

class OptionsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    @IBOutlet var aboutUSGSButton: UIButton!
    @IBOutlet var sendFeedBackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aboutUSGSButton.layer.cornerRadius = 5.0
        self.aboutUSGSButton.clipsToBounds = true
        self.sendFeedBackButton.layer.cornerRadius = 5.0
        self.sendFeedBackButton.clipsToBounds = true
    }

    @IBAction func tapGestureTapped(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    
    }
    @IBAction func dismissVC(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        
        // check if running on sim. AlertView deprecated. Use AlerController instead.
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            print("running on sim")
            let alert = UIAlertController(title: "Silly You!", message:"You can't send feedback on a simulator, try running on an actual device", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
            self.presentViewController(alert, animated: true){}
            
        #else
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        #endif
      
    }
    
    @IBAction func aboutButtonTapped(sender: AnyObject) {
     
        //UIApplication.sharedApplication().openURL(NSURL(string: "http://www.usgs.gov/aboutusgs/")!)
        performSegueWithIdentifier("toWebView", sender: self)
       
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["lipizdesigns@gmail.com"])
        mailComposerVC.setSubject("Reviewing your application")
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alert = UIAlertController(title: "Cannot send mail", message:"There was an issue sending feedback on this device", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
        self.presentViewController(alert, animated: true){}
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
      

}






