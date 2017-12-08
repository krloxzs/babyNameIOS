//
//  APIConection.swift
//  Junger
//
//  Created by Alan Guevara on 11/11/16.
//  Copyright © 2016 Tejuino developers. All rights reserved.
//

import UIKit
import Alamofire

 var asociado_ID = ""
//class APIConection: NSObject {
//
//    static let sharedInstance = APIConection()
//
//    private override init() {
//        super.init()
//    }
//
//    public enum requestURL: String{
//        case getDisponibilidad = "catalogs/profesor/disponibilidad"
//        case getCuentasVinculadas = "profile/student/vinculacion"
//        case desvincular = "profile/student/desvinculacion"
//        case cancelClass =  "profile/student/clase/cancelar"
//        case getClasesProgramadas = "profile/student/clase"
//        case getCategorias = "catalogs/materias/categoria"
//        case getProfesores = "catalogs/materias/profesor"
//        case recoverRequest = "account/recover-request"
//        case getNivelesURL = "catalogs/materias/nivel"
//        case getHorarios = "catalogs/profesor/horario"
//        case getFiltros = "catalogs/materias/filter"
//        case recoverLogin = "account/recover-login"
//        case vincular = "profile/student/vincular"
//        case registerByEmail = "account/register"
//        case loginByEmail = "account/login"
//        case sendSuggest = "comentario/app"
//    }
//
//
//      let urlBase: String! = values[Constants.Settings.service_keys.BASE_URL.rawValue]  as! String
//
//        func getJson(requestURL: requestURL, parameters: Parameters?, method: Alamofire.HTTPMethod, vc: UIViewController, completion: @escaping (Bool, Dictionary<String, AnyObject>?)->Void){
//        logger.log(parameters)
//
//        var message: String = ""
//
//        let url = urlBase+requestURL.rawValue
//        print(url)
//
//        LilithProgressHUD.show(vc.view)
//
//        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
//
//            LilithProgressHUD.hide(vc.view)
//
//            if let json = response.result.value as? [String:AnyObject]{
//                print("JSON: \(json)")
//                print(json["code"] as! Int)
//                if (json["code"] as? Int) == 200{
//                    logger.log(json)
//                    if let cuentaPadre = json["data"] as? NSDictionary{
//                        if let cuentaDelPadre = cuentaPadre["cuentaPadre"] as? NSDictionary{
//                            logger.log(cuentaDelPadre)
//                            let id = cuentaDelPadre["asociado_id"] as! String
//                            asociado_ID = id
//                        }
//                    }
//                    completion(true,(json["data"] as? Dictionary<String, AnyObject>))
//                    return
//                }else{
//                    message = json["message"] as! String
//                }
//            }else{
//                message = "Por favor revisa tu conexión a internet"
//            }
//
//            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            vc.present(alert, animated: true, completion: nil)
//
//        }
//
//    }
//
//    func getImage(url: String, completion: @escaping (Bool, UIImage)->Void){
//        Alamofire.request(url).responseImage { response in
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                completion(true, image)
//            }
//        }
//    }
//
//    func setUserDefaults(data: Dictionary<String,AnyObject>){
//
//        let user = data["user"] as! Dictionary<String, AnyObject>
//
//        print("user: \(user)")
//
//        UserDefaults.standard.set(data["session_id"] as! String, forKey: "session_id")
//        UserDefaults.standard.set(user["name"] as! String, forKey: "name")
//        UserDefaults.standard.set(user["username"] as! String, forKey: "username")
//        UserDefaults.standard.set(user["email"] as! String, forKey: "email")
//        UserDefaults.standard.set(user["tipo"] as! String, forKey: "tipo")
//        UserDefaults.standard.set(Int(user["telefono"] as! String)!, forKey: "telefono")
//        UserDefaults.standard.set(user["token_dispositivo"] as! String, forKey: "token_dispositivo")
//        UserDefaults.standard.set(user["image"] as! String, forKey: "image")
//
//        if let cuenta = user["cuenta"] as? Dictionary <String, AnyObject>{
//            print("cuenta: \(cuenta)")
//            UserDefaults.standard.set(cuenta["nivel"]?["titulo"] as! String, forKey: "nivel")
//            UserDefaults.standard.set(cuenta["grado"]?["titulo"] as! String, forKey: "grado")
//            UserDefaults.standard.set(cuenta["codigo_referencia"] as! String, forKey: "codigo_referencia")
//        }
//
//    }
//
//    func clearUserDefaults(){
//        UserDefaults.standard.removeObject(forKey: "session_id")
//        UserDefaults.standard.removeObject(forKey: "name")
//        UserDefaults.standard.removeObject(forKey: "username")
//        UserDefaults.standard.removeObject(forKey: "email")
//        UserDefaults.standard.removeObject(forKey: "tipo")
//        UserDefaults.standard.removeObject(forKey: "telefono")
//        UserDefaults.standard.removeObject(forKey: "token_dispositivo")
//        UserDefaults.standard.removeObject(forKey: "image")
//        UserDefaults.standard.removeObject(forKey: "nivel")
//        UserDefaults.standard.removeObject(forKey: "grado")
//    }
//
//}

