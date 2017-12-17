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
    var DatesMeasureArray: NSMutableArray = []
    
    
    override init() {
        super.init()
    }
    
    
    func GetCouple(_ CoupleId:String ,
             success:@escaping (UserInformation) -> Void, failure:@escaping (String) -> Void) {
        // Get url
        //let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase
        logger.log(completeURL)
        let params:Parameters  = ["couple_id":CoupleId, "type":"GetCouple"]
        logger.log(params)
        //get process
        self.networkHandler.requestGETURL(completeURL!, params: params, success: { (res:JSON) in
            //
            let thisUserInfo = res[0]
            let coupleUser = res[1]
            // Root respons
            let _: UserInformation = UserInformation(JSONObject: thisUserInfo)
            let coupleUserInfoObject: UserInformation = UserInformation(JSONObject: coupleUser)
            success(coupleUserInfoObject)
        }) { (String) in
            //
            failure(String)
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
            print(res)
            success(res)
        }) { (String) in
            //
            failure(String)
        }
        
    }
    
    
   
    
}
