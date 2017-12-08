//
//  GULogger.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 22/05/16.

//

import Foundation

class GULogger: NSObject {
    
    var prefix: String
    
    init(_ prefix: String)
    {
        self.prefix = prefix
        super.init()
    }
    
    convenience override init() {
        self.init(">> ")
    }
    
    
    func log<T>(_ object: T)
    {
        print("\(prefix) \(object)")
    }
    
}
