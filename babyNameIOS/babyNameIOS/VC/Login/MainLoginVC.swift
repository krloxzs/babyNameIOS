//
//  MainLoginVC.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/7/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import MBProgressHUD
import FBSDKCoreKit
import SwiftyJSON
import SwiftDate

class MainLoginVC: BaseViewController {
    //MARK:- Variables and Constants
    let loginHandler = LoginHandler.sharedInstance
    var loadingNotification: MBProgressHUD! = MBProgressHUD()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "yolo"
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeHidden
//        navigationController?.navigationBar.setTransparent()
        navigationController?.navigationBar.customTitleFont()
       logout()
        if let accessToken = FBSDKAccessToken.current() {
            // User is logged in, use 'accessToken' here.
        }else{
           
        }
        
        
    }
    
    func logout() {
        self.loginHandler.clearUserSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginHandler.clearUserSession()
    }
    
    private func launchInitWithFacebook() {
        print("launchInitWithFacebook")
        let facebookReadPermissions = ["public_profile", "email", "user_friends"]
        if (FBSDKAccessToken.current() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            
        }
        else
        {
            let login: FBSDKLoginManager = FBSDKLoginManager()
            login.logIn(withReadPermissions: facebookReadPermissions,from: self, handler: {(result, error) in
                if ((error) != nil)
                {
                    // Process error
                }
                else if (result?.isCancelled)! {
                    // Handle cancellations
                }
                else {
                    // If you ask for multiple permissions at once, you
                    // should check if specific permissions missing
                    if (result?.grantedPermissions.contains("email"))!
                    {
                        // weak var weakSelf: MainLoginViewController! = self
                        //                        self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
                        //                        self.loadingNotification.mode = MBProgressHUDMode.indeterminate
                        //                        self.loadingNotification.labelText = "Iniciando..."
                        self.returnUserData()
                        // Do work
                    }
                }
            })
        }
    }
    
    
    func returnUserData()
    {
        //weak var selfWeak: MainLoginViewController! = self
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name,age_range,gender,email,picture.height(300).width(300)"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // Process error
                print("Error: \(String(describing: error))")
            }
            else
            {
             
                print("fetched user: \(String(describing: result))")
                let userDic: NSDictionary = result as! NSDictionary
                let emailFacebook = userDic["email"] as? String ?? ""
                _ = userDic["id"] as! String
                let nameFacebook = userDic["name"] as! String
                let picture = userDic["picture"] as! NSDictionary
                let data = picture["data"] as! NSDictionary
                let urlFacebook = data["url"] as! String
                print(urlFacebook)
                var gender = userDic["gender"] as! String
                let age_range = userDic["age_range"] as! NSDictionary
                let edad = age_range["min"] as! Int
                if gender == "male"{
                    
                    gender = "m"
                    
                }else{
                    
                    gender = "f"
                }
                let now = Date()
                let fecha = now - edad.years
                print(fecha)
                _ = fecha.string(format: DateFormat.custom("yyyy-MM-dd"))
                // self.imageToSend = url
                print(nameFacebook)
//                print(FBSDKAccessToken.current())
//                print(FBSDKAccessToken.current().userID)
//
//                print("el token : \(FBSDKAccessToken.current().tokenString)")
                //                self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
                //                self.loadingNotification.mode = MBProgressHUDMode.indeterminate
                //                self.loadingNotification.labelText = "Iniciando..."
//                self.InitLogin(FBToken: FBSDKAccessToken.current().tokenString, nombre: nameFacebook, email: emailFacebook, urlPhoto: urlFacebook)
            }
        })
    }
    func InitLogin(FBToken: String, nombre:String,email:String,urlPhoto:String){
        weak var weakSelf: MainLoginVC! = self
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.labelText = "Iniciando..."
        self.loginHandler.SignInFacebook(FBTOKEN: FBToken, success: { (Res:JSON) in
            weakSelf.appDelegate.AppsetupRoot.displayWindowsAccordingSession()
//            AlertHelper.ShowSuccess(Title:  ["Bienvenido a Junger"], body: "Es hora de aprender")
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            
        }) { (ErrorString:String) in
            if ErrorString == "Ese email ya esta registrado a una cuenta tipo profesor"{
//                AlertHelper.ShowError(Title: ["Error en login"], body: ErrorString)
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            }else{
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                logger.log("-----")
//                let registrovc = self.storyboard?.instantiateViewController(withIdentifier: "registroVCID") as! registroVC
//                registrovc.InitInfo = true
//                registrovc.NombreFacebook = nombre
//                registrovc.EmailFacebook = email
//                registrovc.urlFacebook = urlPhoto
//                self.present(registrovc, animated: true, completion: nil)
            }
        }
    }
    @IBAction func showLoginAction(_ sender: AnyObject) {
        
//        let loginvc = self.storyboard?.instantiateViewController(withIdentifier: "iniciarSesionVCID") as! iniciarSesionVC
//        loginvc.login = self
//        customPresentViewController(presenter, viewController: loginvc, animated: true, completion: nil)
        
    }
    
    @IBAction func loginFacebook(_ sender: AnyObject) {
        logger.log("facebook login")
        launchInitWithFacebook()
    }
    
    @IBAction func registroAction(_ sender: AnyObject) {
//        let registrovc = self.storyboard?.instantiateViewController(withIdentifier: "registroVCID") as! registroVC
//        self.present(registrovc, animated: true, completion: nil)
    }
}
