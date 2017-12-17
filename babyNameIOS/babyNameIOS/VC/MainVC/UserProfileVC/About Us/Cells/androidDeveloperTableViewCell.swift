//
//  androidDeveloperTableViewCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/15/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import Lottie

class androidDeveloperTableViewCell: UITableViewCell {
    @IBOutlet weak var viewForAnimation: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
     
        // Initialization code
    }
    func setup()   {
        let animation1: LOTAnimationView = LOTAnimationView(name: "android")
        animation1.frame =  CGRect(x: 0, y: 0, width: (self.contentView.frame.width / 10) * 3 , height: 120 )
        animation1.animationSpeed = 1
        animation1.contentMode = .scaleAspectFill
        animation1.play()
        animation1.loopAnimation = true
        viewForAnimation.addSubview(animation1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
