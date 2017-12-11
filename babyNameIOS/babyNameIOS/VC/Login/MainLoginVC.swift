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
import Lottie
class MainLoginVC: BaseViewController, UIScrollViewDelegate {
    //MARK:- IBOutlets
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var pageControl : UIPageControl!
    @IBOutlet var swipeLabelOutlet : UILabel!
    @IBOutlet weak var facebookButtonOutlet: UIButton!

    //MARK:- Variables and Constants
    let loginHandler = LoginHandler.sharedInstance
    var loadingNotification: MBProgressHUD! = MBProgressHUD()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var titlesArray = [AppStrings.WELCOME_TITLE_1.localized,AppStrings.WELCOME_TITLE_2.localized,AppStrings.WELCOME_TITLE_3,AppStrings.WELCOME_TITLE_4]
    var infoArray  = [AppStrings.WELCOME_INFO_1,AppStrings.WELCOME_INFO_2,AppStrings.WELCOME_INFO_3,AppStrings.WELCOME_INFO_4]
    var AnimArray  = ["animated_color_options","bookmark_animation","empty_status","scan_qr_code_success"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "yolo"
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeHidden
        prepareActionsForView()
        setupScrollView()
        // Setup our animaiton view
    }
    func setupScrollView()  {
        self.pageControl.numberOfPages = titlesArray.count
        self.pageControl.currentPage = 0
        scrollView.delegate = self
        var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        for index in 0..<titlesArray.count {
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            let pageCard = UIView()
            pageCard.frame = frame
            let animationView: LOTAnimationView = LOTAnimationView(name: AnimArray[index]);
            animationView.contentMode = .scaleAspectFill
            animationView.frame = CGRect(x: (frame.size.width / 2) - ((frame.size.width / 4)) , y: 0, width: frame.size.width / 2, height: frame.size.height / 6)
            animationView.play(fromProgress: 0, toProgress: 0.5, withCompletion: nil)
            animationView.loopAnimation = true
            // now the text
            let Stringx = titlesArray[index]
            let myAttribute = [ NSAttributedStringKey.foregroundColor: UIColor.black]
            let myAttrString = NSAttributedString(string: Stringx, attributes: myAttribute)
            let label =  UILabel(frame: CGRect(x: 0 , y: animationView.frame.origin.y +  (frame.size.height / 7) , width: frame.size.width, height: frame.size.height / 4))
            label.font = UIFont.boldSystemFont(ofSize: 23)
            label.attributedText = myAttrString
            label.numberOfLines = 1
            label.textAlignment = .center
            //----
            let Stringy = infoArray[index]
            let myAttrStringy = NSAttributedString(string: Stringy, attributes: myAttribute)
            let label1 =  UILabel(frame: CGRect(x: 0 , y: label.frame.origin.y +  (frame.size.height / 7), width: label.frame.width, height: frame.size.height / 2))
            label1.attributedText = myAttrStringy
            label1.numberOfLines = 7
            label1.adjustsFontSizeToFitWidth = true
            label1.textAlignment = .center
            pageCard.addSubview(label)
            pageCard.addSubview(label1)
            pageCard.addSubview(animationView)
            self.scrollView.addSubview(pageCard)
        }
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(titlesArray.count), height: self.scrollView.frame.size.height)
    }
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
    }
    
    func logout() {
        self.loginHandler.clearUserSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        loginHandler.clearUserSession()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeHidden
        prepareActionsForView()
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
    
    @IBAction func pageControllerChange(_ sender: UIPageControl) {
        let x = CGFloat(sender.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    @IBAction func registroAction(_ sender: AnyObject) {
//        let registrovc = self.storyboard?.instantiateViewController(withIdentifier: "registroVCID") as! registroVC
//        self.present(registrovc, animated: true, completion: nil)
    }
}
