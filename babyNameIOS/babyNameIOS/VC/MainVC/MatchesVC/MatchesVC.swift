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
        registerNibs()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getBabysFromDB()
    }
    
    func getBabysFromDB()  {
       
    }
    
    @objc func setMyPartner(sender: UIButton) {
        logger.log("ow yhea")
        tabBarController?.selectedIndex = 3
    }

    private func registerNibs() {
        
        // Register xib file.
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.keyboardDismissMode = .none
        self.tableView?.register(UINib(nibName: "noCoupleEmptyStateTableViewCell", bundle: nil), forCellReuseIdentifier: "noCoupleEmptyStateTableViewCell")
        self.tableView?.register(UINib(nibName: "ProfileOptionsTVCell", bundle: nil), forCellReuseIdentifier: "ProfileOptionsTVCell")
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "noCoupleEmptyStateTableViewCell", for: indexPath) as? noCoupleEmptyStateTableViewCell
        if (cell == nil){ cell = noCoupleEmptyStateTableViewCell() }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.parentVC = self
        cell?.setupAnim()
        cell?.setPartnerButton.tag = indexPath.row
        cell?.setPartnerButton.addTarget(self, action: #selector(self.setMyPartner(sender:)), for: UIControlEvents.touchUpInside)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return self.tableView.frame.height
        case 1:
            return 75
        default:
            return 60
        }
    }
    
    
}
