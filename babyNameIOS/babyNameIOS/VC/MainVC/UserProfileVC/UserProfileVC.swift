//
//  UserProfileVC.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/11/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class UserProfileVC: BaseViewController, UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    /// User information
    var userInfo: UserItem?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let loginHandler = LoginHandler.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        userInfo = appDelegate.AppsetupRoot.loginHandler.getUserInfo()
        // Do any additional setup after loading the view.
    }
    func setupTV() {
        self.title = AppStrings.PROFILE_TITLE
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.keyboardDismissMode = .none
        self.tableView?.register(UINib(nibName: "UserProfileHeaderTVCell", bundle: nil), forCellReuseIdentifier: "UserProfileHeaderTVCell")
        self.tableView?.register(UINib(nibName: "ProfileOptionsTVCell", bundle: nil), forCellReuseIdentifier: "ProfileOptionsTVCell")
        self.tableView?.register(UINib(nibName: "ManagePartnerTVCell", bundle: nil), forCellReuseIdentifier: "ManagePartnerTVCell")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    //MARK:- ScrollViewDElegates
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
       print(scrollView.contentOffset.x)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {

        case 0:
//            userCell
            var cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileHeaderTVCell", for: indexPath) as? UserProfileHeaderTVCell
            if (cell == nil){ cell = UserProfileHeaderTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.SetupImage(userInfo!.profile_image)
            return cell!
        case 1:
            //            Partner
            var cell = tableView.dequeueReusableCell(withIdentifier: "ManagePartnerTVCell", for: indexPath) as? ManagePartnerTVCell
            if (cell == nil){ cell = ManagePartnerTVCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            var coupleFlag : Bool?
            if userInfo!.couple_id == "-1"{
                coupleFlag = false
            }else{
                 coupleFlag = true
            }
            cell?.SetupHiddenViews(coupleFlag!)
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
//            logOut
            weak var weakSelf:UserProfileVC! = self
             self.loginHandler.clearUserSession()
             weakSelf.appDelegate.AppsetupRoot.displayWindowsAccordingSession()
            
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        if scrollView.contentOffset.y > 20{
            UIView.animate(withDuration: 0.1, animations: {
                self.navigationController?.navigationBar.prefersLargeTitles = false
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.1, animations: {
                 self.navigationController?.navigationBar.prefersLargeTitles = true
            }, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
