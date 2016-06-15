//
//  RentViewController.swift
//  PVMARKET
//
//  Created by open open on 2016/5/23.
//  Copyright (c) 2016年 openopen. All rights reserved.
//

import UIKit
import Alamofire



class RentViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NSURLSessionDataDelegate,NSURLSessionDelegate {
    
    
    //MARK: - Model Data Array
    var titleArray         = [String]()  //EX:"彰化芳苑 養鴨場10棟大屋頂"
    var locationArray      = [String]()  //EX:"彰化"
    var sizeArray          = [Int]()     //EX:123   (坪)
    var priceOfRent1YArray = [Int]()     //EX:48500
    var iRRArray           = [Double]()  //EX:8.53
    var directionArray     = [String]()  //EX:"東西"
    var typeArray          = [String]()  //EX:"G舍"
    var ppidArray          = [String]()  //EX:"CH10504001"
    var imageCountArray    = [Int]()     //EX:5 (num of image)
    var dateArray          = [String]()  //EX:"2016/01/01"
    var isCaseShown = [Bool]() //for animation shown mark

    let jsonURl = "http://m102.nthu.edu.tw/~s102021607/rentJson001.json"//JSON DATA URL
    let refreshControl = UIRefreshControl()
    
    let pvWebsiteUrlPart  = PvWebsiteUrlPart()
    
    
    // outlet items
    @IBOutlet weak var rentTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getJsonData(jsonURl) // download json data by url
        getJsonData(dataURL.rentJsonURL) // download json data by url

        
        //添加刷新
        refreshControl.addTarget(self, action: #selector(RentViewController.refreshData), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "刷新資料")
        rentTableView.addSubview(refreshControl)
    }
    
    // 刷新数据
    func refreshData() {
        
        getJsonData(dataURL.rentJsonURL) // download json data by url
//        self.refreshControl.endRefreshing()
//        NSLog("刷新資料")
        
        
    }


    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
    
    //MARK: - GET JSON
    func getJsonData(urlString: String){
        
                NSURLCache.sharedURLCache().removeAllCachedResponses()// remove/clear cache
                // empty/clear data array for reload/reassign data from json file
                self.titleArray         = [String]()  //EX:"彰化芳苑 養鴨場10棟大屋頂"
                self.locationArray      = [String]()  //EX:"彰化"
                self.sizeArray          = [Int]()     //EX:123   (坪)
                self.priceOfRent1YArray = [Int]()     //EX:48500
                self.iRRArray           = [Double]()  //EX:8.53
                self.directionArray     = [String]()  //EX:"東西"
                self.typeArray          = [String]()  //EX:"G舍"
                self.ppidArray          = [String]()  //EX:"CH10504001"
                self.imageCountArray    = [Int]()     //EX:5 (num of image)
                self.dateArray          = [String]()  //EX:"2016/01/01"
                self.isCaseShown = [Bool]()
        
                Alamofire.request(.GET,urlString).responseJSON { (response) in
                    if let JSON = response.result.value{
                        
                        let jsonObj = JSON as! NSArray
                        for p in jsonObj {
                            
                            let Title_JsonValue         = p.objectForKey("Title")          as? String
                            let Location_JsonValue      = p.objectForKey("Location")       as? String
                            let Size_JsonValue          = p.objectForKey("Size")           as? Int
                            let PriceOfRent1Y_JsonValue = p.objectForKey("PriceOfRent1Y")  as? Int
                            let IRR_JsonValue           = p.objectForKey("IRR")            as? Double
                            let Direction_JsonValue     = p.objectForKey("Direction")      as? String
                            let Type_JsonValue          = p.objectForKey("Type")           as? String
                            let PPID_JsonValue          = p.objectForKey("PPID")           as? String
                            let ImageCount_JsonValue    = p.objectForKey("ImageCount")     as? Int
                            let Date_JsonValue          = p.objectForKey("Date")           as? String
                            
//                            print("===========")
//                            print(Title_JsonValue)
//                            print(PPID_JsonValue!)
                            self.titleArray.append(Title_JsonValue!)
                            self.locationArray.append(Location_JsonValue!)
                            self.sizeArray.append(Size_JsonValue!)
                            self.priceOfRent1YArray.append(PriceOfRent1Y_JsonValue!)
                            self.iRRArray.append(IRR_JsonValue!)
                            self.directionArray.append(Direction_JsonValue!)
                            self.typeArray.append(Type_JsonValue!)
                            self.ppidArray.append(PPID_JsonValue!)
                            self.imageCountArray.append(ImageCount_JsonValue!)
                            self.dateArray.append(Date_JsonValue!)
                            self.isCaseShown.append(false)
                            
                            //NSLog("%@(%d)/TEL(O):%@, TEL(H):%@", name, age, tel_o, tel_h);
                        }
//                        print(self.ppidArray)
//                        print(self.titleArray)
                        
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            self.rentTableView.reloadData() // reload data
                            self.refreshControl.endRefreshing()
                        });

                    }
                }//End of Alamofire
        
     
        
    }

    
    //MARK: - Setting Rent TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return ppidArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("rentCell", forIndexPath: indexPath) as! RentTableCellTableViewCell

        let imageID = ppidArray[indexPath.row]
        
        
        /* LOAD IMAGE DISPATH ASYNC */
        cell.spinner?.startAnimating()
        let PvWebsiteUrlPart = "http://www.pvmarket.com.tw/RPic/"
        let filename:String = String(format: imageID+"-1.jpg");
        let imageUrlString = pvWebsiteUrlPart.rentURL + filename
        //NSURL(string: "http://m102.nthu.edu.tw/~s102021607/girl.png")
        
        //set image as same time set imageView
        var image: UIImage? {
            get { return cell.rentImageView.image }
            set {
                cell.rentImageView.image = newValue  //cell image
                cell.rentImageView.clipsToBounds = true  //cell image clip
                cell.spinner?.stopAnimating()
                //NSLog("**** cell.rentImageView.image set *****")
                
            }
        }
        
        let imageURL: NSURL? = NSURL(string: imageUrlString)
        
        if let url = imageURL {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)//QOS_CLASS_USER_INITIATED.value
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: url) // this blocks the thread it is on
                /*Back to main q*/
                dispatch_async(dispatch_get_main_queue()) {
                    if imageData != nil {
                        //NSLog("===== imageData != nil  =====")
                        image = UIImage(data: imageData!) //set image ,then set subview in scrollview
                    } else {
                        image = nil
                    }
                }
            }
        }
        
        /* End of LOAD IMAGE DISPATH ASYNC */
        
        
        cell.rentTitleLable.text = titleArray[indexPath.row]                                  // EX:"彰化芳苑 養鴨場大屋頂"
        cell.rentLocationBtn.setTitle(locationArray[indexPath.row], forState: .Normal)        // EX:"彰化"
        cell.rentDirectionBtn.setTitle(directionArray[indexPath.row]+"向", forState: .Normal) //  EX: "東西"
        cell.rentSizeBtn.setTitle("\(sizeArray[indexPath.row])坪", forState: .Normal)         // EX: "110坪"
        
  
        //buttome with corner radius
        cell.rentSizeBtn.layer.cornerRadius      = 15
        cell.rentLocationBtn.layer.cornerRadius  = 15
        cell.rentDirectionBtn.layer.cornerRadius = 15
        
        //cell corner radius
//        cell.layer.cornerRadius=20 //set corner radius here
//        cell.layer.borderColor = UIColor.blackColor().CGColor  // set cell border color here
//        cell.layer.borderWidth = 2 // set border width here
        return cell
    }
    
    
    
    //MARK: - Animation Table View Cell
    //https://www.youtube.com/watch?v=08eurHsO83w
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
            // check case is or not shown
            if isCaseShown[indexPath.row] == false {
                // case is not face/move in
                //setting para
                cell.alpha = 0
                let rotationTransforms = CATransform3DTranslate(CATransform3DIdentity, -600, 10, 0)
                cell.layer.transform = rotationTransforms
                
                //setting animation
                UIView.animateWithDuration(1.0) {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }
                
                //mark case is already shown
                isCaseShown[indexPath.row] = true
            
            }
        
        }
    
    
    
    //MARK: - Segue To Detail as Cell tap
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "rentDetailSegue" {  //check segue
            if let destination = segue.destinationViewController as? RentTableDetailViewController { //check destinationVC
                if let indexPath = self.rentTableView.indexPathForCell(sender as! UITableViewCell){ //get indexPath

                    //model for segue to Detail
                    destination.viaTitle         = titleArray[indexPath.row]
                    destination.viaLocation      = locationArray[indexPath.row]
                    destination.viaSize          = sizeArray[indexPath.row]
                    destination.viaPriceOfRent1Y = priceOfRent1YArray[indexPath.row]
                    destination.viaIRR           = iRRArray[indexPath.row]
                    destination.viaDirection     = directionArray[indexPath.row]
                    destination.viaType          = typeArray[indexPath.row]
                    destination.viaPPID          = ppidArray[indexPath.row]
                    destination.viaImageCount    = imageCountArray[indexPath.row]
                    destination.viaDate          = dateArray[indexPath.row]
                    destination.viaImageID       = ppidArray[indexPath.row]
  
                    
                }
                
              }
        }
    }
    
    


}
