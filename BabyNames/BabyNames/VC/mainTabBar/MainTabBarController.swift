//
//  MainTabBarController.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/11/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(hex: Constants.Colors.NavBarBGColor.rawValue)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let items = tabBar.items else { return }  // MARK: - Navigation
        items[0].title = AppStrings.MAKE_MATCH_TITLE
        items[1].title = AppStrings.MATCH
        items[2].title = AppStrings.FAVOURITES_TITLE
        items[3].title = AppStrings.PROFILE_TITLE
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
