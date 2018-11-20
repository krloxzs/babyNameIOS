//
//  NSUserDefaults-Extension.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 19/05/16.
//  Copyright © 2016 Nutriwen. All rights reserved.
//

import Foundation


enum UnarchiverError: Error {
    case noKeyAssociated
}

extension UserDefaults {
    
    /// Get object from Unarchive (NSKeyedUnarchiver)
    func objectUnarchiverForKey<T: AnyObject>(forKey key: String) throws -> T? {
        
        if let savedPeople = self.object(forKey: key) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: savedPeople) as? T
        }else {
            throw UnarchiverError.noKeyAssociated
        }
    }
    
}
