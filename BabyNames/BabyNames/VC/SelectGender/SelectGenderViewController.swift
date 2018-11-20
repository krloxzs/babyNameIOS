//
//  SelectGenderViewController.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/20/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import SpriteKit

class SelectGenderViewController: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!

    var completion: ((String)->Void)?
    var onExit: (()->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isOpaque = false
        self.popUpView.alpha = 0
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        popUpView.transform = CGAffineTransform(scaleX: 0.3, y: 2)
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveLinear, animations: ({
            self.popUpView.transform = .identity
            // do stuff
        }), completion: nil)
        self.popUpView.alpha = 1
        
    }
    
    func exit(){
        self.popUpView.alpha = 0
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        onExit?()
    }

    
    func setSelected(component: String){
        
        completion?(component)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func boySelected(_ sender: UITapGestureRecognizer) {
        setSelected(component: "male")
        exit()
    }
    
    @IBAction func girlSelected(_ sender: UITapGestureRecognizer) {
        setSelected(component: "female")
        exit()
    }
    

    @IBAction func surpriseSelected(_ sender: UITapGestureRecognizer) {
        setSelected(component: "unisex")
        exit()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
