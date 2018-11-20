//
//  AdversimentClass.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 3/4/18.
//  Copyright © 2018 Carlos Rodriguez. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class interstitialAdversimentClass:NSObject, GADInterstitialDelegate{
//  test   ca-app-pub-3940256099942544/4411468910
//    live ca-app-pub-6757248911161141/9658333915
    var parentVC: UIViewController?
    var interstitial: GADInterstitial!
    
    override init() {
        super.init()
        #if DEBUG
            //            sample admod app id
            interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910") // her you add th unit id
            interstitial = createAndLoadInterstitial()
        #else
            interstitial = GADInterstitial(adUnitID: "ca-app-pub-6757248911161141/9658333915") // her you add th unit id
            interstitial = createAndLoadInterstitial()
        #endif
        
    }
    
    func loadAdversiment() {
        if interstitial.isReady{
            interstitial.present(fromRootViewController: self.parentVC!)
           
        }else{
//            for some reaseon ad in not ready....
            
        }
    }
    
    
    func createAndLoadInterstitial() -> GADInterstitial {
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
       self.loadAdversiment()
        
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
