//
//  Formatter.swift
//  Junger
//
//  Created by Moy Hdez on 16/11/16.
//  Copyright © 2016 Tejuino developers. All rights reserved.
//

import Foundation

class Formatter: NSObject {
    
    private override init(){
        
    }
    
//    func formatNumber(number: Int)->String {
//     
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 0
//        formatter.locale = Locale(identifier: "es_MX")
//        
//        return formatter.string(from: <#T##NSNumber#>)
//        
//    }
    
    func formatDate(stringDate: String, format: String)->String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: stringDate)
        dateFormatter.dateFormat = format

        if let formatDate = date{
            return dateFormatter.string(from: formatDate)
        }
        
        print("ERROR al formatear la fecha")
        return stringDate
        
    }
    
    func stringToDate(stringDate: String, format: String)->Date{
        
        let dateFormatter:DateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "es_MX")
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = stringDate
        
        return dateFormatter.date(from: dateString)!
        
    }

    func formatDate(date: Date, format: String) -> String {
        
        let dateFormatter:DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
        
    }
    
}
