//
//  RentData.swift
//  PVMARKET
//
//  Created by open open on 2016/5/25.
//  Copyright (c) 2016年 openopen. All rights reserved.
//

import Foundation

class RentData {
    
    var Title = ""
    var Location = ""
    var Direction = ""
    var Size = 0
    var PPID = ""
    var ImageCount = 0
    var Date = ""
    var Type = ""
    
    
    
    init(Title: String, Location: String, Direction: String , Size: Int, PPID: String, ImageCount:Int, Date: String, Type: String) {
        
        self.Title = Title
        self.Location = Location
        self.Direction = Direction
        self.Size = Size
        self.PPID = PPID
        self.ImageCount = ImageCount
        self.Date = Date
        self.Type = Type
    }
}