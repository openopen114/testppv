//
//  HomeViewController.swift
//  PVMARKET
//
//  Created by open open on 2016/5/23.
//  Copyright (c) 2016年 openopen. All rights reserved.
//

import UIKit
import MessageUI

class HomeViewController: UIViewController, MFMailComposeViewControllerDelegate ,UIPopoverPresentationControllerDelegate{

    //MARK: - @IBOutlet
    
    @IBOutlet weak var rentBtn: UIButton! //屋頂出租
    @IBOutlet weak var saleBtn: UIButton! //電廠出售
    @IBOutlet weak var selfBtn: UIButton! //電廠自建
    @IBOutlet weak var calcBtn: UIButton! //投資試算
    
    @IBOutlet weak var rentArrowBtn: UIButton! //屋頂出租箭頭
    @IBOutlet weak var saleArrowBtn: UIButton! //電廠出售箭頭
    @IBOutlet weak var selfArrowBtn: UIButton! //電廠自建箭頭
    @IBOutlet weak var calcArrowBtn: UIButton! //投資試算箭頭

    @IBOutlet weak var rentSpaceBtn: UIButton! //屋頂出租空白
    @IBOutlet weak var saleSpaceBtn: UIButton! //電廠出售空白
    @IBOutlet weak var selfSpaceBtn: UIButton! //電廠自建空白
    @IBOutlet weak var calcSpaceBtn: UIButton! //投資試算空白
    
    
    //contact icon button
    @IBOutlet weak internal var lineIconBtn: UIButton!     //Line
    @IBOutlet weak internal var facebookIconBtn: UIButton! //FB
    @IBOutlet weak internal var phoneIconBtn: UIButton!    //Phone
    @IBOutlet weak internal var mailIconBtn: UIButton!     //Mail
    @IBOutlet weak internal var addressIconBtn: UIButton!  //Address
    
    @IBOutlet weak var lineSpaceBtn: UIButton!     //Line
    @IBOutlet weak var facebookSpaceBtn: UIButton! //FB
    @IBOutlet weak var phoneSpaceBtn: UIButton!    //Phone
    @IBOutlet weak var mailSpaceBtn: UIButton!     //Mail
    @IBOutlet weak var addressSpaceBtn: UIButton!  //Address
    
    
    var alertController: UIAlertController!
    
    
    
    override func viewWillAppear(animated: Bool) {
        // reset the color alpha to zero for tapgesture/click as turn back to Home page
        self.rentSpaceBtn.alpha = 1
        self.saleSpaceBtn.alpha = 1
        self.selfSpaceBtn.alpha = 1
        self.calcSpaceBtn.alpha = 1
        self.rentSpaceBtn.backgroundColor = nil
        self.saleSpaceBtn.backgroundColor = nil
        self.selfSpaceBtn.backgroundColor = nil
        self.calcSpaceBtn.backgroundColor = nil
        //        NSLog("Home viewWillAppear ======")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: -  tapGesture for view
        let tapGestureRentView = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.goToTab(_:)))
        tapGestureRentView.accessibilityValue = "goToRent"  // hint for switch
        rentSpaceBtn.addGestureRecognizer(tapGestureRentView)
        
        let tapGestureSaleView = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.goToTab(_:)))
        tapGestureSaleView.accessibilityValue = "goToSale"
        saleSpaceBtn.addGestureRecognizer(tapGestureSaleView)

        let tapGestureSelfView = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.goToTab(_:)))
        tapGestureSelfView.accessibilityValue = "goToSelf"
        selfSpaceBtn.addGestureRecognizer(tapGestureSelfView)
        
        let tapGestureCalcView = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.goToTab(_:)))
        tapGestureCalcView.accessibilityValue = "goToCalc"
        calcSpaceBtn.addGestureRecognizer(tapGestureCalcView)
        
        
        
        //MARK: - ActionSheet
        alertController = UIAlertController(title: "聯繫我們", message: "您可以經由下列方式與我們聯繫", preferredStyle: .ActionSheet)
        //Line
        let lineAction = UIAlertAction(title: "Line", style: UIAlertActionStyle.Default) { (action) in
            let lineURL: NSURL = NSURL(string:"http://line.me/ti/p/-TDM2cfzlK")!
            UIApplication.sharedApplication().openURL(lineURL)
        }
        //FaceBook
        let facebookAction = UIAlertAction(title: "facebook", style: UIAlertActionStyle.Default) { (action) in
            //https://www.youtube.com/watch?v=cut36z2qWRk
            let fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/pvmarket.tw/")!
            let fbURLID: NSURL = NSURL(string: "fb://profile/1667301026884646")!
            
            if(UIApplication.sharedApplication().canOpenURL(fbURLID)){
                UIApplication.sharedApplication().openURL(fbURLID)
            }else{
                UIApplication.sharedApplication().openURL(fbURLWeb)
            }

        }
        
        //Mail
        let mailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default) { (action) in
            let SubjectText = "SubjectText"
            let MessageBody = "MessageBody"
            let toRecipients = ["openopen114@gmail.com"]
            
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setToRecipients(toRecipients)
            mc.setSubject(SubjectText)
            mc.setMessageBody(MessageBody, isHTML: false)
            
            if MFMailComposeViewController.canSendMail(){
                self.presentViewController(mc, animated: true, completion: nil)
            }
        }

        
        //Phone Call
        let phoneCallAction = UIAlertAction(title: "免付費客服電話", style: UIAlertActionStyle.Default) { (action) in
                let pnoneURL: NSURL = NSURL(string:"tel://0800255188")!
                UIApplication.sharedApplication().openURL(pnoneURL)
                NSLog("phoneCallAction****-----")

        }
        
        
        //GoogleMap
        //Mail
        let addressAction = UIAlertAction(title: "地址", style: UIAlertActionStyle.Default) { (action) in
            //open google map
            if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
                UIApplication.sharedApplication().openURL(NSURL(string:
                    "comgooglemaps://?center=23.463728,120.226767&zoom=14")!)
            } else {
                print("Can't use comgooglemaps://");
            }

        }
        
        //Cancal ActionSheet
        let cancalAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) in
            NSLog("cancalAction****-----")
        }
        alertController.addAction(lineAction)
        alertController.addAction(facebookAction)
        alertController.addAction(phoneCallAction)
        alertController.addAction(mailAction)
        alertController.addAction(addressAction)
        alertController.addAction(cancalAction)
    }
    
    
    func goToTab(tapGesture: UITapGestureRecognizer){
        print(tapGesture.accessibilityValue)
        print(tabBarController?.selectedIndex)
        
        switch tapGesture.accessibilityValue! {
        case "goToRent" : tabBarController?.selectedIndex = 1
                            rentSpaceBtn.alpha = 0.8
                            rentSpaceBtn.backgroundColor = UIColor.whiteColor()
        case "goToSale" : tabBarController?.selectedIndex = 2
                            saleSpaceBtn.alpha = 0.8
                            saleSpaceBtn.backgroundColor = UIColor.whiteColor()
        case "goToSelf" : tabBarController?.selectedIndex = 3
                            selfSpaceBtn.alpha = 0.8
                            selfSpaceBtn.backgroundColor = UIColor.whiteColor()
        case "goToCalc" : tabBarController?.selectedIndex = 4
                            calcSpaceBtn.alpha = 0.8
                            calcSpaceBtn.backgroundColor = UIColor.whiteColor()
        default:print("tpa Gesture GG 0.0 ")
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - Contact Us Btn function ActionSheep , Pop0ver
    @IBAction func contactActionSheetBtn(sender: UIButton) {
        //currentPopoverpresentioncontroller.sourceView
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad )
        {
            if let currentPopoverpresentioncontroller = alertController.popoverPresentationController{
                currentPopoverpresentioncontroller.sourceView  = sender as UIView
                currentPopoverpresentioncontroller.sourceRect = (sender as UIView).bounds
                currentPopoverpresentioncontroller.permittedArrowDirections = UIPopoverArrowDirection.Any
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }else{
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            NSLog("Mail Canvelled")
        case MFMailComposeResultSaved.rawValue:
            NSLog("Mail Saved")
        case MFMailComposeResultSent.rawValue:
            NSLog("Mail Sent")
        case MFMailComposeResultFailed.rawValue:
            NSLog("Mail Failed")
        default:break
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
 
}
