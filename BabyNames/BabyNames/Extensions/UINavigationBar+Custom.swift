//
//  UINavigationBar+Custom.swift
//  Wissen
//
//  Created by Tejuino developers on 19/08/16.
//  Copyright © 2016 Tejuino developers. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func setTransparent() {
        self.setBackgroundImage(UIImage(), for: .default);
        self.shadowImage = UIImage();
        self.isTranslucent = true;
    }
    
    func customTitleFont() {
        if let font = UIFont(name: "VarelaRound-Regular", size: 19.0) {
            self.titleTextAttributes = [NSAttributedString.Key.font: font,
                                        NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }

}
