//
//  ViewController.swift
//  CollectionViewTute

import UIKit
import Alamofire
import Haneke
var BlockTickets = [Ticket]()
var filteredBlockTickets = [Ticket]()

var selectedticket = 0
class tickets: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {
    var i = 0
    @IBOutlet weak var searchbar: UISearchBar!
    var loading = LoadingView();
    @IBOutlet var collectionView: UICollectionView?
    var refreshCtrl = UIRefreshControl()
    var loadingStatus = false
 
    func loadNewVideo(){
        
        if(loadingStatus == false){
            loadingStatus == true
            
            
             BlockTickets.removeAll()
            Alamofire.request(.GET, "http://gameticket.dk/includes/api/private/getTicketsByUser.php?type=1&user_id=3&appSec=1&var=name,ticketName,blockName,access_code,start_date,end_date,block_id,image,address&asc_desc=ASC&limit=0,50").responseJSON { (req, res, dataFromNetworking, error) in
               println("DONe")
                if(error != nil) {
                    NSLog("GET Error: \(error)")
                    println(res)
                }
           if(dataFromNetworking != nil){
                    let json = JSON(dataFromNetworking!)
            
                    for var i = 0; i <= json.count-1; i++
                    {
                        println(i)
                        
                       BlockTickets.append(
                        Ticket(
                        id:json[i]["block_id"].string!.toInt()!,
                        name:json[i]["name"].string!,
                        ticketName:json[i]["ticketName"].string!,
                        blockName:json[i]["blockName"].string!,
                        access_code:json[i]["access_code"].string!,
                        startDate:json[i]["start_date"].string!,
                        endDate:json[i]["end_date"].string!,
                        block_id:json[i]["block_id"].string!.toInt()!,
                        image:json[i]["image"].string!,
                        address:json[i]["address"].string!));
                       
                    }
                    
            
                }
                self.collectionView?.reloadData()
                self.loading.addStartingOpacity(0.0)
                self.refreshCtrl.endRefreshing()
                self.loadingStatus == false
                
                println("DONe")
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
        if is_searching == true{
            return filteredBlockTickets.count
        }else{
            return BlockTickets.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: EventCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        var name = ""
        var startDate = ""
        var image = ""
        var data = BlockTickets[indexPath.row]
        if(is_searching == true){
            data =  filteredBlockTickets[indexPath.row]}
        else{
            data =  BlockTickets[indexPath.row]}
        
        cell.lblCell.text = data.ticketName
        cell.Date.text =  data.blockName
        var imageView = UIImageView(frame: CGRectMake(0, -1, cell.frame.width, cell.frame.height))
        var  urlString = data.image
        
        if(urlString != ""){
            var url = NSURL(string: "http://gameticket.dk/\(urlString)")
            imageView.hnk_setImageFromURL(url!)
            cell.backgroundView = UIView()
            cell.backgroundView?.addSubview(imageView)}
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedblock = indexPath.row
        let controller = storyboard?.instantiateViewControllerWithIdentifier("ticketPage") as! ticketPage
        presentViewController(controller, animated: true, completion: nil)
        
    }
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        var cellSize:CGSize = CGSizeMake(screenSize.width, screenSize.height/3)
        
        return cellSize
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text.isEmpty{
            is_searching = false
            self.collectionView!.reloadData()
        } else {
            println("search text %@ ",searchBar.text as NSString)
            is_searching = true
            filteredBlockTickets.removeAll()
            for var index = 0; index < BlockTickets.count; index++
            {
                var currentString = "\(BlockTickets[index].ticketName)"
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    println(BlockTickets[index].ticketName)
                    filteredBlockTickets.append(BlockTickets[index])
                    
                }
                
            }
            self.collectionView!.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        NSLog("The default search bar keyboard search button was tapped: \(searchBar.text).")
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        NSLog("The default search bar cancel button was tapped.")
        searchBar.resignFirstResponder()
    }
}

