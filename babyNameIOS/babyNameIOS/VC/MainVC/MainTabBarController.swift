//
//  MainTabBarController.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/11/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(hex: Constants.Colors.NavBarBGColor.rawValue)
        // Do any additional setup after loading the view.
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