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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        userInfo = appDelegate.AppsetupRoot.loginHandler.getUserInfo()
        // Do any additional setup after loading the view.
    }
    func setupTV() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.keyboardDismissMode = .none
        self.tableView?.register(UINib(nibName: "UserProfileHeaderTVCell", bundle: nil), forCellReuseIdentifier: "UserProfileHeaderTVCell")
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("mmmmm")
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("aaaaa")
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileHeaderTVCell", for: indexPath) as? UserProfileHeaderTVCell
        if (cell == nil){ cell = UserProfileHeaderTVCell() }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.SetupImage(userInfo!.profile_image)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.height / 10
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
