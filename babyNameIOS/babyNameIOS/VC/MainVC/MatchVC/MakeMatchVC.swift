//
//  MakeMatchVC.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/11/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON

class MakeMatchVC: BaseViewController {
    //MARK:- Variables and Constants
    /// User information
    var userInfo: UserItem?
    var dataHelper: UserData = UserData()
    let loginHandler = LoginHandler.sharedInstance
    var loadingNotification: MBProgressHUD! = MBProgressHUD()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Baby Names"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        SetBabyGender()
        // Do any additional setup after loading the view.
    }
    
    func SetBabyGender()  {
        let vc: SelectGenderViewController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
        vc?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        vc!.completion = { (component) in
            print(component)
            self.getBabynameFromServer()
        }
        self.present(vc!, animated: false, completion: {
            
        })
    }
    
    func getBabynameFromServer() {
        self.dataHelper.getBabyNames(success: { (Res:JSON) in
            
        }) { (ErrorSttring:String) in
            
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
