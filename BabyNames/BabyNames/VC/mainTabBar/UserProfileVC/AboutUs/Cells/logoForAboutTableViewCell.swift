//
//  logoForAboutTableViewCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 3/11/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import Cartography
import RealmSwift
import Realm
import Lottie

class logoForAboutTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewForAnimation: UIView!
    
    var parentVC: AboutUSViewController?
        let animationNoMore: LOTAnimationView = LOTAnimationView(name: "empty_status")
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setAnimation()  {
        
        animationNoMore.contentMode = .scaleAspectFit
        animationNoMore.frame = CGRect(x: 0, y: 0, width: parentVC!.tableView.frame.width , height: self.viewForAnimation.frame.height)
        animationNoMore.animationSpeed = 0.5
        animationNoMore.play()
        animationNoMore.loopAnimation = true
        self.viewForAnimation.addSubview(animationNoMore)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
