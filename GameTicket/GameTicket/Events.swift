//
//  ViewController.swift
//  CollectionViewTute

import UIKit
import Alamofire
import Haneke
var Blocks = [Block]()
var filteredBlocks = [Block]()
var i = 0
var is_searching:Bool!


var selectedblock = 0
class Events: UIViewController, FloatingMenuControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
 
    @IBOutlet weak var search: UISearchBar!
    var loading = LoadingView();
    @IBOutlet var collectionView: UICollectionView?
    var refreshCtrl = UIRefreshControl()
    var loadingStatus = false
    func loadNewVideo(){
        
        if(loadingStatus == false){
            loadingStatus == true
            
            
            Blocks.removeAll()
            Alamofire.request(.GET, "http://gameticket.dk/includes/api/public/getBlocks.php?type=3&var=block_id,name,cat,image,start_date,end_date,homepage,email&asc_desc=ASC&limit=0,200").responseJSON { (req, res, dataFromNetworking, error) in
                if(error != nil) {
                    NSLog("GET Error: \(error)")
                    println(res)
                }
                if(dataFromNetworking != nil){
                    let json = JSON(dataFromNetworking!)
                    
                    for var i = 0; i <= json.count-1; i++
                    { 
                     
                     Blocks.append(Block(id:json[i]["block_id"].string!.toInt()!,cat:json[i]["cat"].string!.toInt()!,name:json[i]["name"].string!,image:json[i]["image"].string!,startDate:json[i]["start_date"].string!,endDate:json[i]["end_date"].string!,homepage:json[i]["homepage"].string!,email:json[i]["email"].string!));
                   
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
      @IBOutlet weak var floatingButton: FloatingButton!
    
    @IBAction func floatingButtonPressed(sender: AnyObject) {
        let controller = FloatingMenuController(fromView: sender as! UIButton)
        controller.delegate = self
        
        controller.buttonArray = [
            FloatingButton(image: UIImage(named: "location"), backgroundColor: nil),
            FloatingButton(image: UIImage(named: "user"), backgroundColor: nil),
            FloatingButton(image: UIImage(named: "tickets"), backgroundColor: nil),
            FloatingButton(image: UIImage(named: "search"), backgroundColor: nil)
        ]
        
        controller.labelTitles = [
             "Home",
            "Profile",
            "Tickets",
            "Search",
           
        ]
        
        
        presentViewController(controller, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
          floatingButton.setup()
        is_searching = false
        
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
            return filteredBlocks.count
        }else{
            return Blocks.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: EventCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        var name = ""
        var startDate = ""
        var image = ""
        var data = Blocks[indexPath.row]
        if(is_searching == true){
            data =  filteredBlocks[indexPath.row]}
        else{
            data =  Blocks[indexPath.row]}
        
      cell.lblCell.text = data.name
      cell.Date.text =  data.startDate
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
         let controller = storyboard?.instantiateViewControllerWithIdentifier("eventPage") as! eventPage
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
    func floatingMenuController(controller: FloatingMenuController, didTapOnButton button: UIButton, atIndex index: Int) {
        println(index)
        controller.dismissViewControllerAnimated(true, completion: nil)
        var indexArray = ["home","profile","tickets","search"]
        var index1 = indexArray[index];
        if(index1 != "home"){
        let controller = storyboard!.instantiateViewControllerWithIdentifier(index1) as! UIViewController
            self.presentViewController(controller, animated: true, completion: nil)}
    }
    
    func floatingMenuControllerDidCancel(controller: FloatingMenuController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text.isEmpty{
            is_searching = false
            self.collectionView!.reloadData()
        } else {
            println("search text %@ ",searchBar.text as NSString)
            is_searching = true
            filteredBlocks.removeAll()
            for var index = 0; index < Blocks.count; index++
            {
                var currentString = "\(Blocks[index].name)"
                if currentString.lowercaseString.rangeOfString(searchText.lowercaseString)  != nil {
                    println(Blocks[index].name)
                    filteredBlocks.append(Blocks[index])
                    
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

