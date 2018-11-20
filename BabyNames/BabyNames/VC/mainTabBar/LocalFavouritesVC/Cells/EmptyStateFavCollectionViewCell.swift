//
//  EmptyStateFavCollectionViewCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 1/4/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import UIKit
import Lottie

class EmptyStateFavCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewForAnimate: UIView!
    @IBOutlet weak var viewForRoundede: UIView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var parentVC : FavouritesVC?
    
     let animation1: LOTAnimationView = LOTAnimationView(name: "empty_list")
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    func setupAnim()  {
    titleLabel.text = AppStrings.EMPTY_STATE_TITLE
    infoLabel.text = AppStrings.EMPTY_STATE_INFO
    let animationView: LOTAnimationView?
    animationView = animation1
    animationView!.contentMode = .scaleAspectFit
    animationView!.frame = CGRect(x: 0, y: 0, width: parentVC!.view.frame.width , height: viewForAnimate.frame.height )
    animationView!.animationSpeed = 0.5
    animationView!.play()
    animationView!.loopAnimation = true
    viewForAnimate.addSubview(animationView!)
    }

    func reuseIdentifierString() -> String {
        return "EmptyStateFavCollectionViewCell"
    }
    
}
