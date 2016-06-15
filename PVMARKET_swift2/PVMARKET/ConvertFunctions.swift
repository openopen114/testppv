//
//  ConvertFunctions.swift
//  PVMARKET
//
//  Created by Ｃhun-Ying on 2016/6/14.
//  Copyright © 2016年 openopen. All rights reserved.
//

import Foundation

public class convertFunctions{
    
    // calculator years of operated time
    func yearsOfOperated(dateStr: String) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateStrFormat = dateFormatter.dateFromString(dateStr)
        let yearOfOperated = (dateStrFormat?.timeIntervalSinceNow)!/(-60*60*24*365) //calc years
        let yearOfOperatedString = NSString(format:"%.1f年", yearOfOperated) as String
        
        return yearOfOperatedString
    }
    
    
    //number to currency formatter http://nshipster.com/nsformatter/
    func numberTocurrency(num: Int) -> String{
        let formatter = NSNumberFormatter()
//        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
//        formatter.locale = NSLocale(localeIdentifier:"en_US")
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        let currencyStr:String = formatter.stringFromNumber(num)! as String
        return currencyStr
    }
    
    
    
    // 單位: 萬
    func convertUnit2TenThousand(num: Int) -> Double{
        let a: Double = Double(num)/1000
        let b: Double = floor(a + 0.5) / 10
        return b
    }
    
}

