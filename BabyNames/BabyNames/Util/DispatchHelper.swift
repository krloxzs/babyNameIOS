//
//  DispatchHelper.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/7/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//
import Foundation

struct Run
{
    typealias Block = () ->()
    
    static func onMain(_ sync: Bool = false, block: @escaping Block)
    {
        let queue = DispatchQueue.main
        queue.async(execute: block)
    }
    
    static func inBackground(_ name: String = "com.baby",  block: @escaping Block)
    {
        //        let queue_attr = DispatchQoS(_FIXME_useThisWhenCreatingTheQueueAndRemoveFromThisCall: DispatchQueue.Attributes(), qosClass: DispatchQoS.QoSClass.background, relativePriority: 0)
        //        let queue = DispatchQueue(label: name, attributes: queue_attr)
        //        queue.async(execute: block)
        //
        
        _ = DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 0)
        let queue = DispatchQueue(label: name, attributes: .concurrent)
        queue.async(execute: block)
   }
}
