//
//  ViewController.swift
//  CollectionViewTute

import UIKit
import Alamofire
import Haneke
var coms: [JSON] = []


var selectedticket = 0
class tickets: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    var i = 0
    var loading = LoadingView();
    @IBOutlet var collectionView: UICollectionView?
    var refreshCtrl = UIRefreshControl()
    var loadingStatus = false
    func loadNewVideo(){
        
        if(loadingStatus == false){
            loadingStatus == true
            
            
            coms.removeAll()
            Alamofire.request(.GET, "http://gameticket.dk/includes/api/private/getTicketsByUser.php?type=1&user_id=3&appSec=1&var=name,email,ticketName,blockName,button,access_code,start_date,end_date,block_id,image,addresss").responseJSON { (request, response, json, error) in
                println(error)
                if json != nil {
                    var jsonObj = JSON(json!)
                    
                    if let data = jsonObj.arrayValue as [JSON]?{
                        
                        coms = data
                        println(data.count)
                        self.collectionView?.reloadData()
                        
                        
                        self.loading.addStartingOpacity(0.0)
                        self.refreshCtrl.endRefreshing()
                        self.loadingStatus == false
                    }
                    else{println("loading error")}
                }
            }
        }
        else{
            println("Loader JSON")
        }
        
    }
 
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad() 
        
        loading.showAtCenterPointWithSize(CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2), size: 16.0)
        self.view.addSubview(loading)
        loading.startLoading()
        loading.addStartingOpacity(3.5)
        loadNewVideo()
        refreshCtrl.addTarget(self, action: "loadNewVideo", forControlEvents: .ValueChanged)
        collectionView?.addSubview(refreshCtrl)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  coms.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: EventCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let data =   coms[indexPath.row]
        i++
        println(i)
        cell.lblCell.text =  data["blockName"].string
        cell.Date.text =  data["ticketName"].string
        var imageView = UIImageView(frame: CGRectMake(0, -1, cell.frame.width, cell.frame.height))
        var  urlString = data["image"].string
        println(urlString)
        if(urlString != ""){
            var url = NSURL(string: "http://gameticket.dk/\(urlString!)")
            imageView.hnk_setImageFromURL(url!)
            cell.backgroundView = UIView()
            cell.backgroundView?.addSubview(imageView)}
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedVideo = indexPath.row
        let controller = storyboard?.instantiateViewControllerWithIdentifier("ticketPage") as! ticketPage
        presentViewController(controller, animated: true, completion: nil)
        
    }
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        var cellSize:CGSize = CGSizeMake(self.collectionView!.frame.width, 220)
        return cellSize
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

