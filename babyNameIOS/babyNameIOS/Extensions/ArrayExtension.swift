//
//  ArrayExtension.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 1/3/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import Foundation
extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
