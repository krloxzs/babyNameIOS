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
    public typealias standarJson  = [String : AnyObject]
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
    func gotGender() -> Bool {
        
        if (UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.Gender.rawValue) as? String != nil) {
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
    

    func SerchInUserInfoForNewInfo(USER_ID user_id: String,success:@escaping () -> Void, failure:@escaping (String) -> Void) {
        // Get url
        //let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase
        logger.log(completeURL)
        let params:Parameters  = ["type": "GetUser","user_id":user_id]
        logger.log(params)
        networkHandler.requestGETURL(completeURL!, params: params, success: { (Response:JSON) in
            let itemD = Response.dictionary
            logger.log(itemD)
            if let _ = itemD?["success"]?.string{
                if let _ = itemD?["data"] {
                    let itemArray  =  itemD!["data"]!.array
                    let item = itemArray![0].dictionary
                    UserItem(id: item?["id"]?.string ?? "" , facebook_id:  item?["facebook_id"]?.string ?? "",
                             name: item?["name"]?.string ?? "", email: item?["email"]?.string ?? "",
                             profile_image: item?["profile_image"]?.string ?? "" , premium: item?["premium"]?.string ?? "",
                             gender: item?["gender"]?.string ?? "", age: item?["age"]?.string ?? "",
                             couple_id: item?["couple_id"]?.string ?? "").synchronizeObject(Constants.UserDefaultsKeys.UserObject.rawValue)
                    // Saving USER ID
                    let defaults = UserDefaults.standard
                    defaults.set( item!["id"]!.string!, forKey: Constants.UserDefaultsKeys.UserId.rawValue)
                    defaults.synchronize()
                    print("se termino la sincronizacion")
                    success()
                }else{
                    failure("Unespected error")
                }
            }else{
                failure("Unespected error")
            }
        }) { (ErrorString: String) in
            failure(ErrorString)
        }
        
        
    }
    
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
            let itemD = Response.dictionary
            if let _ = itemD?["data"] {
                let itemArray  =  itemD!["data"]!.array
                let item = itemArray![0].dictionary
                UserItem(id: item?["id"]?.string ?? "" , facebook_id:  item?["facebook_id"]?.string ?? "",
                         name: item?["name"]?.string ?? "", email: item?["email"]?.string ?? "",
                         profile_image: profile_image , premium: item?["premium"]?.string ?? "",
                         gender: item?["gender"]?.string ?? "", age: item?["age"]?.string ?? "",
                         couple_id: item?["couple_id"]?.string ?? "").synchronizeObject(Constants.UserDefaultsKeys.UserObject.rawValue)
                // Saving USER ID
                let defaults = UserDefaults.standard
                defaults.set( item!["id"]!.string!, forKey: Constants.UserDefaultsKeys.UserId.rawValue)
                defaults.synchronize()
                print("se termino la sincronizacion")
                success(Response)
                
            }else{
                failure("Unespected error")
            }
        }) { (ErrorString: String) in
            failure(ErrorString)
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
        _ = BaseNSObject().deleteObjectKey(Constants.UserDefaultsKeys.Gender.rawValue)
        // Removing user ID
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constants.UserDefaultsKeys.UserId.rawValue)
        defaults.synchronize()
        
    }
    
}
