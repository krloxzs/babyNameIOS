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
    var titlesArray = [AppStrings.WELCOME_TITLE_1,AppStrings.WELCOME_TITLE_2,AppStrings.WELCOME_TITLE_3,AppStrings.WELCOME_TITLE_4]
    var infoArray  = [AppStrings.WELCOME_INFO_1,AppStrings.WELCOME_INFO_2,AppStrings.WELCOME_INFO_3,AppStrings.WELCOME_INFO_4]
    let animation1: LOTAnimationView = LOTAnimationView(name: "empty_status")
    let animation2: LOTAnimationView = LOTAnimationView(name: "swipe_left")
    let animation3: LOTAnimationView = LOTAnimationView(name: "bookmark_animation")
    let animation4: LOTAnimationView = LOTAnimationView(name: "account_success")
    
    //MARK:- UIviewcontrollerFunctions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        self.swipeLabelOutlet.text = AppStrings.SWIPE
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeHidden
        prepareActionsForView()
        setupScrollView()
        setupView()
        // Setup our animaiton view
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeHidden
        prepareActionsForView()
    }
    
     //MARK:- SetuoScrollView
    func setupView(){
        self.facebookButtonOutlet.layer.cornerRadius = 16.0
        self.facebookButtonOutlet.clipsToBounds = true
        self.facebookButtonOutlet.setTitle(AppStrings.FACEBOOK_LOGIN_BUTON, for: .normal)
        self.swipeLabelOutlet.text = AppStrings.LOGIN_SWIPE_LABEL
    }
    
    func setupScrollView()  {
        self.pageControl.numberOfPages = titlesArray.count
        self.pageControl.currentPage = 0
        scrollView.delegate = self
        var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        for index in 0..<titlesArray.count {
            frame.origin.x = self.view.frame.size.width * CGFloat(index)
            
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            let pageCard = UIView()
            pageCard.frame = frame
            var animationView: LOTAnimationView?
            switch index{
                
            case 0:
                animationView = animation1
            case 1:
                animationView = animation2
            case 2:
                animationView = animation3
            case 3:
                animationView = animation4
            default:
                break
            }
            animationView!.contentMode = .scaleAspectFit
            if (UIScreen.main.bounds.size.width == 320)
            {
//                5,se
               animationView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.scrollView.frame.height / 2 )
            }
            else if (UIScreen.main.bounds.size.width == 375)
            {
                if UIScreen.main.bounds.size.height == 667{
//                6
                    animationView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.scrollView.frame.height / 1.4 )
                }else{
//                iphone x
                    animationView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.scrollView.frame.height / 1.1 )
                }
            }
            else
            {
                //Plus
              animationView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.scrollView.frame.height / 1.3 )
            }
            animationView!.animationSpeed = 0.5
            animationView!.play()
            animationView!.loopAnimation = true
            let Stringx = titlesArray[index]
            let myAttribute = [ NSAttributedStringKey.foregroundColor: UIColor(hex: Constants.Colors.NavBarBGColor.rawValue)]
            let myAttribute2 = [ NSAttributedStringKey.foregroundColor: UIColor(hex: Constants.Colors.subTitleColorF.rawValue)]
            let myAttrString = NSAttributedString(string: Stringx, attributes: myAttribute)
            let label =  UILabel(frame: CGRect(x: 0 , y: animationView!.frame.height +  16 , width: self.view.frame.width, height: self.scrollView.frame.height / 13))
            label.font =  UIFont (name: "ProximaNova-Bold", size: 30)
            label.attributedText = myAttrString
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 1
            label.textAlignment = .center
            let Stringy = infoArray[index]
            let myAttrStringy = NSAttributedString(string: Stringy, attributes: myAttribute2)
            let label1 =  UILabel(frame: CGRect(x: 0 , y: (label.frame.origin.y + label.frame.height) + 8, width: label.frame.width, height: self.scrollView.frame.height / 8))
            label1.attributedText = myAttrStringy
            label1.font = UIFont (name: "ProximaNova-Regular", size: 17)
            label1.numberOfLines = 7
            label1.adjustsFontSizeToFitWidth = true
            label1.textAlignment = .center
            pageCard.addSubview(label)
            pageCard.addSubview(label1)
            pageCard.addSubview(animationView!)
            self.scrollView.addSubview(pageCard)
        }
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 4, height: self.scrollView.frame.size.height)
    }
    
    //MARK:- ScrollViewDElegates
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        switch pageNumber{
        case 0:
            animation1.play()
        case 1:
            animation2.play()
        case 2:
            animation3.play()
        case 3:
            animation4.play()
        default:
            break
        }
    }
    
    //MARK:- LoginFunctions
    func logout() {
        self.loginHandler.clearUserSession()
    }
    
     //MARK:- FacebookFunctions
    private func launchInitWithFacebook() {
        print("launchInitWithFacebook")
        let facebookReadPermissions = ["public_profile", "email", "user_friends"]
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
                        self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
                        self.loadingNotification.mode = MBProgressHUDMode.indeterminate
                        self.loadingNotification.labelText = AppStrings.LOADING
                        self.returnUserData()
                        // Do work
                    }
                }
            })
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id,name,age_range,gender,email,picture.height(300).width(300)"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // Process error
                print("Error: \(String(describing: error))")
            }
            else
            {
                let userDic: NSDictionary = result as! NSDictionary
                let emailFacebook = userDic["email"] as? String ?? ""
                let FBID = userDic["id"] as! String
                let nameFacebook = userDic["name"] as! String
                let picture = userDic["picture"] as! NSDictionary
                let data = picture["data"] as! NSDictionary
                let urlFacebook = data["url"] as! String
                var gender = userDic["gender"] as! String
                let age_range = userDic["age_range"] as! NSDictionary
                let edad = age_range["min"] as! Int
                let age = String(edad)
                if gender == "male"{
                    
                    gender = "m"
                    
                }else{
                    
                    gender = "f"
                }
                let now = Date()
                let fecha = now - edad.years
                _ = fecha.string(format: DateFormat.custom("yyyy-MM-dd"))
                
                weak var weakSelf:MainLoginVC! = self
                self.loginHandler.SignInFacebook(FBID: FBID, EMAIL: emailFacebook, PFIMAGE: urlFacebook,
                                                 GENDER: gender, AGE: age, NAME: nameFacebook, success: { (Res:JSON) in
                                                    print("Succes")
                                                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                                                    weakSelf.appDelegate.AppsetupRoot.displayWindowsAccordingSession()
                }, failure: { (ErrorString:String) in
                    print("error")
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    weakSelf.appDelegate.AppsetupRoot.displayWindowsAccordingSession()
                })
            }
        })
    }
    
     //MARK:- IbActions
    @IBAction func loginFacebook(_ sender: AnyObject) {
        logger.log("facebook login")
        launchInitWithFacebook()
    }
    
    @IBAction func pageControllerChange(_ sender: UIPageControl) {
        let x = CGFloat(sender.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        switch sender.currentPage{
        case 0:
            animation1.play()
        case 1:
            animation2.play()
        case 2:
            animation3.play()
        case 3:
            animation4.play()
        default:
            break
        }
    }

}
