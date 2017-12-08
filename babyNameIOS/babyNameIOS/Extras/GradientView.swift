//
//  GradientView
//
//  Created by Tejuino developers on 05/07/16.
//  Copyright © 2016 Tejuino developers. All rights reserved.
//


import Foundation
import UIKit

/// Custom header view that displays a gradient layer inside it
 open class GradientView: UIView {
    
    // MARK: Inspectable properties ******************************
    
var startColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
 var endColor: UIColor = UIColor.black {
        didSet{
            setupView()
        }
    }
    
   var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0) {
        didSet {
            setupView()
        }
    }
    
  var endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0) {
        didSet {
            setupView()
        }
    }

    
    // MARK: Overrides ******************************************
    
    override open class var layerClass:AnyClass{
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    
    
    // MARK: Internal functions *********************************
    
    // Setup the view appearance
    fileprivate func setupView(){
        
        let colors:Array<AnyObject> = [startColor.cgColor, endColor.cgColor]
        gradientLayer.colors = colors        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        self.setNeedsDisplay()
        
    }
    
    // Helper to return the main layer as CAGradientLayer
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
}
