//
//  ShareManager.swift
//  Favly
//
//  Created by MCS on 9/5/17.
//  Copyright © 2017 Favly, Inc. All rights reserved.
//

import UIKit
import Contacts
import Realm
import RealmSwift
import Foundation

class ShareManager{

  func shareString(fromViewController view:UIViewController, andMessage message:String){
    // set up activity view controller
    let textToShare = [ message ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = view.view // so that iPads won't crash

    // exclude some activity types from the list (optional)
    activityViewController.excludedActivityTypes = [ .airDrop, .postToFacebook, .mail, .postToTwitter, .message, .saveToCameraRoll ]

    // present the view controller
    view.present(activityViewController, animated: true, completion: nil)
  }


//  // share image
//  func sharePulsePost(fromViewController view:UIViewController,BIZNAME bizName:String, andUrl url:String) {
//
//    // set up activity view controller
//    let pulseMessage = "Hi there! I'd like you to check out this post from \(bizName) on Favly. Click here to view their post: \n"
//    let pulseMessage2 = "\nFavly is a community focused on sharing personal recommendations. Visit Favly.com to learn more"
//    let imageToShare:Array = [ pulseMessage,url, pulseMessage2 ]
//    let x = FavlyUIActivity()
//    x.x = 1
//    let applicationActivities = [x]
//    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: applicationActivities)
//    activityViewController.popoverPresentationController?.sourceView = view.view // so that iPads won't crash
//
//    // exclude some activity types from the list (optional)
//   // activityViewController.excludedActivityTypes = [ .airDrop, .postToFacebook, .mail, .postToTwitter, .message, .saveToCameraRoll]
//
//    // present the view controller
//     view.present(activityViewController, animated: true, completion: nil)
//  }

  // share image
//  func shareBizProfile(fromViewController view:UIViewController, URL url:String,BIZNAME bizName:String , andImage image:UIImage) {
//
//    // set up activity view controller
//    let pulseMessage = "Hi there! I'd like you to check out \(bizName)  on Favly. Click here to view their profile: \n"
//    let pulseMessage2 = "\nFavly is a community focused on sharing personal recommendations. Visit Favly.com to learn more"
//    let imageToShare:Array = [ pulseMessage, url, pulseMessage2 ]
//
//    let x = FavlyUIActivity()
//    x.x = 2
//    let applicationActivities = [x]
//
//    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: applicationActivities)
//    activityViewController.popoverPresentationController?.sourceView = view.view // so that iPads won't crash
//
//    // exclude some activity types from the list (optional)
//   // activityViewController.excludedActivityTypes = [ .airDrop, .postToFacebook, .mail, .postToTwitter, .message, .saveToCameraRoll]
//
//    // present the view controller
//    view.present(activityViewController, animated: true, completion: nil)
//  }




//
//  func shareContact(fromViewController view:UIViewController, andContact contactx : CNContact) {
//    // Creating a mutable object to add to the contact
//
//    guard let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
//      return
//    }
//
//    var filename = NSUUID().uuidString
//
//    // Create a human friendly file name if sharing a single contact.
//      if let fullname = CNContactFormatter().string(from: contactx) {
//        filename = fullname.components(separatedBy: " ").joined(separator: "")
//      }
//
//
//    let fileURL = directoryURL
//      .appendingPathComponent(filename)
//      .appendingPathExtension("vcf")
//    do{
//      let data = try CNContactVCardSerialization.data(with: [contactx])
//      try data.write(to: fileURL,options: .atomicWrite)
//
//      let x = FavlyUIActivity()
//      x.x = 3
//      let applicationActivities = [x]
//
//
//      let activityViewController = UIActivityViewController(
//        activityItems: [fileURL],
//        applicationActivities: applicationActivities
//      )
//
//      view.present(activityViewController, animated: true, completion: {})
//    }catch{
//
//    }
//  }


}
