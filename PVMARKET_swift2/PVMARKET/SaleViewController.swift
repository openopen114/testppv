//
//  SaleViewController.swift
//  PVMARKET
//
//  Created by open open on 2016/5/23.
//  Copyright (c) 2016年 openopen. All rights reserved.
//

import UIKit
import Alamofire


class SaleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,NSURLSessionDataDelegate,NSURLSessionDelegate {

    
    //MARK: - Model Data Array
    var titleArray         = [String]()  //EX:"彰化芳苑 養鴨場10棟大屋頂"
    var locationArray      = [String]()  //EX:"彰化"
    var kWpArray           = [Double]()  //EX:123
    var priceOfkWhArray    = [Double]()  //EX:6.6721
    var priceOfSaleArray   = [Int]()     //EX:479918
    var priceOfRent1YArray = [Int]()     //EX:4133
    var directionArray     = [String]()  //EX:"東西"
    var typeArray          = [String]()  //EX:"G舍"
    var datePOArray        = [String]()  //EX:"2016/01/01"
    var dateOperateArray   = [String]()  //EX:"2012/01/01"
    var imageCountArray    = [Int]()     //EX:5 (num of image)
    var ppidArray          = [String]()  //EX:"CH10504001"
    var iRRArray           = [Double]()  //EX:8.53
    var moduleArray        = [String]()  //EX:"新日光"
    var invArray           = [String]()  //EX:"有答"
    var struckArray        = [String]()  //EX:"呂支架"
    var EPCArray           = [String]()  //EX:"向陽"
    var maintainArray      = [String]()  //EX:"向陽"
    var operateStatusArray = [String]()  //EX:"asp / http"
    var operateYearsArray  = [String]()  //EX:12.3 (年)
    
    var isCaseShown = [Bool]() //for animation shown mark
    let refreshControl = UIRefreshControl()
    
    
    let convfuncs = convertFunctions()
    let pvWebsiteUrlPart  = PvWebsiteUrlPart()
    
    
    // outlet items
    @IBOutlet weak var saleTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData(dataURL.saleJsonURL) // download json data by url
        NSLog("dataURL.saleJsonURL:"+dataURL.saleJsonURL)
        //添加刷新
        refreshControl.addTarget(self, action: #selector(SaleViewController.refreshData), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "刷新資料")
        saleTableView.addSubview(refreshControl)
    }
    
    // 刷新数据
    func refreshData() {
        getJsonData(dataURL.saleJsonURL) // download json data by url
    }
    
  

    
    
    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
    
    //MARK: - GET JSON
    func getJsonData(urlString: String){
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        // empty/clear data array for reload/reassign data from json file
        self.titleArray         = [String]()  //EX:"彰化芳苑 養鴨場10棟大屋頂"
        self.locationArray      = [String]()  //EX:"彰化"
        self.kWpArray           = [Double]()  //EX:123
        self.priceOfkWhArray    = [Double]()  //EX:6.6721
        self.priceOfSaleArray   = [Int]()     //EX:479918
        self.priceOfRent1YArray = [Int]()     //EX:4133
        self.directionArray     = [String]()  //EX:"東西"
        self.typeArray          = [String]()  //EX:"G舍"
        self.datePOArray        = [String]()  //EX:"2016/01/01"
        self.dateOperateArray   = [String]()  //EX:"2012/01/01"
        self.imageCountArray    = [Int]()     //EX:5 (num of image)
        self.ppidArray          = [String]()  //EX:"CH10504001"
        self.iRRArray           = [Double]()  //EX:8.53
        self.moduleArray        = [String]()  //EX:"新日光"
        self.invArray           = [String]()  //EX:"有答"
        self.struckArray        = [String]()  //EX:"呂支架"
        self.EPCArray           = [String]()  //EX:"向陽"
        self.maintainArray      = [String]()  //EX:"向陽"
        self.operateStatusArray = [String]()  //EX:"asp / http"
        self.operateYearsArray  = [String]()  //EX:12.3 (年)
        self.isCaseShown = [Bool]() //for animation shown mark
        
//        let URL = NSURL(string: urlString)!
//        let URLRequest = NSMutableURLRequest(URL: URL)
//        URLRequest.cachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
//        let URL = NSURL(string: urlString)!
//        let mutableURLRequest = NSMutableURLRequest(URL: URL)
//        mutableURLRequest.HTTPMethod = "GET"
//                mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        mutableURLRequest.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
//        Alamofire.Manager.sharedInstance.session.configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
//        let URLRequest = NSMutableURLRequest(URL: NSURL(string: urlString)!)
//        URLRequest.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        
        Alamofire.request(.GET,urlString).validate().responseJSON { (response) in
            if let JSON = response.result.value{
                let jsonObj = JSON as! NSArray
                for p in jsonObj {
                    let Title_JsonValue         = p.objectForKey("Title")          as? String
                    let Location_JsonValue      = p.objectForKey("Location")       as? String
                    let kWp_JsonValue           = p.objectForKey("kWp")            as? Double
                    let PriceOfkWh_JsonValue    = p.objectForKey("PriceOfkWh")     as? Double
                    let PriceOfSale_JsonValue   = p.objectForKey("PriceOfSale")    as? Int
                    let PriceOfRent1Y_JsonValue = p.objectForKey("PriceOfRent1Y")  as? Int
                    let Direction_JsonValue     = p.objectForKey("Direction")      as? String
                    let Type_JsonValue          = p.objectForKey("Type")           as? String
                    let DatePO_JsonValue        = p.objectForKey("DatePO")         as? String
                    let DateOperate_JsonValue   = p.objectForKey("DateOperate")    as? String
                    let ImageCount_JsonValue    = p.objectForKey("ImageCount")     as? Int
                    let PPID_JsonValue          = p.objectForKey("PPID")           as? String
                    let IRR_JsonValue           = p.objectForKey("IRR")            as? Double
                    let Module_JsonValue        = p.objectForKey("Module")         as? String
                    let Inv_JsonValue           = p.objectForKey("Inv")            as? String
                    let Struck_JsonValue        = p.objectForKey("Struck")         as? String
                    let EPC_JsonValue           = p.objectForKey("EPC")            as? String
                    let Maintain_JsonValue      = p.objectForKey("Maintain")       as? String
                    let OPerateStatus_JsonValue = p.objectForKey("OPerateStatus")  as? String
                    let yearsOfOperated  = self.convfuncs.yearsOfOperated(DateOperate_JsonValue!)

                    
                    self.titleArray.append(Title_JsonValue!)
                    self.locationArray.append(Location_JsonValue!)
                    self.kWpArray.append(kWp_JsonValue!)
                    self.priceOfkWhArray.append(PriceOfkWh_JsonValue!)
                    self.priceOfSaleArray.append(PriceOfSale_JsonValue!)
                    self.priceOfRent1YArray.append(PriceOfRent1Y_JsonValue!)
                    self.directionArray.append(Direction_JsonValue!)
                    self.typeArray.append(Type_JsonValue!)
                    self.datePOArray.append(DatePO_JsonValue!)
                    self.dateOperateArray.append(DateOperate_JsonValue!)
                    self.imageCountArray.append(ImageCount_JsonValue!)
                    self.ppidArray.append(PPID_JsonValue!)
                    self.iRRArray.append(IRR_JsonValue!)
                    self.moduleArray.append(Module_JsonValue!)
                    self.invArray.append(Inv_JsonValue!)
                    self.struckArray.append(Struck_JsonValue!)
                    self.EPCArray.append(EPC_JsonValue!)
                    self.maintainArray.append(Maintain_JsonValue!)
                    self.operateStatusArray.append(OPerateStatus_JsonValue!)
                    self.operateYearsArray.append(yearsOfOperated)
                    self.isCaseShown.append(false)
                    self.saleTableView.reloadData() // reload data
                }
  
                dispatch_async(dispatch_get_main_queue(),{
                    self.saleTableView.reloadData() // reload data
                    self.refreshControl.endRefreshing()
                    
                });
                
            }
        }
        
        
        
    }
    
    
    //MARK: - Setting Rent TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ppidArray.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("saleCell", forIndexPath: indexPath) as! SaleTableCellTableViewCell
        
        let imageID = ppidArray[indexPath.row]
        
        
        /* LOAD IMAGE DISPATH ASYNC */
        cell.spinner?.startAnimating()
        let filename:String = String(format: imageID+"-1.jpg");
        let imageUrlString = pvWebsiteUrlPart.saleURL + filename
        //NSURL(string: "http://m102.nthu.edu.tw/~s102021607/girl.png")
        
        var image: UIImage? {
            get { return cell.saleImageView.image }
            set {
                cell.saleImageView.image = newValue  //cell image
                cell.saleImageView.clipsToBounds = true  //cell image clip
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
                        image = UIImage(data: imageData!) //set image
                    } else {
                        image = nil
                    }
                }
            }
        }
        
        /* End of LOAD IMAGE DISPATH ASYNC */
        
        
        cell.saleTitleLable.text = titleArray[indexPath.row]                                  // EX:"彰化芳苑 養鴨場大屋頂"
        cell.saleLocationBtn.setTitle(locationArray[indexPath.row], forState: .Normal)        // EX:"彰化"
        
        cell.salekWpLabel.text = "\(kWpArray[indexPath.row])kWp"
        
//        cell.priceOfSaleLabel.text = "\(priceOfSaleArray[indexPath.row])元"
        let temp_priceOfSale: Double = convfuncs.convertUnit2TenThousand(priceOfSaleArray[indexPath.row])
        if(temp_priceOfSale * 10 % 10 == 0.0){
            // 小數點後一位 = 0 , 去小數
            cell.priceOfSaleLabel.text = "\(Int(temp_priceOfSale))萬元"
        }else{
            cell.priceOfSaleLabel.text = "\(temp_priceOfSale)萬元"
        }
        

        cell.saleYearOfOperated.text = operateYearsArray[indexPath.row]
        cell.saleDirectionLabel.text = directionArray[indexPath.row]+"向"


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
        if segue.identifier == "saleDetailSegue" {  //check segue

            if let destination = segue.destinationViewController as? SaleTableDetailViewController { //check destinationVC
                if let indexPath = self.saleTableView.indexPathForCell(sender as! UITableViewCell){ //get indexPath
                    //model for segue to Detail
                    destination.viaTitle            = titleArray[indexPath.row]
                    destination.viaLocation         = locationArray[indexPath.row]
                    destination.viakWp              = kWpArray[indexPath.row]
                    destination.viaDateOprateYears  = dateOperateArray[indexPath.row]
                    destination.viaPriceOfkWh       = priceOfkWhArray[indexPath.row]
                    destination.viaPriceOfSale      = priceOfSaleArray[indexPath.row]
                    destination.viaPriceOfRent1Y    = priceOfRent1YArray[indexPath.row]
                    destination.viaIRR              = iRRArray[indexPath.row]
                    destination.viaType             = typeArray[indexPath.row]
                    destination.viaModule           = moduleArray[indexPath.row]
                    destination.viaInv              = invArray[indexPath.row]
                    destination.viaEPC              = EPCArray[indexPath.row]
                    destination.viaMaintain         = maintainArray[indexPath.row]
                    destination.viaMonitorSysURL    = operateStatusArray[indexPath.row]
                    destination.viaPPID             = ppidArray[indexPath.row]
                    destination.viaImageCount       = imageCountArray[indexPath.row]
                    destination.viaDatePO           = datePOArray[indexPath.row]
                    destination.viaImageID          = ppidArray[indexPath.row]
 
                }
                
            }
        }
    }
    
    


}
