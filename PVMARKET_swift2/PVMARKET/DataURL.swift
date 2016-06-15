//
//  DataURL.swift
//  PVMARKET
//
//  Created by Ｃhun-Ying on 2016/6/13.
//  Copyright © 2016年 openopen. All rights reserved.
//

import Foundation


struct dataJsonURL{
    var rentJsonURL: String = "http://m102.nthu.edu.tw/~s102021607/rentJson001.json"//rent JSON DATA URL
    var saleJsonURL: String = "http://m102.nthu.edu.tw/~s102021607/saleJson001.json"//sale JSON DATA URL
    var selfJsonURL: String = "http://m102.nthu.edu.tw/~s102021607/rentJson003.json"//self JSON DATA URL
}


struct PvWebsiteUrlPart {
    var rentURL:String = "http://www.pvmarket.com.tw/RPic/"
    var saleURL:String = "http://www.pvmarket.com.tw/Pic/"
    var selfURL:String = ""
    
}




var dataURL = dataJsonURL()