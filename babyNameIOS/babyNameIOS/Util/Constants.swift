//
//  Constants.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 22/05/16.

import Foundation


enum Constants {
    
    /// All constants related to backend calls
    enum backendConstants: String {
       
        case LANG_DEFAULT = "esp"
        case DEFAULT_USER_IMAGE_URL = "http://"
        
    }
    
    enum Settings : String {
        
        /// Configuration Bundle name
        case configFileName = "configurations"
        /// Configuration Bundle file type
        case configFileType = "plist"
        
        /// Root value for all Settings for application
        case configRoot = "Root"
        
        enum service_keys: String {
            //a base url for all services
            case BASE_URL = "BASE_URL"
            
          
        }
        
        
        enum service_values: String {
            case describe = "describe"
            case method = "method"
            case value = "value"
        }
        
        enum service_constants: String {
            case session_id = "<<session_id>>"
            case id_question = "<<id_question>>"
            case lat = "<<lat>>"
            case lng = "<<lng>>"
            case id_user = "<<id_user>>"
            case place = "<<place>>"
            
        }
        
    }
    
    enum Storyboard: String {
        case Main = "Main"
        
        // Example of usage
        /*
         let vc: CategoriesViewController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: NSBundle.mainBundle()).instantiateVC()
         self.navigationController?.pushViewController(vc!, animated: true)
         */
    }
    
    enum ScrollDirection {
        case scrollDirectionNone
        case scrollDirectionRight
        case scrollDirectionLeft
        case scrollDirectionUp
        case scrollDirectionDown
        case scrollDirectionCrazy
    }
    
    enum UserDefaultsKeys: String {
       
        case UserObject = "UserObject"
        case UserId = "UserId"
        case UltimaHora = "ultimahora"
        case promos = "promos"
    }
    
    enum Colors: Int {
        case neutralColor           = 0xFFD479
        case femaleColor            = 0xFF2F92
        case maleColor              = 0x0096FF
        case NavBarBGColor          = 0x696BBD
        case tabBarBackground       = 0x177626
        case tabBarTitleColor       = 0x000000
        case collectionViewColor    = 0xf2f2f2
        case statusBar              = 0x23486C
        case backgroundFillColor    = 0x222222
        case fillcolor              = 0xFF0080
        case subTitleColorF          = 0x7E8B98
        
        
    }
}
