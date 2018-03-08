//
//  MatchesVC.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 1/4/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import Cartography
import RealmSwift
import Realm
import Popover
class MatchesVC: BaseViewController,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables and Constants
    var userInfo: UserItem?
    var dataHelper: UserData = UserData()
    let loginHandler = LoginHandler.sharedInstance
    var loadingNotification: MBProgressHUD! = MBProgressHUD()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let realmData = realmHelper()
    let realm = try! Realm()
    var popover : Popover? = nil
    var babys : Results<babyNameRO>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  AppStrings.MATCH
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.contentInsetAdjustmentBehavior = .never
        userInfo =  appDelegate.AppsetupRoot.loginHandler.getUserInfo()
        registerNibs()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getBabysFromDB()
        self.tableView.reloadData()
    }
    
    func getBabysFromDB()  {
        
        self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.loadingNotification.mode = MBProgressHUDMode.indeterminate
        self.loadingNotification.labelText = AppStrings.LOADING
        self.dataHelper.getMatches(success: { (JSON) in
            logger.log(self.dataHelper.MatchesArray.count)
            logger.log(self.dataHelper.MatchesArray.first?.name)
            self.tableView.reloadData()
             MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        }) { (String) in
             MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        }
    }
    
    @objc func setMyPartner(sender: UIButton) {
        tabBarController?.selectedIndex = 3
    }

    private func registerNibs() {
        
        // Register xib file.
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.keyboardDismissMode = .none
         self.tableView?.register(UINib(nibName: "MatchTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchTableViewCell")
        self.tableView?.register(UINib(nibName: "noCoupleEmptyStateTableViewCell", bundle: nil), forCellReuseIdentifier: "noCoupleEmptyStateTableViewCell")
        self.tableView?.register(UINib(nibName: "emptyStateMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "emptyStateMatchesTableViewCell")
        self.tableView?.register(UINib(nibName: "ManagePartnerTVCell", bundle: nil), forCellReuseIdentifier: "ManagePartnerTVCell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
       //MARK:- Tableview delegates
    
  
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Comments
        if userInfo?.couple_id != "-1"{
            if dataHelper.MatchesArray.count > 0{
                let babyOBJ = dataHelper.MatchesArray[indexPath.row]
                switch babyOBJ.gender {
                case "male","female","unisex":
                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as? MatchTableViewCell
                    cell?.SetupCell(babyOBJ)
                    cell?.optionsButton.tag = indexPath.row
//                  cell?.optionsButton.addTarget(self, action: #selector(self.optionButtonPress(sender:)), for: UIControlEvents.touchUpInside)
                    return cell!
                // ads
                default:
                   let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as? MatchTableViewCell
                   return cell!
                }
            }else{
                var cell = tableView.dequeueReusableCell(withIdentifier: "emptyStateMatchesTableViewCell", for: indexPath) as? emptyStateMatchesTableViewCell
                if (cell == nil){ cell = emptyStateMatchesTableViewCell() }
                cell?.selectionStyle = UITableViewCellSelectionStyle.none
                cell?.parentVC = self
                cell?.setupAnim()
                return cell!
            }
        }else{
            //            no couple...never
            var cell = tableView.dequeueReusableCell(withIdentifier: "noCoupleEmptyStateTableViewCell", for: indexPath) as? noCoupleEmptyStateTableViewCell
            if (cell == nil){ cell = noCoupleEmptyStateTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.parentVC = self
            cell?.setupAnim()
            cell?.setPartnerButton.tag = indexPath.row
            cell?.setPartnerButton.addTarget(self, action: #selector(self.setMyPartner(sender:)), for: UIControlEvents.touchUpInside)
            return cell!
        }
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userInfo?.couple_id != "-1"{
            if dataHelper.MatchesArray.count > 0{
                  return dataHelper.MatchesArray.count
            }else{
                return 1
            }
        }else{
//            no couple...never
             return 1
        }
       
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if userInfo?.couple_id != "-1"{
            if dataHelper.MatchesArray.count > 0{
                 return self.tableView.frame.height / 3
            }else{
                return self.tableView.frame.height
            }
        }else{
            return self.tableView.frame.height
        }
    }
    
    
}
