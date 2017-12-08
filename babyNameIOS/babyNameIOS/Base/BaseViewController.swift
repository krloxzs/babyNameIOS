//
//  BaseViewController.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 19/05/16.

//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    enum NavigationBackButton: Int {
        case navigationBackButtonNone
        case navigationBackButtonDefault
        case navigationBackButtonX
    }
    
    enum NavigationBarType: Int {
        case navigationBarTypeDefault
        case navigationBarTypeHidden
    }
    
    /// Navigation Back Button Style
    var navigationBackButton: NavigationBackButton = .navigationBackButtonNone
    
    /// Navigation Bar Type of current view
    var navigationBarType: NavigationBarType = .navigationBarTypeDefault
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // User Interface
        setupUserInterface()
        
    }
    
    // Before rendering - UI
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareActionsForView()
        
    }
    
    // Almost render actions - Network calls.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:-
    
    @objc func back(_ sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
         _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Default funcionality
    func showErrorLandingPage(_ notification: Notification) {
        logger.log(":::::::: showErrorLandingPage   ::::::::::::")
    }
    
    fileprivate func prepareActionsForView() {
        // Reset UI
        resetButtonsItems()
        
        switch self.navigationBackButton {
        case .navigationBackButtonNone:
            // None
            break
        case .navigationBackButtonDefault:
            
            //
            setBackButtonBy("close")
            
            break
            
        case .navigationBackButtonX:
            
            //
            setBackButtonBy("close")
            
            break
            
        }
        
        switch self.navigationBarType {
        case .navigationBarTypeDefault:
            self.navigationController?.isNavigationBarHidden = false
//            self.navigationController?.navigationBar.setTransparent()
//            self.navigationController?.navigationBar.customTitleFont()
            break
            
        case .navigationBarTypeHidden:
            self.navigationController?.isNavigationBarHidden = true
//            self.navigationController?.navigationBar.setTransparent()
//            self.navigationController?.navigationBar.customTitleFont()
            break
        }
    }
    
    fileprivate func setupUserInterface() {
        
        // TabBar Background
        //uncommit for color
        //UINavigationBar.appearance().backgroundColor = UIColor(hex: Constants.Colors.tabBarBackground.rawValue)
        UINavigationBar.appearance().barTintColor = UIColor(hex: Constants.Colors.tabBarBackground.rawValue)
       
        // Title
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(hex: Constants.Colors.tabBarTitleColor.rawValue)]
        
        //
       // UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController?.navigationBar.setTransparent()
//        self.navigationController?.navigationBar.customTitleFont()
  
        
    }
    
    fileprivate func setBackButtonBy(_ imgBackButton: String) {
        let backButton: UIButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "close"), for: UIControlState())
        backButton.addTarget(self, action: #selector(BaseViewController.back(_:)), for: .touchUpInside)
        
        backButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        backButton.imageView?.contentMode = .scaleAspectFit
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    // MARK:- Default Behavior
    fileprivate func resetButtonsItems() {
        
        leftButtonItems()
        
        rightButtonItems()
        
    }
    
    fileprivate func leftButtonItems() {
        self.navigationItem.leftBarButtonItems = []
    }
    
    fileprivate func rightButtonItems() {
        self.navigationItem.rightBarButtonItems = []
    }
    
    
}

