//
//  UIColor-Extension.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 19/05/16.
//  Copyright © 2016 Nutriwen. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}


extension UIButton{

    func setImageViewTintWhite(imageView: UIImageView)->Void{
        if let image = imageView.image {
            imageView.image = image.withRenderingMode(UIImageRenderingMode .alwaysTemplate)
            imageView.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
    }

}
