//
//  BaseObjects.swift
//  Created by Carlos Rodriguez on 19/07/16.
//

import Foundation
import SwiftyJSON
import MapKit
import CoreLocation


class ExampleOfUsage: BaseNSObject {
//    swift 3
    var lat: Double = 0
    var lng: Double = 0
    var nombre: String = ""
    var celular: String = ""
    var exterior: String = ""
    var interior: String = ""
    var extras: String = ""
    var concepto: String = ""
    var id : String  = ""
    
    
    
    // Initialization
    init(JSONObject: JSON) {
        super.init()
        
       _ =  self.constructRootProperties(JSONObject)
    }
    
    
}

class UserInformation: BaseNSObject {
//    Key value coding-compliant properties must be marked as dynamic
//    and in Swift 4 even as @objc
    @objc dynamic var couple_id:     String = ""
    @objc dynamic var name:          String = ""
    @objc dynamic var email:         String = ""
    @objc dynamic var premium:       String = ""
    @objc dynamic  var id:           String = ""
    @objc dynamic var gender:        String = ""
    @objc dynamic  var facebook_id:  String = ""
    @objc dynamic var age:           String = ""
    @objc dynamic var profile_image: String  = ""
    
    
    
    // Initialization
    init(JSONObject: JSON) {
        super.init()
        _ =  self.constructRootProperties(JSONObject)
    }
    
    
}

class NameObject: BaseNSObject {
    //    Key value coding-compliant properties must be marked as dynamic
    //    and in Swift 4 even as @objc
    @objc dynamic  var id:           String = ""
    @objc dynamic  var meaning:      String = ""
    @objc dynamic  var name:         String = ""
    @objc dynamic  var gender:       String = ""
    @objc dynamic  var origin:       String  = ""
    @objc dynamic  var image:        String  = ""
    
    
    
    
    // Initialization
    init(JSONObject: JSON) {
        super.init()
        _ =  self.constructRootProperties(JSONObject)
    }
    
    
}








