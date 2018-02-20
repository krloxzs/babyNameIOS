//
//  genderSingleton.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 2/18/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import Foundation



class genderSingleton {
    
    static let actualGender = genderSingleton(gender: "")
    // MARK: - Properties
    
    var  gender: String
    var  genderHasBeenChange : Bool
    
    // Initialization
    
    init(gender: String) {
        self.genderHasBeenChange = false
        if (UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.Gender.rawValue) as? String != nil){
                 self.gender = UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.Gender.rawValue) as! String
        }else{
            self.gender = ""
        }
        
      
    }
    
}
