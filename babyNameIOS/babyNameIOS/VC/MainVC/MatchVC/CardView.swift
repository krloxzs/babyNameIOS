//
//  CardView.swift
//  ZLSwipeableViewSwiftDemo
//
//  Created by Zhixuan Lai on 5/24/15.
//  Copyright (c) 2015 Zhixuan Lai. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func initWithInfo(_ babyObject: NameObject) {
        self.nameLabel.text = babyObject.name
        switch babyObject.type {
        case "male":
            self.mainView.backgroundColor   = UIColor(hex: Constants.Colors.maleColor.rawValue)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.maleColor.rawValue)
            logger.log("male")
        case "female":
            self.mainView.backgroundColor   = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            logger.log("female")
        case "unisex":
            self.mainView.backgroundColor   = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            logger.log("unisex")
        default:
            break
        }

    }

    func setup() {
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        // Corner Radius
        layer.cornerRadius = 10.0;
    }
}
