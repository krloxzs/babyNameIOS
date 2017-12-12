//
//  ManagePartnerTVCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/12/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class ManagePartnerTVCell: UITableViewCell {
    @IBOutlet weak var ManagePartnerView: UIView!
    @IBOutlet weak var viewForPartner: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func SetupHiddenViews(_ haveApartner: Bool)  {
        if haveApartner{
           self.viewForPartner.isHidden = false
             self.ManagePartnerView.isHidden = true
        }else{
            self.ManagePartnerView.isHidden = false
             self.viewForPartner.isHidden = true
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
