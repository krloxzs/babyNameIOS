//
//  UserProfile.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 19/05/16.

//

import Foundation

class UserProfile: BaseNSObject, NSCoding {
    
    var name: String
    var image: String
    
    // Memberwise initializer
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.image, forKey: "image")
    }
    
}
