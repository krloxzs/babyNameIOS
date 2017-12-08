//
//  BaseObjects.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 19/07/16.

//

import Foundation
import SwiftyJSON
import MapKit
import CoreLocation


class ExampleOfUsage: BaseNSObject {
    
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



