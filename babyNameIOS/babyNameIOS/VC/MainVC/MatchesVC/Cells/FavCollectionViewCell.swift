//
//  FavCollectionViewCell.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/28/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class FavCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewForRounded: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewForRounded.layer.cornerRadius = 16
        // Initialization code
    }
    func reuseIdentifierString() -> String {
        return "FavCollectionViewCell"
    }
}
