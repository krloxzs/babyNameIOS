//
//  RealmModels.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/30/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//


import Foundation
import RealmSwift

class babyNameRO: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var gender = ""
    @objc dynamic var meaning = ""
    @objc dynamic var origin = ""
    @objc dynamic var image = ""
    @objc dynamic var like = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
   
    func setNameObjInfo(BabyOBJ: NameObject) {
        self.id         = BabyOBJ.id
        self.name       = BabyOBJ.name
        self.gender     = BabyOBJ.gender
        self.meaning    = BabyOBJ.meaning
        self.origin     = BabyOBJ.origin
        self.image      = BabyOBJ.image
        self.like       = BabyOBJ.like
        
    }
}
