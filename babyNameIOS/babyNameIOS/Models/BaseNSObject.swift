//
//  BaseNSObject.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 19/05/16.

//
import Foundation
import SwiftyJSON

class BaseNSObject: NSObject {
    
    /// Reserver words in swift using NSObject
    let reserver_words:Set<String> = ["hash","description"]
    
    /**
     Synchroinze this object using NSUserDetaults
     
     - parameter key: Unique value to store information
     
     - returns: Self
     */
    @discardableResult
    func synchronizeObject(_ key: String) -> Self {
        
        if self.isKind(of: NSObject.self) {
            let archived = NSKeyedArchiver.archivedData(withRootObject: self as AnyObject)
            let defaults = UserDefaults.standard
            defaults.set(archived, forKey: key)
            defaults.synchronize()
        }
        
        return self
    }
    
    /**
     Remove the key from current NSUserDefault
     
     - parameter key: key associated to NSUserDefault Object
     
     - returns: Self
     */
    func deleteObjectKey(_ key: String) -> Self {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
        
        return self
    }
    
    /**
     Save value based on JSON object and associated to key.
     
     - parameter value:  JSON Object from SwiftyJSON library
     - parameter forKey: string key
     */
    func setObjectValue(_ value: JSON, forKey: String) {
        
        // If property exists
        if (self.responds(to: NSSelectorFromString(forKey))) {
            
            if !value.stringValue.isEmpty {
                if !reserver_words.contains(forKey) {
                    self.setValue(value.stringValue, forKey: forKey)
                }else {
                    self.setValue(value.stringValue, forKey: "\(forKey)_string")
                }
            }
            
        }
        
    }
    
    func constructRootProperties(_ JSONObject: JSON) -> Self {
        
        // Loop
        for (key, value) in JSONObject {
            let keyName = key
            
            // Save single properties
            self.setObjectValue(value, forKey: keyName)
        }
        
        return self
        
    }
    
}
