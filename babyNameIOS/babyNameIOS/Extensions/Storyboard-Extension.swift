//
//  Storyboard-Extension.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 19/05/16.
//  Copyright © 2016 Nutriwen. All rights reserved.
//


import Foundation
import UIKit

extension UIStoryboard {
    
    // Example of usage
    /*
     let vc: CategoriesViewController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: NSBundle.mainBundle()).instantiateVC()
     self.navigationController?.pushViewController(vc!, animated: true)
     */
    
    /// get a class name and demangle for classes in Swift
    func instantiateVC<T: UIViewController>() -> T? {
        
        if let name = NSStringFromClass(T.self).components(separatedBy: ".").last {
            return instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }
    
}
