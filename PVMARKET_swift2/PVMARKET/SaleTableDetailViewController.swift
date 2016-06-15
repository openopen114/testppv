//
//  SaleTableDetailViewController.swift
//  PVMARKET
//
//  Created by Ｃhun-Ying on 2016/6/13.
//  Copyright © 2016年 openopen. All rights reserved.
//

import UIKit

class SaleTableDetailViewController: UIViewController,UIScrollViewDelegate  {
    //Model Data
    //get data from RentTableVC
    
    var viaTitle: String       = ""  // Title
    var viaLocation: String    = ""  // Loaction
    var viakWp: Double            = 0   // kWp
    var viaDateOprateYears: String  = ""  // time of Oprated
    var viaPriceOfkWh: Double  = 0.1 // price of kWh
    var viaPriceOfSale: Int    = 0   // Price Of sale
    var viaPriceOfRent1Y: Int  = 0   // Price Of Rent1Y
    var viaIRR: Double         = 0.1 // IRR
    var viaType: String        = ""  // Type
    
    var viaMonitorSysURL: String = ""// Monitoring System
    
    var viaModule: String      = ""  // MOdule
    var viaInv: String         = ""  // Inv
    var viaEPC: String         = ""  // EPC
    var viaMaintain: String    = ""  // maintain
    var viaPPID: String        = ""  // PPID
    var viaImageCount: Int     = 0   // num of image
    var viaDatePO: String      = ""  // Date PO
    var viaImageID: String     = ""  // PPID for image gallery
    
    
    let convfuncs = convertFunctions()
    let pvWebsiteUrlPart  = PvWebsiteUrlPart()
    
    //Outlet
    @IBOutlet weak var galleryScrollView: UIScrollView!  //scroll view
    @IBOutlet weak var galleryPageControl: UIPageControl! //page dot
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var kWpLabel: UILabel!
    @IBOutlet weak var dateOprateYearsLabel: UILabel!
    @IBOutlet weak var priceOfkWhLabel: UILabel!
    @IBOutlet weak var priceOfSaleLabel: UILabel!
    @IBOutlet weak var priceOfRent1YLabel: UILabel!
    @IBOutlet weak var iRRLabel: UILabel!

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var moduleLabel: UILabel!
    @IBOutlet weak var invLabel: UILabel!
    @IBOutlet weak var EPCLabel: UILabel!
    @IBOutlet weak var maintainLabel: UILabel!
    @IBOutlet weak var pPIDLabel: UILabel!
    @IBOutlet weak var datePOLabel: UILabel!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    
    @IBAction func monitorSysBtn(sender: UIButton) {
    }
    
    
    var timer:NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pictureGallery()
     
        self.titleLabel.text           = viaTitle
        self.locationLabel.text        = viaLocation
        self.kWpLabel.text             = "\(viakWp)kWp"
        self.dateOprateYearsLabel.text = viaDateOprateYears
        self.priceOfkWhLabel.text      = "\(viaPriceOfkWh)元"
        self.priceOfSaleLabel.text     = "\(convfuncs.numberTocurrency(viaPriceOfSale))元"
        self.priceOfRent1YLabel.text   = "\(convfuncs.numberTocurrency(viaPriceOfRent1Y))元"
        self.iRRLabel.text             = "\(viaIRR)%"
        self.typeLabel.text            = viaType
        self.moduleLabel.text          = viaModule
        self.invLabel.text             = viaInv
        self.EPCLabel.text             = viaEPC
        self.maintainLabel.text        = viaMaintain
        self.pPIDLabel.text            = viaPPID
        self.datePOLabel.text          = viaDatePO

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pictureGallery(){   //实现图片滚动播放；
        
        let screenSize:CGSize = UIScreen.mainScreen().bounds.size
        let imageW:CGFloat = screenSize.width
        let imageH:CGFloat = self.galleryScrollView.frame.size.height
        var imageY:CGFloat = 0;//图片的Y坐标就在ScrollView的顶端；
        var totalCount:NSInteger = viaImageCount;//轮播的图片数量；
        
        for index in 0..<totalCount{
            var imageView:UIImageView = UIImageView();
            //set image as same time set imageView
            var image: UIImage? {
                get { return imageView.image }
                set {
                    imageView.image = newValue
                    self.galleryScrollView.showsHorizontalScrollIndicator = false;//不设置水平滚动条；
                    self.galleryScrollView.addSubview(imageView);//把图片加入到ScrollView中去，实现轮播的效果；
                    //                    spinner?.stopAnimating()
                    spinner?.stopAnimating()
                }
            }
            
            let imageX:CGFloat = CGFloat(index) * imageW;
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);//设置图片的大小，注意Image和ScrollView的关系，其实几张图片是按顺序从左向右依次放置在ScrollView中的，但是ScrollView在界面中显示的只是一张图片的大小，效果类似与画廊；
            let name:String = String(format: viaImageID+"-%d.jpg", index+1);
            imageView.image = UIImage(named: name);
            
            
            
            /* LOAD IMAGE DISPATH ASYNC */
            spinner?.startAnimating()
//            let PvWebsiteUrlPart = "http://www.pvmarket.com.tw/Pic/"
            let filename:String = String(format: viaImageID+"-%d.jpg", index+1);
            let imageUrlString = pvWebsiteUrlPart.saleURL + filename
            //NSURL(string: "http://m102.nthu.edu.tw/~s102021607/girl.png")
            
            let imageURL: NSURL? = NSURL(string: imageUrlString)
            if let url = imageURL {
                let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)//QOS_CLASS_USER_INITIATED.value
                dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                    let imageData = NSData(contentsOfURL: url) // this blocks the thread it is on
                    /*Back to main q*/
                    dispatch_async(dispatch_get_main_queue()) {
                        // only do something with this image
                        // if the url we fetched is the current imageURL we want
                        // (that might have changed while we were off fetching this one)
                        // the variable "url" is capture from above
                        if imageData != nil {
                            // this might be a waste of time if our MVC is out of action now
                            // which it might be if someone hit the Back button
                            // or otherwise removed us from split view or navigation controller
                            // while we were off fetching the image
                            image = UIImage(data: imageData!) //set image ,then set subview in scrollview
                        } else {
                            image = nil
                        }
                    }
                }
            }
            
            /* end of LOAD IMAGE DISPATH ASYNC */
        } //end of for loop
        
        //需要非常注意的是：ScrollView控件一定要设置contentSize;包括长和宽；
        let contentW:CGFloat = imageW * CGFloat(totalCount);//这里的宽度就是所有的图片宽度之和；
        self.galleryScrollView.contentSize = CGSizeMake(contentW, 0);
        self.galleryScrollView.pagingEnabled = true;
        self.galleryScrollView.delegate = self;
        self.galleryPageControl.numberOfPages = totalCount;//下面的页码提示器；
        //        self.addTimer()
        
    }
    
    
    //    func nextImage(sender:AnyObject!){//图片轮播；
    //        var page:Int = self.galleryPageControl.currentPage;
    //        if(page == 4){   //循环；
    //            page = 0;
    //        }else{
    //            page++;
    //        }
    //        let x:CGFloat = CGFloat(page) * self.galleryScrollView.frame.size.width;
    //        self.galleryScrollView.contentOffset = CGPointMake(x, 0);//注意：contentOffset就是设置ScrollView的偏移；
    //    }
    //
    //UIScrollViewDelegate中重写的方法；
    //处理所有ScrollView的滚动之后的事件，注意 不是执行滚动的事件；
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //这里的代码是在ScrollView滚动后执行的操作，并不是执行ScrollView的代码；
        //这里只是为了设置下面的页码提示器；该操作是在图片滚动之后操作的；
        let scrollviewW:CGFloat = galleryScrollView.frame.size.width;
        let x:CGFloat = galleryScrollView.contentOffset.x;
        let page:Int = (Int)((x + scrollviewW / 2) / scrollviewW);
        self.galleryPageControl.currentPage = page;
        
    }
    
    //MARK: - Segue To Monitor System Web View
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "monitoeSysWebView" {
            if let destination = segue.destinationViewController as? saleWebViewController{
                destination.viaWebViewURL = viaMonitorSysURL
            }
        
        }

    }
    
    
    //    func addTimer(){   //图片轮播的定时器；
    //        self.timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "nextImage:", userInfo: nil, repeats: true);
    //    }
    

}
