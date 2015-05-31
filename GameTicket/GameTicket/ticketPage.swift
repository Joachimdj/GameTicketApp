//
//  eventPage.swift
//  GameTicket
//
//  Created by Joachim Dittman on 03/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class ticketPage: UIViewController {
    @IBOutlet weak var webview: UIWebView!
    var myscr : UIScrollView?
    var buyButton : UIButton?
    var mylbl : UILabel?
    var mytext2 : UITextView?
    var mylbl2 : UILabel?
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var HeaderImage: UIImageView!
    
    @IBOutlet weak var navi: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        var data = BlockTickets
        
        let image = UITextView();
        //navi.title = data[selectedticket]["ticketName"]
        
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
    
    
}
