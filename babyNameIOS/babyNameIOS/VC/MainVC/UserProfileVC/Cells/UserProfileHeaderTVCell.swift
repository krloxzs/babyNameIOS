//
//  UserProfileHeaderTVCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/12/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import SDWebImage

class UserProfileHeaderTVCell: UITableViewCell {
    @IBOutlet weak var viewForRounded: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIImage()
        // Initialization code
    }
    
    func SetupImage(_ URLString : String)  {
//        let url : URL = URL(string : ("https://res.cloudinary.com/dsmlu4xhh/image/fetch/w_808,c_limit,e_sharpen:50/\(URLString)"))!
         let url : URL = URL(string : (URLString))!
//        print(url)
        let PlaceHolderImage = UIImage(named: "ic_account_circle")
        self.profileImage.sd_setShowActivityIndicatorView(true)
        self.profileImage.sd_setIndicatorStyle(.gray)
        self.profileImage.setImageInaBlock(withURLString: url,
                                        fromPlaceHolderImage: PlaceHolderImage!,
                                        forimage: self.profileImage,
                                        success: { (image:UIImage) in
                                            self.profileImage.contentMode = .scaleAspectFill
                                            self.profileImage.clipsToBounds = true
        }, failure: { (ErrorStringString) in
            
        })
    }

    func setupUIImage() {
        self.profileImage.layer.cornerRadius =  profileImage.frame.size.width / 2
        self.viewForRounded.layer.borderColor = UIColor.white.cgColor
        self.viewForRounded.layer.borderWidth = 2
        self.viewForRounded.layer.cornerRadius = viewForRounded.frame.size.width / 2
        self.viewForRounded.layer.masksToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
