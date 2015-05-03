//
//  ViewController.swift
//  CollectionViewTute

import UIKit
import Alamofire
import Haneke
var dataVideo: [JSON] = []
var i = 0
var selectedVideo = 0
class Events: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var loading = LoadingView();
    @IBOutlet var collectionView: UICollectionView?
    var refreshCtrl = UIRefreshControl()
    var loadingStatus = false
    func loadNewVideo(){
        
        if(loadingStatus == false){
            loadingStatus == true
            
            
            dataVideo.removeAll()
            Alamofire.request(.GET, "http://gameticket.dk/includes/api/public/getBlocks.php?type=3&var=block_id,name,cat,image,start_date,end_date&limit=0,3000").responseJSON { (request, response, json, error) in
                println(error)
                if json != nil {
                    var jsonObj = JSON(json!)
                    
                    if let data = jsonObj.arrayValue as [JSON]?{
                        
                        dataVideo = data
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
        return  dataVideo.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: EventCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        let data =   dataVideo[indexPath.row]
        i++
        println(i)
        cell.lblCell.text =  data["name"].string
        cell.Date.text =  data["start_date"].string
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
         let controller = storyboard?.instantiateViewControllerWithIdentifier("eventPage") as! eventPage
       presentViewController(controller, animated: true, completion: nil)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
}

