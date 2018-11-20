
import Foundation
import UIKit


class AppSetupRootVC {
    var window: UIWindow?
    let loginHandler = LoginHandler.sharedInstance
    init() {
        configureDependencies()
    }
    func configureDependencies() {
        logger.log("configureDependencies")
    }  
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        logger.log("installRootViewControllerIntoWindow")
        // self.window = window
        self.displayWindowsAccordingSession()
    }
    
    /**
     Validate if user has session and display window according of his status.
     */
    func displayWindowsAccordingSession() {
        if loginHandler.isAuthenticated() {
            self.configureDashboard(self.window!)
        }else {
            self.displayLogin(self.window!)
        }
    }
    
    fileprivate func configureDashboard(_ window: UIWindow) {
        //AlreadyLogin
            let tabbarController:MainTabBarController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
            window.rootViewController = tabbarController
    }
    
    fileprivate func displayLogin(_ window: UIWindow) {
        // LoginNavigationController
        logger.log("LoginNavC")
        let tabbarController:LoginNavC? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
        window.rootViewController = tabbarController
    }
    
}
