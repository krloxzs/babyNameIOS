//
//  keyboard-Extension.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 26/06/16.
//  Copyright © 2016 Nutriwen. All rights reserved.
//

import Foundation
import UIKit
// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
