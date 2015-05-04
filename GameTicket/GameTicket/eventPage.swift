//
//  eventPage.swift
//  GameTicket
//
//  Created by Joachim Dittman on 03/05/15.
//  Copyright (c) 2015 Joachim Dittman. All rights reserved.
//

import UIKit

class eventPage: UIViewController {
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
        var data =  dataVideo
    
        let image = UITextView();
        navi.title = data[selectedVideo]["name"].string
       
    
        
        var id = data[selectedVideo]["block_id"].string;
        println(id);
        let url1 = NSURL (string: "http://www.gameticket.dk/block.php?id=\(id!)");
        let requestObj = NSURLRequest(URL: url1!);
        webview.frame = CGRectMake(0,-20,view.frame.width,view.frame.height)
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
    

}
