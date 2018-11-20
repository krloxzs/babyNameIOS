//
//  ShowQRViewController.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/13/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class ShowQRViewController: BaseViewController {
    @IBOutlet weak var QRImage: UIImageView!
    @IBOutlet weak var show_qr_Info_label: UILabel!
    @IBOutlet weak var shareButtonOutlet: UIButton!
    
    
    
    var ID : String?
    override func viewDidLoad() {
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeDefault
         self.title = AppStrings.SHOW_QR_TITLE
        let image = generateQRCode(from: ID!)
        self .QRImage.image = image
        self.QRImage.contentMode = .scaleAspectFit
        self.show_qr_Info_label.text = AppStrings.SHOW_QR_INFO_LABEL
        self.shareButtonOutlet.setTitle(AppStrings.SHARE_BUTTON_PRESS, for: .normal)
        // Do any additional setup after loading the view.
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }

    
    
    @IBAction func shareButtonPress(_ sender: UIButton) {
        // image to share
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = img{
            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            present(vc, animated: true)
        }
    }
}
