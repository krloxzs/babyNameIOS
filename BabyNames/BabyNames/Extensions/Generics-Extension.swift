//
//  Generics-Extension.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 19/05/16.
//  Copyright © 2016 Nutriwen. All rights reserved.
//


import Foundation

extension NSObject {
    var theClassName: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

extension String {
    
    /// Validate if the string contain a valid email address
    var isValidEmail: Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Validate if string is a number.
    var isNumber: Bool {
        if let _ = Int(self) {
            return true
        }
        return false
    }
    
}
