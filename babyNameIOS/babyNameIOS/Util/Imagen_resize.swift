//
//  Imagen_resize.swift
//  Junger
//
//  Created by Developer 2 on 26/12/16.
//  Copyright © 2016 Tejuino developers. All rights reserved.
//

import Foundation
import  UIKit

class ResizeImage{


    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth,height: newHeight))
        image.draw(in: CGRect(x:0,y: 0,width: newWidth,height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    // convert images into base64 and keep them into string
    
    func convertImageToBase64(image: UIImage) -> String {
        
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData?.base64EncodedString(options: .endLineWithCarriageReturn)
        
        return "data:image/png;base64,\(base64String!)"
        
    }// end convertImageToBase64
    
    
    // prgm mark ----
    
    // convert images into base64 and keep them into string
    
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        let decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
    }// end convertBase64ToImage

}
