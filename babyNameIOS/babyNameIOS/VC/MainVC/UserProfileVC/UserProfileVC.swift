//
//  UserProfileVC.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/11/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import MessageUI
import MBProgressHUD
class UserProfileVC: BaseViewController, UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate , MFMailComposeViewControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
    /// User information
    

    

    
    var shareHelper =  ShareManager()
    var userInfo: UserItem?
     var loadingNotification: MBProgressHUD! = MBProgressHUD()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let loginHandler = LoginHandler.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppStrings.PROFILE_TITLE
        setupTV()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.contentInsetAdjustmentBehavior = .never
        userInfo = appDelegate.AppsetupRoot.loginHandler.getUserInfo()
        // Do any additional setup after loading the view.
    }
    func setupTV() {
        self.userInfo = loginHandler.getUserInfo()
        self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.loadingNotification.mode = MBProgressHUDMode.indeterminate
        self.loadingNotification.labelText = AppStrings.LOADING
        self.loginHandler.SerchInUserInfoForNewInfo(USER_ID: userInfo!.id, success: {
             MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            self.tableView.reloadData()
        }) { (ErrorString:String) in
             MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
             self.tableView.reloadData()
        }
       configureTV()
    }
    
    func configureTV() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.keyboardDismissMode = .none
        self.tableView?.register(UINib(nibName: "UserProfileHeaderTVCell", bundle: nil), forCellReuseIdentifier: "UserProfileHeaderTVCell")
        self.tableView?.register(UINib(nibName: "ProfileOptionsTVCell", bundle: nil), forCellReuseIdentifier: "ProfileOptionsTVCell")
        self.tableView?.register(UINib(nibName: "ManagePartnerTVCell", bundle: nil), forCellReuseIdentifier: "ManagePartnerTVCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        userInfo = appDelegate.AppsetupRoot.loginHandler.getUserInfo()
        self.tableView.reloadData()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["carlosrodriguezguerreroios@gmail.com"])
            mail.setMessageBody("<p>\(AppStrings.EMAIL_IDEA)</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert  todo......
//            let alert = UIAlertController(title: AppStrings.MANAGE_PARTNER, message: AppStrings.SETUP_PARTNER_QUESTION, preferredStyle: .actionSheet) // 1
//            let firstAction = UIAlertAction(title: AppStrings.SCAN_QR, style: .default) { (alert: UIAlertAction!) -> Void in
//                self.ScanQRCode()
//            } // 2
//            let secondAction = UIAlertAction(title: AppStrings.SHOW_QR, style: .default) { (alert: UIAlertAction!) -> Void in
//                self.ShowQR()
//            } // 3
//            let cancel = UIAlertAction(title:  AppStrings.CANCEL, style: .cancel) { (alert: UIAlertAction!) -> Void in
//            } // 3
//            alert.addAction(firstAction) // 4
//            alert.addAction(secondAction)
//            alert.addAction(cancel)
//            //            present(alert, animated: true, completion:nil) // 6
//            alert.popoverPresentationController?.sourceView = self.tableView.cellForRow(at: indexPath) // works for both iPhone & iPad
//
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    //MARK:- ScrollViewDElegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {

        case 0:
//            userCell
            var cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileHeaderTVCell", for: indexPath) as? UserProfileHeaderTVCell
            if (cell == nil){ cell = UserProfileHeaderTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.SetupImage(userInfo!.profile_image)
            cell?.setupUI(userInfo!.name)
            return cell!
        case 1:
            //            Partner
            var cell = tableView.dequeueReusableCell(withIdentifier: "ManagePartnerTVCell", for: indexPath) as? ManagePartnerTVCell
            if (cell == nil){ cell = ManagePartnerTVCell() }
            cell?.parentVC = self
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            var coupleFlag : Bool?
            if userInfo!.couple_id == "-1"{
                coupleFlag = false
            }else{
                 coupleFlag = true
            }
            logger.log("searching for the coumple\(userInfo!.couple_id)")
            cell?.SetupHiddenViews(coupleFlag!, CoupleId: userInfo!.couple_id)
            return cell!
        case 2:
//            changeBabyGender
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionsTVCell", for: indexPath) as? ProfileOptionsTVCell
            if (cell == nil){ cell = ProfileOptionsTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.setupUI("ic_child_care", optionTitle: AppStrings.CHANGE_YOUR_BABY_GENDER)
            return cell!
        case 3:
            //About US
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionsTVCell", for: indexPath) as? ProfileOptionsTVCell
            if (cell == nil){ cell = ProfileOptionsTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.setupUI("ic_info", optionTitle: AppStrings.ABOUT_US)
            return cell!
        case 4:
            //Share us
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionsTVCell", for: indexPath) as? ProfileOptionsTVCell
            if (cell == nil){ cell = ProfileOptionsTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.setupUI("ic_share", optionTitle: AppStrings.SHARE)
            return cell!
            
        case 5:
            //Rate us
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionsTVCell", for: indexPath) as? ProfileOptionsTVCell
            if (cell == nil){ cell = ProfileOptionsTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.setupUI("ic_thumb_up", optionTitle: AppStrings.RATE_US)
            return cell!
        case 6:
            //Comments
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionsTVCell", for: indexPath) as? ProfileOptionsTVCell
            if (cell == nil){ cell = ProfileOptionsTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.setupUI("ic_message", optionTitle: AppStrings.ADD_COMMENT)
            return cell!
            
        case 7:
            //Licenses
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionsTVCell", for: indexPath) as? ProfileOptionsTVCell
            if (cell == nil){ cell = ProfileOptionsTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.setupUI("ic_book", optionTitle: AppStrings.LICENSES)
            return cell!
            
        default:
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionsTVCell", for: indexPath) as? ProfileOptionsTVCell
            if (cell == nil){ cell = ProfileOptionsTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // logOut
            // create the alert
            let alert = UIAlertController(title: AppStrings.LOGOUT_GOODBYE, message: AppStrings.LOGOUT_MESSAGES, preferredStyle: UIAlertControllerStyle.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: AppStrings.LOG_OUT, style: UIAlertActionStyle.destructive, handler: { action in
                weak var weakSelf:UserProfileVC! = self
                self.loginHandler.clearUserSession()
                
                
//                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginNavC") as! LoginNavC
//                UIApplication.shared.keyWindow?.rootViewController = viewController
//
//
                
                
               weakSelf.appDelegate.AppsetupRoot.displayWindowsAccordingSession()
            }))
            alert.addAction(UIAlertAction(title: AppStrings.CANCEL, style: UIAlertActionStyle.cancel, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        case 1:
            let alert = UIAlertController(title: AppStrings.MANAGE_PARTNER, message: AppStrings.SETUP_PARTNER_QUESTION, preferredStyle: .actionSheet) // 1
            let firstAction = UIAlertAction(title: AppStrings.SCAN_QR, style: .default) { (alert: UIAlertAction!) -> Void in
                self.ScanQRCode()
            } // 2
            let secondAction = UIAlertAction(title: AppStrings.SHOW_QR, style: .default) { (alert: UIAlertAction!) -> Void in
                self.ShowQR()
            } // 3
            let cancel = UIAlertAction(title:  AppStrings.CANCEL, style: .cancel) { (alert: UIAlertAction!) -> Void in
            } // 3
            alert.addAction(firstAction) // 4
            alert.addAction(secondAction)
            alert.addAction(cancel)
//            present(alert, animated: true, completion:nil) // 6
            alert.popoverPresentationController?.sourceView = self.tableView.cellForRow(at: indexPath) // works for both iPhone & iPad
            
            present(alert, animated: true) {
                print("option menu presented")
            }
        case 2:
            print("change gender")
            let vc: SelectGenderViewController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
            vc?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            vc!.completion = { (component) in
                print(component)
                genderSingleton.actualGender.gender = component
                genderSingleton.actualGender.genderHasBeenChange = true
                let defaults = UserDefaults.standard
                defaults.set( component, forKey: Constants.UserDefaultsKeys.Gender.rawValue)
                defaults.synchronize()
//                make a listener for all the scenes
                
            }
            self.present(vc!, animated: false, completion: {
                
            })
            
        case 3:
            let vc: AboutUSViewController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
            self.pushViewController(vc!)
//            pushViewController(vc!, animated: true)
            
        case 4:
            print("Share")
            self.shareHelper.shareString(fromViewController: self, andMessage: AppStrings.EMAIL_INFO)
            
        case 5:
            print("rate us")
            let appID = "576235401"
            //    let urlStr = "itms-apps://itunes.apple.com/app/id\(appID)" // (Option 1) Open App Page
            let urlStr = "itms-apps://itunes.apple.com/app/viewContentsUserReviews?id=\(appID)" // (Option 2) Open App Review Tab
            
            if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            
        case 6:
            print("comment us")
            self.sendEmail()
        case 7:
            print("licenses")
            let vc: LicensesVC? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
            self.pushViewController(vc!)
            
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
           return 75
        case 1:
            return 75
        default:
            return 60
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        self.navigationController?.navigationBar.prefersLargeTitles = false
       
    }


    func ShowQR()  {
        
        let vc: ShowQRViewController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
        vc?.ID = self.userInfo!.id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func ScanQRCode()  {
      
        let vc: ScanerViewController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
