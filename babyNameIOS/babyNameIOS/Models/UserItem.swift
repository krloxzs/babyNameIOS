//
//  UserItem.swift
//  Created by Carlos Rodriguez on 22/05/16.
//

import Foundation

// TODO: Migrate this class using BuilderPattern instead.
class UserItem: BaseNSObject, NSCoding {
    
    let id                   : String
    let facebook_id          : String
    let name                 : String
    let email                : String
    let profile_image        : String
    let premium              : String
    let gender               : String
    let age                  : String
    let couple_id            : String
   
    
    
    init(id: String,facebook_id:String,
         name:String,email: String,
         profile_image: String,
         premium : String, gender:String, age: String,
         couple_id: String) {
        
        self.id             = id
        self.facebook_id    = facebook_id
        self.name           = name
        self.email          = email
        self.profile_image  = profile_image
        self.premium        = premium
        self.gender         = gender
        self.age            = age
        self.couple_id      = couple_id
    }
    
    // MARK: NSCoding
    required init(coder aDecoder: NSCoder) {
        self.id              = aDecoder.decodeObject(forKey: "id") as! String
        self.facebook_id     = aDecoder.decodeObject(forKey: "facebook_id") as! String
        self.name            = aDecoder.decodeObject(forKey: "name") as! String
        self.email           = aDecoder.decodeObject(forKey: "email") as! String
        self.profile_image   = aDecoder.decodeObject(forKey: "profile_image") as! String
        self.premium         = aDecoder.decodeObject(forKey: "premium") as! String
        self.gender          = aDecoder.decodeObject(forKey: "gender") as! String
        self.age             = aDecoder.decodeObject(forKey: "age") as! String
        self.couple_id      = aDecoder.decodeObject(forKey: "couple_id") as! String
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(self.id, forKey: "id")
        coder.encode(self.facebook_id, forKey:  "facebook_id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.email, forKey: "email")
        coder.encode(self.profile_image, forKey: "profile_image")
        coder.encode(self.premium, forKey: "premium")
        coder.encode(self.gender, forKey: "gender")
        coder.encode(self.age, forKey: "age")
        coder.encode(self.couple_id, forKey: "couple_id")
    }
    
}

