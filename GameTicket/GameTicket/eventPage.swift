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
        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        // 3
        // 4
        let image = UITextView();
        navi.title = data[selectedVideo]["name"].string
       
        
        
      /*  var imageView = UIImageView(frame: CGRectMake(0, -1, view.frame.width, view.frame.height))
        
        var  urlString = data[selectedVideo]["image"].string
      
            var url = NSURL(string: "http://gameticket.dk/\(urlString!)")
        
            HeaderImage.hnk_setImageFromURL(url!)
        var start_date  = data[selectedVideo]["start_date"].string
        var end_date = data[selectedVideo]["end_date"].string
        dateLabel.text = "\(start_date!) - \(end_date!)"
        nameLabel.text = data[selectedVideo]["name"].string
        // Do any additional setup after loading the view.*/
        
        var id = data[selectedVideo]["block_id"].string;
        println(id);
        let url1 = NSURL (string: "http://www.gameticket.dk/block.php?id=\(id!)");
        let requestObj = NSURLRequest(URL: url1!);
        webview.frame = CGRectMake(0,-20,view.frame.width,view.frame.height)
       webview.loadRequest(requestObj);
        /*
        myscr = UIScrollView(frame: view.bounds)
        myscr!.frame = CGRectMake(0,200,view.frame.width,view.frame.height)
        myscr!.contentSize = CGSizeMake(320,800)
        myscr!.scrollEnabled = true
        myscr!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(myscr!)
        
        buyButton = UIButton()
        buyButton!.frame = CGRectMake(0,0,view.frame.width,50)
        buyButton!.backgroundColor = UIColor.blueColor()
        buyButton!.setTitle("Køb billetter", forState: .Normal)
        buyButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buyButton!.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        myscr!.addSubview(buyButton!)
 
        
        mytext2 = UITextView ()
        mytext2!.frame = CGRectMake(0,50,view.frame.width,50)
        mytext2!.text = data[selectedVideo]["description"].string
        mytext2!.backgroundColor = UIColor.lightGrayColor()
        myscr!.addSubview(mytext2!)
        
        mylbl2 = UILabel()
        mylbl2!.frame = CGRectMake(10,650,250,30)
        mylbl2!.text = "My Second Label"
        mylbl2!.backgroundColor = UIColor.yellowColor()
        myscr!.addSubview(mylbl2!)*/
    }
    func pressed(sender: UIButton!) {
        var alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = "title";
        alertView.message = "message";
        alertView.show();
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
