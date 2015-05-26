//
//  eventPage.swift
//  GameTicket
//
//  Created by Joachim Dittman on 03/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit
import MessageUI
import Social
class eventPage: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var navi: UINavigationItem!
    @IBOutlet weak var contactButton: UIBarButtonItem!
    @IBOutlet weak var Website: UIBarButtonItem!
     @IBOutlet weak var BuyButton: UIBarButtonItem!
    var data =  Blocks[selectedblock]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(is_searching == true){
            data =  filteredBlocks[selectedblock]}
        else{
         data =  Blocks[selectedblock]}
        navi.title = data.name
        if(data.homepage.isEmpty){ Website.enabled = false }
        if(data.email.isEmpty){ contactButton.enabled = false   }
        if(data.email.isEmpty){ BuyButton.enabled = false   }
        var id = data.id
        println(id);
        let url1 = NSURL (string: "http://www.gameticket.dk/block.php?id=\(id)&app=true");
        let requestObj = NSURLRequest(URL: url1!);
       webview.loadRequest(requestObj);
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    @IBAction func close(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
        
    }
    
    
    @IBAction func openURL(sender: AnyObject) {
        var url : NSURL
        url = NSURL(string: "\(data.homepage)")!
        UIApplication.sharedApplication().openURL(url)

    }
 
    
    @IBAction func SendEmail(sender: AnyObject) {
        println(data.email)
        if (MFMailComposeViewController.canSendMail()) {
            
            var toRecipents = ["\(data.email)"]
            
            var mc:MFMailComposeViewController = MFMailComposeViewController()
            
            mc.mailComposeDelegate = self
            
            mc.setToRecipients(toRecipents)
            
            self.presentViewController(mc, animated: true, completion: nil)
            
        }else {
            
            println("No email account found")
            
        }

    }
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        switch result.value {
            
        case MFMailComposeResultCancelled.value:
            println("Mail Cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail Saved")
        case MFMailComposeResultSent.value:
            println("Mail Sent")
        case MFMailComposeResultFailed.value:
            println("Mail Failed")
        default:
            break
            
        }
        
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
 
    @IBAction func buyTicket(sender: AnyObject) {
        let url1 = NSURL (string: "http://www.gameticket.dk/signup.php?id=\(data.id)&app=true");
        let requestObj = NSURLRequest(URL: url1!); 
        webview.loadRequest(requestObj);
    }
    
}
