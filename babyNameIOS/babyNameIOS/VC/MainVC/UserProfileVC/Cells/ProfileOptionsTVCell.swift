//
//  ProfileOptionsTVCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/12/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class ProfileOptionsTVCell: UITableViewCell {

    @IBOutlet weak var optionTitle: UILabel!
    @IBOutlet weak var optionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupUI(_ ImageName: String, optionTitle: String)  {
        self.optionTitle.text = optionTitle
        let origImage = UIImage(named: ImageName)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        
        self.optionButton.setImage(tintedImage, for: .normal)
        self.optionButton.tintColor = UIColor(hex: Constants.Colors.NavBarBGColor.rawValue)
        self.optionButton.imageView?.tintColor = UIColor(hex: Constants.Colors.NavBarBGColor.rawValue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
