//
//  FavCollectionViewCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/28/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
class FavCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewForRounded: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var optionsButton: UIButton!
    @IBOutlet weak var fotterView: UIView!
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var meaningInfo: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
//    let maleIcons = ["Ball","Bathtub","Bib","Bird","Socks","Submarine","Whale"]
//    let femaleIcons = ["Apple","Bear","Butterfly","Cow","Feet","Heart","Pig"]
//    let unisexIcons = ["Cake","Candy","Cutlery","Diaper","Dog","Duck","Gift","Rattle","Sleepsuit"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewForRounded.layer.cornerRadius = 16
        self.meaningLabel.text = AppStrings.MEANING
        // Initialization code
    }
    
    func SetupCell(_ babyOBJ : babyNameRO)  {
        switch babyOBJ.gender {
        case "male":
            self.meaningLabel.textColor         = UIColor(hex: Constants.Colors.maleColor.rawValue)
            self.fotterView.backgroundColor      = UIColor(hex: Constants.Colors.maleColor.rawValue).withAlphaComponent(0.5)
            self.headerView.backgroundColor  = UIColor(hex: Constants.Colors.maleColor.rawValue)
            self.meaningInfo.text = babyOBJ.meaning
            self.nameLabel.text = babyOBJ.name
        case "female":
            self.meaningLabel.textColor    = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            self.fotterView.backgroundColor   = UIColor(hex: Constants.Colors.femaleColor.rawValue).withAlphaComponent(0.5)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            self.meaningInfo.text = babyOBJ.meaning
            self.nameLabel.text = babyOBJ.name
        case "unisex":
            self.meaningLabel.textColor    = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            self.fotterView.backgroundColor   = UIColor(hex: Constants.Colors.neutralColor.rawValue).withAlphaComponent(0.5)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            self.meaningInfo.text = babyOBJ.meaning
            self.nameLabel.text = babyOBJ.name
        default:
            break
        }
        
        
    }
    func reuseIdentifierString() -> String {
        return "FavCollectionViewCell"
    }
}
