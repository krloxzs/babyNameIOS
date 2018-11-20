//
//  User.swift
//  Junger
//
//  Created by Moy Hdez on 24/11/16.
//  Copyright © 2016 Tejuino developers. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var username: String?
    var email: String?
    var tipo: String?
    var telefono: Int?
    var token_dispositivo: String?
    var image: String?

    
    init(json: Dictionary<String,AnyObject>){
        self.name = (json["name"] as! String)
        self.username = (json["username"] as! String)
        self.email = (json["email"] as! String)
        self.tipo = (json["tipo"] as! String)
        self.telefono = Int(json["telefono"] as! String)
        self.token_dispositivo = ":D"
        self.image = (json["image"] as! String)
    }
}
