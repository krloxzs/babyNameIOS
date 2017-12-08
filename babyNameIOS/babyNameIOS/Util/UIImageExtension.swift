
//
//  UIImageExtension.swift
//  Favly
//
//  Created by MCS on 24/10/17.
//  Copyright © 2017 Favly, Inc. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImage {
    func crop(to:CGSize) -> UIImage {
        guard let cgimage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        
        let contextSize: CGSize = contextImage.size
        
        //Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        
        if to.width > to.height { //Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        } else if to.width < to.height { //Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else { //Square
            if contextSize.width >= contextSize.height { //Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            }else{ //Square on portrait
                cropWidth = contextSize.width
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x : posX, y : posY, width : cropWidth, height : cropHeight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        cropped.draw(in: CGRect(x : 0, y : 0, width : to.width, height : to.height))
        
        return cropped
    }
}

extension UIImageView{

  //for images like user profile, use refreshed cache for always bring the new image and no the image that we already have in memory

  func setImage(withURLString urlString: String,from PlaceHolderImage:UIImage, for imageView: UIImageView) {
    imageView.sd_setImage(with: URL(string: urlString), placeholderImage: PlaceHolderImage, options: SDWebImageOptions.progressiveDownload)
  }
  func setImageInaBlock(withURLString urlString: URL,
                     fromPlaceHolderImage placeHolder:UIImage,
                     forimage ImageView: UIImageView,
                     success:@escaping (_ res:UIImage) -> Void,
                     failure:@escaping (_ ErrorString:String) -> Void){
    if let cacheImage :UIImage = GetImageFromCache(urlString){
      //the image is in chache
      Run.onMain()
        {
          ImageView.image = cacheImage
      }
      //return the downloaded image because sometime we use that in anoter objects: example....
      //in bizProfile, we save the images for show a scrollview with the images
      success(cacheImage)

    }else{
      //download the image
      ImageView.sd_setImage(with:  urlString,
                            placeholderImage:  placeHolder,
                            options: SDWebImageOptions.highPriority) { (NewImage:UIImage?,
                              ErrorMessage:Error?,
                              cacheType:SDImageCacheType, ImageUrl:URL?) in
                              if ErrorMessage != nil{
                                //maybe retry... but the sdWebimage is trying again
                              }else{
                                Run.onMain()
                                  {
                                     SDImageCache.shared().store(NewImage!, forKey: urlString.absoluteString)
                                    ImageView.image = NewImage
                                }
                                success(NewImage!)
                              }
                        }
          }
  }
}

private func GetImageFromCache(_ StrKey:URL) -> UIImage? {
  if let image = SDImageCache.shared().imageFromMemoryCache(forKey: StrKey.absoluteString) {
    return image
  }else{
    return nil
  }
}
