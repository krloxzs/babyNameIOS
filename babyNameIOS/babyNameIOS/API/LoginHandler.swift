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
    
    
  func requestPOSTURL(Username username: String, Password password: String, success:@escaping (JSON) -> Void, failure:@escaping (String) -> Void){
        logger.log("login by email")
        // Get url
        let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase + requestedURL
        logger.log(completeURL)
        let params:Parameters  = ["email": username, "password": password,"token_firebase":"","device_id": UIDevice.current.identifierForVendor!.uuidString,"os":"ios","is_profesor":false]
        logger.log(params)
        Alamofire.request(completeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                let item = resJson.dictionary
                logger.log(item)
                let userstatus = item!["code"]!.int
                // Getting 'u suario' dictionar
                if userstatus == 200{
                    let Data = item!["data"]!.dictionary

                    logger.log("nivel-----")
                    let UserDic = Data!["user"]!.dictionary!
                    let cuenta = UserDic["cuenta"]!.dictionaryObject
                   if let facturacion = cuenta?["facturacion"] as? NSDictionary{
                        let nivelInfo =  cuenta!["nivel"]! as! NSDictionary
                        let gradoInfo = cuenta!["grado"]! as! NSDictionary
                        print("------")
                        UserItem(
                            userId: cuenta!["id"]! as! Int,
                            session_id: Data!["session_id"]!.string!,
                            name: UserDic["name"]!.string!,
                            username : UserDic["username"]!.string!,
                            email: UserDic["email"]!.string!,
                            tipo: UserDic["tipo"]!.string!,
                            telefono: UserDic["telefono"]!.string!,
                            token_dispositivo: ":D",//UserDic["token_dispositivo"]!.string!,
                            image: UserDic["image"]!.string!,
                            nivel: cuenta!["nivel"]! as! NSDictionary,
                            grado: cuenta!["grado"]! as! NSDictionary,
                            codigo_referencia: cuenta!["codigo_referencia"]! as! String,
                            nivel_id: nivelInfo["id"]! as! Int,
                            nivel_titulo: nivelInfo["titulo"]! as! String,
                            grado_id: gradoInfo["id"]! as! Int,
                            grado_titulo: gradoInfo["titulo"]! as! String,
                            codigo_invitacion: cuenta!["codigo_invitacion"]! as! String,
                            codigo_registro: cuenta!["codigo_registro"]! as! String,
                            rfc: facturacion["rfc"]! as! String,
                            calle: facturacion["calle"]! as! String,
                            codigo_postal: facturacion["codigo_postal"]! as! Int,
                            estado: facturacion["estado"]! as! String,
                            municipio: facturacion["municipio"]! as! String,
                            colonia: facturacion["colonia"]! as! String,
                            email_facturacion: facturacion["email_facturacion"]! as! String,
                            razon_social: facturacion["razon_social"]! as! String
                            ).synchronizeObject(Constants.UserDefaultsKeys.UserObject.rawValue)
                        //
                        // Saving USER ID
                        let defaults = UserDefaults.standard
                        defaults.set( Data!["session_id"]!.string!, forKey: Constants.UserDefaultsKeys.UserId.rawValue)
                        defaults.synchronize()
                        print("se termino la sincronizacion")
                        success(resJson)
                    
                    
                    
                    }else{
                        let nivelInfo =  cuenta!["nivel"]! as! NSDictionary
                        let gradoInfo = cuenta!["grado"]! as! NSDictionary
                        print("------")
                        UserItem(
                            userId: cuenta!["id"]! as! Int,
                            session_id: Data!["session_id"]!.string!,
                            name: UserDic["name"]!.string!,
                            username : UserDic["username"]!.string!,
                            email: UserDic["email"]!.string!,
                            tipo: UserDic["tipo"]!.string!,
                            telefono: UserDic["telefono"]!.string!,
                            token_dispositivo: ":D",//UserDic["token_dispositivo"]!.string!,
                            image: UserDic["image"]!.string!,
                            nivel: cuenta!["nivel"]! as! NSDictionary,
                            grado: cuenta!["grado"]! as! NSDictionary,
                            codigo_referencia: cuenta!["codigo_referencia"]! as! String,
                            nivel_id: nivelInfo["id"]! as! Int,
                            nivel_titulo: nivelInfo["titulo"]! as! String,
                            grado_id: gradoInfo["id"]! as! Int,
                            grado_titulo: gradoInfo["titulo"]! as! String,
                            codigo_invitacion: cuenta!["codigo_invitacion"]! as! String ,
                            codigo_registro: cuenta!["codigo_registro"]! as! String,
                            rfc: "",
                            calle: "",
                            codigo_postal:0,
                            estado: "",
                            municipio: "",
                            colonia: "",
                            email_facturacion: "",
                            razon_social: ""
                            ).synchronizeObject(Constants.UserDefaultsKeys.UserObject.rawValue)
                        //
                        // Saving USER ID
                        let defaults = UserDefaults.standard
                        defaults.set( Data!["session_id"]!.string!, forKey: Constants.UserDefaultsKeys.UserId.rawValue)
                        defaults.synchronize()
                        print("se termino la sincronizacion")
                        success(resJson)
                    }
  
                //if yes and return the data
                }else{
                    let ErrorString = item!["message"]!.string
                    logger.log(ErrorString)
                    failure(ErrorString!)
                }
        
        
        }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error.localizedDescription)
                
            }
    }
    
}
    
    func SignInFacebook(FBTOKEN FBToken: String, success:@escaping (JSON) -> Void, failure:@escaping (String) -> Void){
        logger.log("login by email")
        // Get url
        let requestedURL: String! = values[Constants.Settings.service_keys.LOGIN_BY_EMAIL.rawValue]  as! String
        let completeURL = urlBase + requestedURL
        logger.log(completeURL)
        let params:Parameters  = ["token": FBToken,"token_firebase":"","device_id": UIDevice.current.identifierForVendor!.uuidString,"os":"ios","is_profesor":false]
        logger.log(params)
        
        Alamofire.request(completeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                let item = resJson.dictionary
                logger.log(item)
                let userstatus = item!["code"]!.int
                // Getting 'u suario' dictionar
                if userstatus == 200{
                    let Data = item!["data"]!.dictionary
                    
                    logger.log("nivel-----")
                    let UserDic = Data!["user"]!.dictionary!
                    let cuenta = UserDic["cuenta"]!.dictionaryObject
                    _ =  cuenta!["nivel"]! as! NSDictionary
                    _ = cuenta!["grado"]! as! NSDictionary
                   if let facturacion = cuenta?["facturacion"] as? NSDictionary{
                        let nivelInfo =  cuenta!["nivel"]! as! NSDictionary
                        let gradoInfo = cuenta!["grado"]! as! NSDictionary
                        print("------")
                        UserItem(
                            userId: cuenta!["id"]! as! Int,
                            session_id: Data!["session_id"]!.string!,
                            name: UserDic["name"]!.string!,
                            username : UserDic["username"]!.string!,
                            email: UserDic["email"]!.string!,
                            tipo: UserDic["tipo"]!.string!,
                            telefono: UserDic["telefono"]!.string!,
                            token_dispositivo: ":D",//UserDic["token_dispositivo"]!.string!,
                            image: UserDic["image"]!.string!,
                            nivel: cuenta!["nivel"]! as! NSDictionary,
                            grado: cuenta!["grado"]! as! NSDictionary,
                            codigo_referencia: cuenta!["codigo_referencia"]! as! String,
                            nivel_id: nivelInfo["id"]! as! Int,
                            nivel_titulo: nivelInfo["titulo"]! as! String,
                            grado_id: gradoInfo["id"]! as! Int,
                            grado_titulo: gradoInfo["titulo"]! as! String,
                            codigo_invitacion: cuenta!["codigo_invitacion"]! as! String,
                            codigo_registro: cuenta!["codigo_registro"]! as! String,
                            rfc: facturacion["rfc"]! as! String,
                            calle: facturacion["calle"]! as! String,
                            codigo_postal: facturacion["codigo_postal"]! as! Int,
                            estado: facturacion["estado"]! as! String,
                            municipio: facturacion["municipio"]! as! String,
                            colonia: facturacion["colonia"]! as! String,
                            email_facturacion: facturacion["email_facturacion"]! as! String,
                            razon_social: facturacion["razon_social"]! as! String
                            ).synchronizeObject(Constants.UserDefaultsKeys.UserObject.rawValue)
                        //
                        // Saving USER ID
                        let defaults = UserDefaults.standard
                        defaults.set( Data!["session_id"]!.string!, forKey: Constants.UserDefaultsKeys.UserId.rawValue)
                        defaults.synchronize()
                        print("se termino la sincronizacion")
                        success(resJson)
                        
                        
                        
                    }else{
                        let nivelInfo =  cuenta!["nivel"]! as! NSDictionary
                        let gradoInfo = cuenta!["grado"]! as! NSDictionary
                        print("------")
                        UserItem(
                            userId: cuenta!["id"]! as! Int,
                            session_id: Data!["session_id"]!.string!,
                            name: UserDic["name"]!.string!,
                            username : UserDic["username"]!.string!,
                            email: UserDic["email"]!.string!,
                            tipo: UserDic["tipo"]!.string!,
                            telefono: UserDic["telefono"]!.string!,
                            token_dispositivo: ":D",//UserDic["token_dispositivo"]!.string!,
                            image: UserDic["image"]!.string!,
                            nivel: cuenta!["nivel"]! as! NSDictionary,
                            grado: cuenta!["grado"]! as! NSDictionary,
                            codigo_referencia: cuenta!["codigo_referencia"]! as! String,
                            nivel_id: nivelInfo["id"]! as! Int,
                            nivel_titulo: nivelInfo["titulo"]! as! String,
                            grado_id: gradoInfo["id"]! as! Int,
                            grado_titulo: gradoInfo["titulo"]! as! String,
                            codigo_invitacion: cuenta!["codigo_invitacion"]! as! String,
                            codigo_registro: cuenta!["codigo_registro"]! as! String,
                            rfc: "",
                            calle: "",
                            codigo_postal:0,
                            estado: "",
                            municipio: "",
                            colonia: "",
                            email_facturacion: "",
                            razon_social: ""
                            ).synchronizeObject(Constants.UserDefaultsKeys.UserObject.rawValue)
                        //
                        // Saving USER ID
                        let defaults = UserDefaults.standard
                        defaults.set( Data!["session_id"]!.string!, forKey: Constants.UserDefaultsKeys.UserId.rawValue)
                        defaults.synchronize()
                        print("se termino la sincronizacion")
                        success(resJson)
                    }
                    

                }else{
                    let ErrorString = item!["message"]!.string
                    logger.log(ErrorString)
                    failure(ErrorString!)
                }
                
                
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error.localizedDescription)
                
            }
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
