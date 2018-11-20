//
//  MatchTableViewCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 1/7/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import UIKit
import UIKit
import Realm
import RealmSwift

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewForRounded: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var fotterView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var meaningInfo: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewForRounded.layer.cornerRadius = 16
        self.meaningLabel.text = AppStrings.MEANING
        // Initialization code
    }

    func SetupCell(_ babyOBJ : NameObject)  {
        switch babyOBJ.gender {
        case "male":
            self.meaningLabel.textColor         = UIColor(hex: Constants.Colors.maleColor.rawValue)
            self.fotterView.backgroundColor      = UIColor(hex: Constants.Colors.maleColor.rawValue).withAlphaComponent(0.5)
            self.headerView.backgroundColor  = UIColor(hex: Constants.Colors.maleColor.rawValue)
            self.meaningInfo.text = babyOBJ.meaning
            self.nameLabel.text = babyOBJ.name
            self.iconImage.image = UIImage(named:"\(babyOBJ.image)")
        case "female":
            self.meaningLabel.textColor    = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            self.fotterView.backgroundColor   = UIColor(hex: Constants.Colors.femaleColor.rawValue).withAlphaComponent(0.5)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            self.meaningInfo.text = babyOBJ.meaning
            self.nameLabel.text = babyOBJ.name
            self.iconImage.image = UIImage(named:"\(babyOBJ.image)")
        case "unisex":
            self.meaningLabel.textColor    = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            self.fotterView.backgroundColor   = UIColor(hex: Constants.Colors.neutralColor.rawValue).withAlphaComponent(0.5)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            self.meaningInfo.text = babyOBJ.meaning
            self.nameLabel.text = babyOBJ.name
            self.iconImage.image = UIImage(named:"\(babyOBJ.image)")
        default:
            break
        }
        
        
    }
    func reuseIdentifierString() -> String {
        return "MatchTableViewCell"
    }
    
}
