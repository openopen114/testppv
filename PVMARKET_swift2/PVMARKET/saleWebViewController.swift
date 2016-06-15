//
//  saleWebViewController.swift
//  PVMARKET
//
//  Created by Ｃhun-Ying on 2016/6/15.
//  Copyright © 2016年 openopen. All rights reserved.
//

import UIKit

class saleWebViewController: UIViewController {

    
    var viaWebViewURL: String = ""

    
    @IBOutlet weak var monitorSysWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog(viaWebViewURL)
        let url = NSURL(string: viaWebViewURL)
        let request = NSURLRequest(URL: url!)
        self.monitorSysWebView.loadRequest(request)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
