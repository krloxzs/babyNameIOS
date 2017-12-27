//
//  MakeMatchVC.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/11/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import Cartography


class MakeMatchVC: BaseViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var viewForSwippe: UIView!
    
    //MARK:- Variables and Constants
    var userInfo: UserItem?
    var dataHelper: UserData = UserData()
    let loginHandler = LoginHandler.sharedInstance
    var loadingNotification: MBProgressHUD! = MBProgressHUD()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var swipeableView: ZLSwipeableView!
    var nameIndex = 0
    var loadCardsFromXib = false
    var isInit = false

    //MARK:- BasicFunctions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Baby Names"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        SetBabyGender()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isInit{
            swipeableView.nextView = {
                return self.nextCardView()
            }
        }
    }
     //MARK:- ServerFuntions
    func SetBabyGender()  {
        let vc: SelectGenderViewController? = UIStoryboard(name: Constants.Storyboard.Main.rawValue, bundle: Bundle.main).instantiateVC()
        vc?.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        vc!.completion = { (component) in
            print(component)
            self.getBabynameFromServer()
        }
        self.present(vc!, animated: false, completion: {
            
        })
    }
    
    func getBabynameFromServer() {
        self.dataHelper.getBabyNames(success: { (Res:JSON) in
            //  show all the baby names
           self.swipeInit()
        }) { (ErrorSttring:String) in
            
        }
    }
    
    //MARK:- swipeInit
    func swipeInit()  {
        isInit = true
        swipeableView = ZLSwipeableView()
        swipeableView.frame = viewForSwippe.frame
        viewForSwippe.addSubview(swipeableView)
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location) the view  \(view.tag)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)  the view  \(view.tag)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location) the view  \(view.tag)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)   the view  \(view.tag)")
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view the view  \(view.tag)")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location) the view  \(view.tag)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view the view  \(view.tag)" )
        }
        
        constrain(swipeableView, viewForSwippe) { view1, view2 in
            view1.left == view2.left
            view1.right == view2.right
            view1.top == view2.top
            view1.bottom == view2.bottom
        }
    }
//    @objc func reloadButtonAction() {
//        let alertController = UIAlertController(title: nil, message: "Load Cards:", preferredStyle: .actionSheet)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//            // ...
//        }
//        alertController.addAction(cancelAction)
//
//        let ProgrammaticallyAction = UIAlertAction(title: "Programmatically", style: .default) { (action) in
//            self.loadCardsFromXib = false
//            self.colorIndex = 0
//            self.swipeableView.discardViews()
//            self.swipeableView.loadViews()
//        }
//        alertController.addAction(ProgrammaticallyAction)
//
//        let XibAction = UIAlertAction(title: "From Xib", style: .default) { (action) in
//            self.loadCardsFromXib = true
//            self.colorIndex = 0
//            self.swipeableView.discardViews()
//            self.swipeableView.loadViews()
//        }
//        alertController.addAction(XibAction)
//
//        self.present(alertController, animated: true, completion: nil)
//    }
    
//    @objc func leftButtonAction() {
//        self.swipeableView.swipeTopView(inDirection: .Left)
//    }
//
//    @objc func upButtonAction() {
//        self.swipeableView.swipeTopView(inDirection: .Up)
//    }
//
//    @objc func rightButtonAction() {
//        self.swipeableView.swipeTopView(inDirection: .Right)
//    }
//
//    @objc func downButtonAction() {
//        self.swipeableView.swipeTopView(inDirection: .Down)
//    }
    
    // MARK: load CardVIews
    func nextCardView() -> UIView? {
        if nameIndex < self.dataHelper.namesArray.count{
            let obj = self.dataHelper.namesArray[nameIndex] as! NameObject
            let cardView = CardView(frame: CGRect(x: 0, y: 0, width: viewForSwippe.frame.width * 0.8, height: viewForSwippe.frame.height * 0.95))
            cardView.tag = nameIndex
            self.nameIndex += 1
            let contentView = Bundle.main.loadNibNamed("CardContentView", owner: self, options: nil)?.first! as! CardView
            contentView.initWithInfo(obj)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.backgroundColor = cardView.backgroundColor
            cardView.addSubview(contentView)
            constrain(contentView, cardView) { view1, view2 in
                view1.left == view2.left
                view1.top == view2.top
                view1.width == cardView.bounds.width
                view1.height == cardView.bounds.height
            }
            return cardView
        }else{
            return nil
        }
    }
    
    func colorForName(_ name: String) -> UIColor {
        let sanitizedName = name.replacingOccurrences(of: " ", with: "")
        let selector = "flat\(sanitizedName)Color"
        return UIColor.perform(Selector(selector)).takeUnretainedValue() as! UIColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
