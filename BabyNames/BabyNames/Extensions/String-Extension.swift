//
//  String-Extension.swift
//  TellMeeApp
//
//  Created by Carlos Rodriguez on 11/11/16.
//  Copyright © 2016 AstroneSoft. All rights reserved.
//

import Foundation
import UIKit
import Security

extension String {
//    func sha1() -> String {
//        let data = self.data(using: String.Encoding.utf8)!
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
//        }
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        return hexBytes.joined()
//    }
    
  
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    //validate PhoneNumber
    var isPhoneNumber: Bool {
        
        let charcter  = CharacterSet(charactersIn: "+0123456789").inverted
        var filtered:NSString!
        let inputString:NSArray = (self.components(separatedBy: charcter) as NSArray)
        filtered = inputString.componentsJoined(by: "") as NSString
        return  self == String(filtered)
        
    }
    
    func verifyUrl(urlString: String?) -> Bool {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func IsInternationalPhoneNumber(value: String) -> Bool {
        //"^(?!\\b(0)\\1+\\b)(\\+?\\d{1,3}[. -]?)?\\(?\\d{3}\\)?([. -]?)\\d{3}\\3\\d{4}$"ç
        
        
        let PHONE_REGEX = "^\\+([0-9]{1})([. -]?)([(]?)([0-9]{3})([)]?)([. -]?)([(]?)([0-9]{3})([)]?)([. -]?)([(]?)([0-9]{4})([)]?)"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    // localized string
    var localized: String {
        return NSLocalizedString(self, tableName: "Loc", value: "\(self)", comment: "")
    }
    
    func heightForWithFont(_ font: UIFont, width: CGFloat) -> CGFloat {
        
        let label:UILabel = UILabel(frame: CGRect(x:0,y:0,width:width,height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height
    }
    
    func setBodyFont() -> UIFont
    {
        let pSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize - (UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).pointSize / 5)
        return UIFont(name: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body).fontName, size: pSize)!
    }
    

}
