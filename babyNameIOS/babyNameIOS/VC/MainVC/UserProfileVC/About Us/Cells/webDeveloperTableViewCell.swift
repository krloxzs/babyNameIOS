//
//  webDeveloperTableViewCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/15/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import Lottie

class webDeveloperTableViewCell: UITableViewCell {
    @IBOutlet weak var viewForAnimation: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let animation1: LOTAnimationView = LOTAnimationView(name: "animated_laptop_")
        animation1.frame = self.viewForAnimation.frame
        animation1.animationSpeed = 0.5
        animation1.contentMode = .scaleAspectFill
        animation1.play()
        animation1.loopAnimation = true
        viewForAnimation.addSubview(animation1)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
