//
//  UserData.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/12/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate
import SwiftyJSON
import Alamofire



class UserData: NSObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let networkHandler: AFWrapper! = AFWrapper()
    var namesArray: Array = [NameObject]()
    var userInfo: UserItem?
   
    override init() {
        super.init()
    }
    
     //MARK:- User
    
    func GetCouple(_ CoupleId:String ,
             success:@escaping (UserInformation) -> Void, failure:@escaping (String) -> Void) {
        // Get url
        //let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase
        logger.log(completeURL)
        let params:Parameters  = ["couple_id":CoupleId, "type":"GetCouple"]
        logger.log(params)
        //get process
        userInfo = self.appDelegate.AppsetupRoot.loginHandler.getUserInfo()
        self.networkHandler.requestGETURL(completeURL!, params: params, success: { (res:JSON) in
            let itemD = res.dictionary
//            logger.log(itemD)
            if let _ = itemD?["data"] {
                let itemArray  =  itemD!["data"]!.array
                if itemArray!.count > 1{
                let UserInfo1 = itemArray![0]
                let userInfo2 = itemArray![1]
                // Root respons
                let coupleUserInfoObject1: UserInformation = UserInformation(JSONObject: UserInfo1)
                let coupleUserInfoObject2: UserInformation = UserInformation(JSONObject: userInfo2)
                
                if coupleUserInfoObject1.id == self.userInfo!.id{
                     success(coupleUserInfoObject2)
                }else{
                     success(coupleUserInfoObject1)
                    }
                }else{
                    failure(AppStrings.INTERNAL_SERVER_ERROR)
                }
            }else{
                failure(AppStrings.INTERNAL_SERVER_ERROR)
            }
        }) { (String) in
            //
            failure(AppStrings.INTERNAL_SERVER_ERROR)
        }
        
    }
    
    func SetCouple(_ USER_ONE:String ,USER_TWO:String ,
             success:@escaping (JSON) -> Void, failure:@escaping (String) -> Void) {
        // Get url
        //let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase
        logger.log(completeURL)
        let params:Parameters  = ["user_id_1":USER_ONE,
                                  "user_id_2":USER_TWO,
                                  "type":"SetCouple"]
 
        
        logger.log(params)
        //get process
        self.networkHandler.requestGETURL(completeURL!, params: params, success: { (res:JSON) in
            let responseDict = res.dictionary
            var userInfo: UserItem?
            userInfo = self.appDelegate.AppsetupRoot.loginHandler.getUserInfo()
            if var _ = responseDict?["success"]?.string{
                let responseId = responseDict?["id"]?.string
                UserItem(id: userInfo?.id ?? "" , facebook_id: userInfo?.facebook_id ?? "",
                         name: userInfo?.name ?? "", email: userInfo?.email ?? "",
                         profile_image: userInfo?.profile_image ?? "" , premium: userInfo?.premium ?? "",
                         gender: userInfo?.gender ?? "", age: userInfo?.age ?? "",
                         couple_id: responseId  ?? "").synchronizeObject(Constants.UserDefaultsKeys.UserObject.rawValue)
                // Saving USER ID
                let defaults = UserDefaults.standard
                defaults.set( userInfo!.id, forKey: Constants.UserDefaultsKeys.UserId.rawValue)
                defaults.synchronize()
                print("se termino la sincronizacion")
                success(res)
            }else{
               failure(AppStrings.INTERNAL_SERVER_ERROR)
                
            }
        }) { (String) in
            //
            failure(AppStrings.INTERNAL_SERVER_ERROR)
        }
        
    }
    
     //MARK:- Names
    
    func getBabyNames(success:@escaping (JSON) -> Void, failure:@escaping (String) -> Void) {
        // Get url
        //let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase
        logger.log(completeURL)
        let params:Parameters  = ["type":"GetNames"]
//        logger.log(params)
        //get process
        self.networkHandler.requestGETURL(completeURL!, params: params, success: { (res:JSON) in
            if let _ : String = res["success"].string{
                self.namesArray.removeAll()
                let gender = UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.Gender.rawValue) as! String
                print(gender)
                let  names = res["data"].array!
                for name in names{
                   
                        let nameOBJ: NameObject = NameObject(JSONObject: name)
                        if nameOBJ.gender == gender || nameOBJ.gender == "unisex"{
                            self.namesArray.append(nameOBJ)
                        }
                }
                success(res)
            }else{
                 failure(AppStrings.INTERNAL_SERVER_ERROR)
            }
            
           
        }) { (String) in
            //
            failure(AppStrings.INTERNAL_SERVER_ERROR)
        }
        
    }
   
    
}
