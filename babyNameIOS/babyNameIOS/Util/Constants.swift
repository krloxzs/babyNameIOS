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
            
            case LOGIN_BY_EMAIL = "LOGIN_BY_EMAIL"
            
            case SEND_SUGGEST = "SEND_SUGGEST"
            
            case REGISTER_BY_EMAIL = "REGISTER_BY_EMAIL"
            
            case VINCULAR_CUENTA = "VINCULAR_CUENTA"
            
            case RECOVER_LOGIN = "RECOVER_LOGIN"
            
            case GET_FILTERS = "GET_FILTERS"
            
            case GET_HORARIOS = "GET_HORARIOS"
            
            case GET_LEVELS_URL = "GET_LEVELS_URL"
            
            case RECOVER_REQUEST = "RECOVER_REQUEST"
            
            case GET_PROFESORS = "GET_PROFESORS"
            
            case GET_CATEGORIES = "GET_CATEGORIES"
            
            case GET_PROGAMS_CLASSES = "GET_PROGAMS_CLASSES"
            
            case CANCEL_CLASS = "CANCEL_CLASS"
            
            case DESVINCULAR = "DESVINCULAR"
            
            case GET_VINCULATED_ACCOUNTS = "GET_VINCULATED_ACCOUNTS"
            
            case GET_DISP = "GET_DISP"
            
            case REGISTER = "REGISTER"
            
            case PROGRAM_CLASS = "PROGRAM_CLASS"
            
            case UPDATE_CLASS = "UPDATE_CLASS"
            
            case GET_PAYMENT_METHOD = "GET_PAYMENT_METHOD"
            
            case SEND_TOKEN_REFRESH = "SEND_TOKEN_REFRESH"
            
            case GET_CLASS_BY_ID = "GET_CLASS_BY_ID"
            
            case GET_HISTORIAL = "GET_HISTORIAL"
            
            case GET_CREDITS_NUMBER = "GET_CREDITS_NUMBER"
            
            case BUY_CREDITS = "BUY_CREDITS"
            
            case UPDATE_ACCOUNT = "UPDATE_ACCOUNT"
            
            case UPDATE_FACT = "UPDATE_FACT"
            
            case FACTURAR = "FACTURAR"
            
            case CALIFICAR = "CALIFICAR"
            
            case RECURRENCIA = "RECURRENCIA"
            
            case SOLTAR_CLASE = "SOLTAR_CLASE"
            
            case GET_CREDIT_PRICE = "GET_CREDIT_PRICE"
            
            case REVISAR_USUARIO_DEBE = "REVISAR_USUARIO_DEBE"
            
            case INTENTAR_PAGAR = "INTENTAR_PAGAR"
            
            case PROMOTIONS = "PROMOTIONS"
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
        
        case tabBarBackground = 0x00B7FF
        case tabBarTitleColor = 0x000000
        case collectionViewColor = 0xf2f2f2
        case statusBar = 0x23486C
        case backgroundFillColor = 0x222222
        case fillcolor = 0xFF0080
        
        
    }
}
