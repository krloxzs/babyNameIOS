//
//  LoginHandler.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 23/05/16.

//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import FBSDKLoginKit

class LoginHandler: BaseNSObject {
    //
    static let sharedInstance = LoginHandler()
    let networkHandler: AFWrapper! = AFWrapper()
    fileprivate override init() {} //This prevents others from using the default '()' initializer for this class.
    public typealias EstandarJson  = [String : AnyObject]
    let userId: Int! = -1
    /**
     Validate if user has valid information on this device.
     - returns: Bool
     */
    func isAuthenticated() -> Bool {
        
        if (UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.UserId.rawValue) as? String != nil) {
            return true
        }
        return false
    }
      /*
     Get User Profile information
     
     - returns: UserItem
     */
    func getUserInfo() -> UserItem? {
        var userInfo: UserItem
        do {
            userInfo = try UserDefaults().objectUnarchiverForKey(forKey: Constants.UserDefaultsKeys.UserObject.rawValue)!
            return userInfo
        }catch UnarchiverError.noKeyAssociated {
            logger.log("no key associated")
        }catch  {
            // Unexpected error!
        }
        
        return nil
    }
    
    /**
     Start user authentication using API
     
     - parameter username: email
     - parameter password: your password.
     
     - returns: void
     */
    

    
    func SignInFacebook(FBID facebook_id: String, EMAIL email : String, PFIMAGE profile_image : String,
                        GENDER gender : String , AGE age : String, NAME name : String,
                        success:@escaping (JSON) -> Void, failure:@escaping (String) -> Void){
        logger.log("Login using FB ID//////")
        // Get url
        //let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase
        logger.log(completeURL)
        let params:Parameters  = ["type": "CreateUser","facebook_id":facebook_id, "email": email, "profile_image" : profile_image,
                                  "gender" : gender, "age": age, "name" : name]
        logger.log(params)
        networkHandler.requestGETURL(completeURL!, params: params, success: { (Response:JSON) in
            let item = Response.dictionary
//            print(item!)
//            print(item!["id"]!.string!)
//            print(item!["facebook_id"]!.string!)
//            print(item!["name"]!.string!)
//            print(item!["email"]!.string!)
//            print(profile_image)
//            print(item!["premium"]!.string!)
//            print(item!["gender"]!.string!)
//            print(item!["age"]!.string!)
//            print(item!["couple_id"]!.string!)
//            
            UserItem(id: item?["id"]?.string ?? "" , facebook_id:  item?["facebook_id"]?.string ?? "",
                     name: item?["name"]?.string ?? "", email: item?["email"]?.string ?? "",
                     profile_image: profile_image , premium: item?["premium"]?.string ?? "",
                     gender: item?["gender"]?.string ?? "", age: item?["age"]?.string ?? "",
                     couple_id: item?["couple_id"]?.string ?? "", grado: item?["grado"]?.string ?? "").synchronizeObject(Constants.UserDefaultsKeys.UserObject.rawValue)
                                    // Saving USER ID
                                    let defaults = UserDefaults.standard
                                    defaults.set( item!["id"]!.string!, forKey: Constants.UserDefaultsKeys.UserId.rawValue)
                                    defaults.synchronize()
                                    print("se termino la sincronizacion")
            success(Response)
        }) { (ErrorString: String) in
            print(ErrorString)
        }
    }
    

    /**
     Clear user information from NSUserDefaults
     */
    func clearUserSession() {
        
        // Removing user object
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        _ = BaseNSObject().deleteObjectKey(Constants.UserDefaultsKeys.UserObject.rawValue)
        // Removing user ID
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.UserDefaultsKeys.UserId.rawValue)
        defaults.synchronize()
        
    }
    
}
