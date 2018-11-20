//
//  AFWrapper.swift
//
//
//  Created by Carlos Rodriguez on 20/10/16.
//  Copyright © 2016 . All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
public typealias ETSuccessRequest  = (_ responseObject:AnyObject, _ dataTask: URLSessionDataTask?) -> ()
public typealias ETFailedRequest   = (_ dataTask: URLSessionDataTask?, _ errorString: String?) -> ()
public typealias ETVoid   = () -> ()
class AFWrapper: NSObject {
    func requestGETURL(_ strURL: String,  params : Parameters?, success:@escaping (_ res:JSON) -> Void, failure:@escaping (String) -> Void){
        Alamofire.request(strURL, method: .get, parameters: params).responseJSON  { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                success(JSON(responseObject.result.value!))
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error.localizedDescription)
            }
        }
    }
    
    func requestPOSTURL(_ strURL : String, params : Parameters?, headers : [String : String]?, success:@escaping (_ res:JSON) -> Void, failure:@escaping (String) -> Void){
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                success(JSON(responseObject.result.value!))
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error.localizedDescription)
            }
        }
    }
    
    func requestPUTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (_ res:JSON) -> Void, failure:@escaping (String) -> Void){
        Alamofire.request(strURL, method: .put, parameters: params/*, encoding: JSONEncoding.default, headers: headers*/).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                success(JSON(responseObject.result.value!))
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error.localizedDescription)
            }
        }
    }
    func requestURL(_ strURL : String, httpMethodForUse:HTTPMethod ,params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (_ res:JSON) -> Void, failure:@escaping (String) -> Void){
        //before use check the encoding in favly api
        Alamofire.request(strURL, method: httpMethodForUse, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                success(JSON(responseObject.result.value!))
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error.localizedDescription)
            }
        }
    }
    
}

