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
import RealmSwift
import Realm

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
        self.title = AppStrings.MAKE_MATCH_TITLE
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        checkGender()
        // Do any additional setup after loading the view.
    }
    
    func checkGender()  {
        if loginHandler.gotGender(){
      
          self.getBabynameFromServer()
        }else {
            SetBabyGender()
        }
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
            let defaults = UserDefaults.standard
            defaults.set( component, forKey: Constants.UserDefaultsKeys.Gender.rawValue)
            defaults.synchronize()
            self.getBabynameFromServer()
        }
        self.present(vc!, animated: false, completion: {
            
        })
    }
    
    func getBabynameFromServer() {
          self.loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.loadingNotification.mode = MBProgressHUDMode.indeterminate
        self.loadingNotification.labelText = AppStrings.LOADING
        self.dataHelper.getBabyNames(success: { (Res:JSON) in
            //  show all the baby names
            
           self.swipeInit()
        }) { (ErrorSttring:String) in
             MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
//            show empty state and reload button
        }
    }
    
    //MARK:- swipeInit
    func swipeInit()  {
        isInit = true
        swipeableView = ZLSwipeableView()
        swipeableView.frame = viewForSwippe.frame
        viewForSwippe.addSubview(swipeableView)
        swipeableView.didStart = {view, location in
//            print("Did start swiping view at location: \(location) the view  \(view.tag)")
        }
        swipeableView.swiping = {view, location, translation in
//            print("Swiping at view location: \(location) translation: \(translation)  the view  \(view.tag)")
        }
        swipeableView.didEnd = {view, location in
//            print("Did end swiping view at location: \(location) the view  \(view.tag)")
        }
        swipeableView.didSwipe = {view, direction, vector in
//            save to db  o send to server
            let realmData = realmHelper()
            logger.log("Did swipe view in direction: \(direction), vector: \(vector)   the view  \(String(view.tag))")
            let BN = babyNameRO()
            
//            checr si y se tiene un objeto con esa key
            if let filterOBJ = self.dataHelper.namesArray.first(where: {$0.id == "\(String(view.tag))"}) {
                BN.setNameObjInfo(BabyOBJ: filterOBJ)
                if realmData.checkIfBabyNameExist(BN){
                    realmData.updateBabyName(BN)
                }else{
//                    is a new baby name...add it
                    realmData.addBabyName(BN)
                }
               
                // do something with foo
            } else {
                logger.log("error checking the baby id.... check with ivan D:")
                // item could not be found
            }
            
        }
        swipeableView.didCancel = {view in
//            print("Did cancel swiping view the view  \(view.tag)")
        }
        swipeableView.didTap = {view, location in
//            print("Did tap at location \(location) the view  \(view.tag)")
        }
        swipeableView.didDisappear = { view in
//            print("Did disappear swiping view the view  \(view.tag)" )
        }
        
        constrain(swipeableView, viewForSwippe) { view1, view2 in
            view1.left == view2.left
            view1.right == view2.right
            view1.top == view2.top
            view1.bottom == view2.bottom
        }
         MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }
    
    // MARK: load CardVIews
    func nextCardView() -> UIView? {
        if nameIndex < self.dataHelper.namesArray.count{
            let obj = self.dataHelper.namesArray[nameIndex]
            let cardView = CardView(frame: CGRect(x: 0, y: 0, width: viewForSwippe.frame.width * 0.8, height: viewForSwippe.frame.height * 0.95))
            cardView.tag = Int(obj.id)!
            self.nameIndex += 1
            let contentView = Bundle.main.loadNibNamed("CardContentView", owner: self, options: nil)?.first! as! CardView
            contentView.initWithInfo(obj)
            contentView.setupTV()
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
