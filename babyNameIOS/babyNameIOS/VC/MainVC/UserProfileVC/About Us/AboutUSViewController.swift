//
//  AboutUSViewController.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/13/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class AboutUSViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let loginHandler = LoginHandler.sharedInstance
    var userInfo: UserItem?
    
    override func viewDidLoad() {
        self.title = "BabyNames \(self.version())"
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeDefault
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setupTV()
        // Do any additional setup after loading the view.
    }
    func setupTV() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.keyboardDismissMode = .none
        
         self.tableView?.register(UINib(nibName: "logoForAboutTableViewCell", bundle: nil), forCellReuseIdentifier: "logoForAboutTableViewCell")
        self.tableView?.register(UINib(nibName: "iosDeveloperTableViewCell", bundle: nil), forCellReuseIdentifier: "iosDeveloperTableViewCell")
        self.tableView?.register(UINib(nibName: "androidDeveloperTableViewCell", bundle: nil), forCellReuseIdentifier: "androidDeveloperTableViewCell")
        self.tableView?.register(UINib(nibName: "webDeveloperTableViewCell", bundle: nil), forCellReuseIdentifier: "webDeveloperTableViewCell")
         self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        return "\(version)"
    }
    
    //MARK:- ScrollViewDElegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            // IOS developer
            var cell = tableView.dequeueReusableCell(withIdentifier: "logoForAboutTableViewCell", for: indexPath) as? logoForAboutTableViewCell
            if (cell == nil){ cell = logoForAboutTableViewCell() }
            cell?.parentVC = self
            cell?.setAnimation()
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
        case 1:
            // IOS developer
            var cell = tableView.dequeueReusableCell(withIdentifier: "iosDeveloperTableViewCell", for: indexPath) as? iosDeveloperTableViewCell
            if (cell == nil){ cell = iosDeveloperTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
            
        case 2:
            // IOS developer
            var cell = tableView.dequeueReusableCell(withIdentifier: "androidDeveloperTableViewCell", for: indexPath) as? androidDeveloperTableViewCell
            if (cell == nil){ cell = androidDeveloperTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.setup()
            return cell!
        case 3:
            // IOS developer
            var cell = tableView.dequeueReusableCell(withIdentifier: "webDeveloperTableViewCell", for: indexPath) as? webDeveloperTableViewCell
            if (cell == nil){ cell = webDeveloperTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            return cell!
            
            
        
        default:
            var cell = tableView.dequeueReusableCell(withIdentifier: "logoForAboutTableViewCell", for: indexPath) as? logoForAboutTableViewCell
            if (cell == nil){ cell = logoForAboutTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell!
        }
    }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return self.tableView.frame.height / 2.5
            
        default:
            return 120
        }
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
