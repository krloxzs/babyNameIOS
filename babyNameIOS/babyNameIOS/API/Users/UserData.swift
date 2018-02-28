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
import Realm
import RealmSwift



class UserData: NSObject {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let networkHandler: AFWrapper! = AFWrapper()
    var namesArray: Array = [NameObject]()
    var userInfo: UserItem?
     let realmData = realmHelper()
    var babys : Results<babyNameRO>!
    let realm = try! Realm()
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
                    self.babys = self.realm.objects(babyNameRO.self).sorted(byKeyPath: "id", ascending: true).filter( "%K == true", "like")
                    switch nameOBJ.gender{
                    case "male":
                        let maleIcons = ["Ball","Bathtub","Bib","Bird","Socks","Submarine","Whale"]
                        let randomIndex = Int(arc4random_uniform(UInt32(maleIcons.count)))
                        nameOBJ.image = maleIcons[randomIndex]
                    case "female":
                        let femaleIcons = ["Apple","Bear","Butterfly","Cow","Feet","Heart","Pig"]
                        let randomIndex = Int(arc4random_uniform(UInt32(femaleIcons.count)))
                        nameOBJ.image = femaleIcons[randomIndex]
                    case "unisex":
                         let unisexIcons = ["Cake","Candy","Cutlery","Diaper","Dog","Duck","Gift","Rattle","Sleepsuit"]
                         let randomIndex = Int(arc4random_uniform(UInt32(unisexIcons.count)))
                         nameOBJ.image = unisexIcons[randomIndex]
                    default:
                        break
                    }
                        if nameOBJ.gender == gender || nameOBJ.gender == "unisex"{
                            //on;ly add the element if the user didnot like the name or is a new name
                            if self.realmData.checkIfBabyidExist(nameOBJ.id){
                                if !self.realmData.checkIfBabyidIsALikeId(nameOBJ.id){
                                    self.namesArray.append(nameOBJ)
                                }
                            }else{
                                self.namesArray.append(nameOBJ)
                            }
                           
                        }
                }
                self.namesArray = self.namesArray.shuffled()
                success(res)
            }else{
                 failure(AppStrings.INTERNAL_SERVER_ERROR)
            }
            
           
        }) { (String) in
            //
            failure(AppStrings.INTERNAL_SERVER_ERROR)
        }
        
    }
    
         //MARK:- saveNameByIdInLikes
    func sendlikeBabyName(_ USER_ID:String ,COUPLE_ID:String , NAME_ID: String,
                   success:@escaping (JSON) -> Void, failure:@escaping (String) -> Void) {
        // Get url
        //let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase
        logger.log(completeURL)
        let params:Parameters  = ["user_id"     :USER_ID,
                                  "couple_id"   :COUPLE_ID,
                                  "name_id"     :NAME_ID,
                                  "type"        :"Match"]


        logger.log(params)
        //get process
        logger.log("se va a dar de alta el name con id \(NAME_ID) para el usuario \(USER_ID) con la pareja numero \(COUPLE_ID)")
        self.networkHandler.requestGETURL(completeURL!, params: params, success: { (res:JSON) in
            let responseDict = res.dictionary
            logger.log(responseDict)
            if var _ = responseDict?["success"]?.string{
//                var matchID = responseDict?["match_id"]?.string
                success(res)
            }else{
//                the match is already in the DB
                success(res)
            }
        }) { (String) in
            //
            failure(AppStrings.INTERNAL_SERVER_ERROR)
        }

    }

    
}
