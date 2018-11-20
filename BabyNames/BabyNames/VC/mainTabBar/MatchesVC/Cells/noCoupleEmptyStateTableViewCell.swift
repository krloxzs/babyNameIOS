//
//  noCoupleEmptyStateTableViewCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 1/4/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import UIKit
import Lottie

class noCoupleEmptyStateTableViewCell: UITableViewCell {
    @IBOutlet weak var viewForAnimate: UIView!
    @IBOutlet weak var viewForRoundede: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    @IBOutlet weak var setPartnerButton: UIButton!
    
    var parentVC : MatchesVC?
    let animation1: LOTAnimationView = LOTAnimationView(name: "drink")
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupAnim()  {
        self.setPartnerButton.setTitle(AppStrings.SET_MY_PARTNER, for: .normal)
        titleLabel.text = AppStrings.NO_COUPLE_EMPTY_STATE_TITLE
        infoLabel.text = AppStrings.NO_COUPLE_EMPTY_STATE_INFO
        let animationView: LOTAnimationView?
        animationView = animation1
        animationView!.contentMode = .scaleAspectFit
        animationView!.frame = CGRect(x: 0, y: 0, width: parentVC!.view.frame.width , height: parentVC!.view.frame.width )
        animationView!.animationSpeed = 0.3
        animationView!.play()
        animationView!.loopAnimation = true
        viewForAnimate.addSubview(animationView!)
    }
    
    func reuseIdentifierString() -> String {
        return "noCoupleEmptyStateTableViewCell"
    }
    
}
