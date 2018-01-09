//
//  ScanerViewController.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/13/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import Lottie
import AVFoundation
import SwiftyJSON
import MBProgressHUD
import Alamofire

class ScanerViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {

    
    @IBOutlet weak var ScanQRMessageLabel: UILabel!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var viewForTheAnimation: UIView!
    @IBOutlet weak var viewForhiddeAnimation: UIView!
    @IBOutlet var messageLabel:UILabel!
    
    var loadingNotification: MBProgressHUD! = MBProgressHUD()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var userInfo: UserItem?
    var dataHelper: UserData = UserData()
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var isLoading = false
    
    let supportedCodeTypes = [/*AVMetadataObject.ObjectType.upce,
                              AVMetadataObject.ObjectType.code39,
                              AVMetadataObject.ObjectType.code39Mod43,
                              AVMetadataObject.ObjectType.code93,
                              AVMetadataObject.ObjectType.code128,
                              AVMetadataObject.ObjectType.ean8,
                              AVMetadataObject.ObjectType.ean13,
                              AVMetadataObject.ObjectType.aztec,
                              AVMetadataObject.ObjectType.pdf417,*/
                              AVMetadataObject.ObjectType.qr]
    let animation1: LOTAnimationView = LOTAnimationView(name: "scan_qr_code_success")
    
    override func viewDidLoad() {
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeDefault
        self.title = AppStrings.SCAN_QR_TITLE
        self.ScanQRMessageLabel.text = AppStrings.SCAN_QR_INFO_LABEL
        self.doneButtonOutlet.setTitle(AppStrings.DONE, for: .normal)
        self.messageLabel.text = AppStrings.QR_MESSAGE_DETECTED
        animation1.contentMode = .scaleAspectFit
        animation1.frame = CGRect(x: self.viewForTheAnimation.frame.width / 5, y: 0, width: self.viewForTheAnimation.frame.width , height: self.viewForTheAnimation.frame.height)
        animation1.animationSpeed = 0.5
        animation1.play()
        animation1.loopAnimation = true
        self.viewForTheAnimation.addSubview(animation1)
        userInfo = appDelegate.AppsetupRoot.loginHandler.getUserInfo()
        // User Interface
        
      
        // Do any additional setup after loading the view.
    }
    
    func startQR()  {
      
       
    }
    func initCamera()  {
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            view.bringSubview(toFront: messageLabel)
            
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate Methods
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "No QR/barcode is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) && !isLoading {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.loadingNotification.mode = MBProgressHUDMode.indeterminate
            self.loadingNotification.labelText = AppStrings.LOADING
            if metadataObj.stringValue != nil {
//                call the
                isLoading = true
                self.dataHelper.SetCouple(self.userInfo!.id, USER_TWO: metadataObj.stringValue!, success: { (JSON) in
                     MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                     self.isLoading = true
                     self.back()
                }, failure: { (String) in
                     self.isLoading = true
                     MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                })
                messageLabel.text = AppStrings.LOADING
            }
        }
    }
    
    
   
    
    @IBAction func doneButtonPress(_ sender: UIButton) {
        UIView.animate(withDuration: 1, animations: {
                        self.messageLabel.isHidden = false
                        self.viewForhiddeAnimation.isHidden = true
                        self.initCamera()
        }, completion: nil)
        
    }
    
}
