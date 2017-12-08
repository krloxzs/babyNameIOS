//
//  UserItem.swift
//  NutriwenApp
//
//  Created by Carlos Rodriguez on 22/05/16.

//

import Foundation

// TODO: Migrate this class using BuilderPattern instead.
class UserItem: BaseNSObject, NSCoding {
    
    let userId      : Int
    let session_id  : String
    let name        : String
    let username    : String
    let email       : String
    let tipo        : String
    let telefono    : String
    let token_dispositivo: String
    let image       : String
    let nivel       : NSDictionary
    let grado       : NSDictionary
    let codigo_referencia: String
    let nivel_id    :Int
    let nivel_titulo:String
    let grado_id    : Int
    let grado_titulo:String
    let codigo_invitacion: String
    let codigo_registro: String
   
    
    //facturacion
    let rfc: String
    let calle: String
    let codigo_postal : Int
    let estado : String
    let municipio: String
    let colonia : String
    let email_facturacion: String
    let razon_social: String
    
    
    init(userId: Int,session_id:String,name:String,username: String,
         email: String, tipo: String, telefono : String,
         token_dispositivo:String, image: String,
         nivel: NSDictionary, grado: NSDictionary,
         codigo_referencia:String,nivel_id:Int,
         nivel_titulo:String,grado_id:Int,
         grado_titulo:String,codigo_invitacion:String, codigo_registro : String,
         
         
         rfc:String, calle:String,codigo_postal : Int,
         estado:String,municipio:String, colonia:String,
         email_facturacion:String, razon_social:String) {
        self.userId = userId
        self.session_id = session_id
        self.name = name
        self.username = username
        self.email = email
        self.tipo = tipo
        self.telefono = telefono
        self.token_dispositivo = token_dispositivo
        self.image = image
        self.nivel = nivel
        self.grado = grado
        self.codigo_referencia = codigo_referencia
        self.nivel_id = nivel_id
        self.nivel_titulo = nivel_titulo
        self.grado_id = grado_id
        self.grado_titulo = grado_titulo
        self.codigo_invitacion = codigo_invitacion
        self.codigo_registro = codigo_registro
        //facturacion
        self.rfc = rfc
        self.calle = calle
        self.codigo_postal = codigo_postal
        self.estado = estado
        self.municipio = municipio
        self.colonia = colonia
        self.email_facturacion = email_facturacion
        self.razon_social = razon_social
    }
    
    // MARK: NSCoding
    required init(coder aDecoder: NSCoder) {
        self.userId         = aDecoder.decodeInteger(forKey: "userId")
        self.session_id     = aDecoder.decodeObject(forKey: "session_id") as! String
        self.name           = aDecoder.decodeObject(forKey: "name") as! String
        self.username       = aDecoder.decodeObject(forKey: "username") as! String
        self.email          = aDecoder.decodeObject(forKey: "email") as! String
        self.tipo           = aDecoder.decodeObject(forKey: "tipo") as! String
        self.telefono       = aDecoder.decodeObject(forKey: "telefono") as! String
        self.token_dispositivo = aDecoder.decodeObject(forKey: "token_dispositivo") as! String
        self.image          = aDecoder.decodeObject(forKey: "image") as! String
        self.nivel          = aDecoder.decodeObject(forKey: "nivel") as! NSDictionary
        self.grado          = aDecoder.decodeObject(forKey: "grado") as! NSDictionary
        self.codigo_referencia   = aDecoder.decodeObject(forKey: "codigo_referencia") as! String
        self.nivel_id       = aDecoder.decodeInteger(forKey: "nivel_id")
        self.nivel_titulo   = aDecoder.decodeObject(forKey: "nivel_titulo") as! String
        self.grado_id       = aDecoder.decodeInteger(forKey: "grado_id")
        self.grado_titulo   = aDecoder.decodeObject(forKey: "grado_titulo") as! String
        self.codigo_invitacion = aDecoder.decodeObject(forKey: "codigo_invitacion") as! String
        self.codigo_registro   = aDecoder.decodeObject(forKey: "codigo_registro") as! String
        //facturacion
        self.rfc            = aDecoder.decodeObject(forKey: "rfc") as! String
        self.calle          = aDecoder.decodeObject(forKey: "calle") as! String
        self.codigo_postal  = aDecoder.decodeInteger(forKey: "codigo_postal")
        self.estado         = aDecoder.decodeObject(forKey: "estado") as! String
        self.municipio      = aDecoder.decodeObject(forKey: "municipio") as! String
        self.colonia        = aDecoder.decodeObject(forKey: "colonia") as! String
        self.email_facturacion = aDecoder.decodeObject(forKey: "email_facturacion") as! String
        self.razon_social   = aDecoder.decodeObject(forKey: "razon_social") as! String
        
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(self.userId, forKey: "userId")
        coder.encode(self.session_id, forKey:  "session_id")
        coder.encode(self.name, forKey: "name")
        coder.encode(self.username, forKey: "username")
        coder.encode(self.email, forKey: "email")
        coder.encode(self.tipo, forKey: "tipo")
        coder.encode(self.telefono, forKey: "telefono")
        coder.encode(self.token_dispositivo, forKey: "token_dispositivo")
        coder.encode(self.image, forKey: "image")
        coder.encode(self.nivel, forKey: "nivel")
        coder.encode(self.grado, forKey: "grado")
        coder.encode(self.codigo_referencia, forKey: "codigo_referencia")
        coder.encode(self.nivel_id, forKey: "nivel_id")
        coder.encode(self.nivel_titulo, forKey: "nivel_titulo")
        coder.encode(self.grado_id, forKey: "grado_id")
        coder.encode(self.grado_titulo, forKey: "grado_titulo")
        coder.encode(self.codigo_invitacion, forKey: "codigo_invitacion")
        coder.encode(self.codigo_registro, forKey: "codigo_registro")
        //facturacion
        coder.encode(self.rfc, forKey: "rfc")
        coder.encode(self.calle, forKey: "calle")
        coder.encode(self.codigo_postal, forKey: "codigo_postal")
        coder.encode(self.estado, forKey: "estado")
        coder.encode(self.municipio, forKey: "municipio")
        coder.encode(self.colonia, forKey: "colonia")
        coder.encode(self.email_facturacion, forKey: "email_facturacion")
        coder.encode(self.razon_social, forKey: "razon_social")
        
    
    }
    
}

