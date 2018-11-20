//
//  AppDelegate.swift
//  BabyNames
//
//  Created by Carlos Rodriguez on 11/10/18.
//  Copyright © 2018 CarlosRG. All rights reserved.
//


import UIKit
import CoreData
import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import AdSupport
import GoogleMobileAds


var logger:GULogger = GULogger("DEBUG>> ")
let values = Bundle.contentsOfFile(plistName: "MyData.plist")

let urlBase: String! = values[Constants.Settings.service_keys.BASE_URL.rawValue]  as! String

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let AppsetupRoot = AppSetupRootVC()
    let realmDBHelper = realmHelper()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var urlString  = ""
        #if DEBUG
        //            sample admod app id
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")
        urlString = "https://StagingURL"
        #else
        //            liveStrings
        urlString = "https://productionURL"
        GADMobileAds.configure(withApplicationID: "ca-app-pub-6757248911161141~4944175232")
        
        #endif
        
        self.realmDBHelper.migrateBD(migrationDone: {
            logger.log("DB is in the actual version")
        }) { (SchemeVersion: String) in
            logger.log("migrated from \(SchemeVersion) version")
        }
        print(urlString)
        
        PlistManager.sharedInstance.startPlistManager()
        AppsetupRoot.window = window
        AppsetupRoot.installRootViewControllerIntoWindow(window!)
        
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
           FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
      
    }


}

