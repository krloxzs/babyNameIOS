//
//  ManagePartnerTVCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/12/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import SwiftDate
import SwiftyJSON
import Alamofire

class ManagePartnerTVCell: UITableViewCell {
    @IBOutlet weak var ManagePartnerView: UIView!
    @IBOutlet weak var viewForPartner: UIView!
    @IBOutlet weak var addYourPartnerLabel: UILabel!
    @IBOutlet weak var managePartnerLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var viewForRounded: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var dataHelper: UserData = UserData()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIImage()
        self.addYourPartnerLabel.text    =  AppStrings.ADD_PARTNER
        self.managePartnerLabel.text     =  AppStrings.MANAGE_PARTNER
        // Initialization code
    }
    func SetupHiddenViews(_ haveApartner: Bool, CoupleId :String)  {
        if haveApartner{
            self.viewForPartner.isHidden = false
            self.ManagePartnerView.isHidden = true
            self.dataHelper.GetCouple(CoupleId, success: { (info:UserInformation) in
                UIView.animate(withDuration: 0.1, animations: {
                     self.nameLabel.text = info.name
                }, completion: nil)
//                self.managePartnerLabel.text = 
                self.SetupImage(info.profile_image)
            }, failure: { (ErrorString:String) in
                
            })
        }else{
             self.ManagePartnerView.isHidden = false
             self.viewForPartner.isHidden = true
            
        }
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
                                            UIView.animate(withDuration: 0.1, animations: {
                                                self.profileImage.contentMode = .scaleAspectFill
                                                self.profileImage.clipsToBounds = true
                                            }, completion: nil)
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
