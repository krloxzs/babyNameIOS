//
//  GUConfigHandler.swift
//  GranCasting
//
//  Created by Carlos Rodriguez on 25/06/16.

//


import Foundation

class GUConfigHandler: NSObject {
    
    
    var dict: NSDictionary!
    
    private static var __once: () = {
       var instance: GUConfigHandler? = nil
    }()

    class var sharedInstance: GUConfigHandler {
        
        struct Static {
            static var onceToken: Int = 0
            static var instance: GUConfigHandler? = nil
        }
         Static.instance = GUConfigHandler()
        _ = GUConfigHandler.__once
        return Static.instance!
    }
    
    
    init(resourceName string: String)
    {
        let path = Bundle.main.path(forResource: string, ofType: Constants.Settings.configFileType.rawValue)
        dict = NSDictionary(contentsOfFile:path!)
        
        super.init()
    }
    convenience override init() {
        self.init(resourceName: Constants.Settings.configFileName.rawValue)
    }
    
    /// The value from "root associated plist" by key.
  func valueForKey(key: String) -> AnyObject? {
        var value: AnyObject?;
        
        if let settings = dict.object(forKey: Constants.Settings.configRoot.rawValue) {
            value = ((settings as! NSDictionary).object(forKey: key) as! NSDictionary).object(forKey: Constants.Settings.service_values.value.rawValue) as AnyObject?
            
            
        }
        
        if value == nil {
            value = "" as AnyObject?
        }
        
        
        return value;
    }
    
}
