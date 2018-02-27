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
import Lottie
class MakeMatchVC: BaseViewController {
    //MARK:- IBOutlet
    @IBOutlet weak var viewForSwippe: UIView!
    @IBOutlet weak var viewForEmptyState: UIView!
    @IBOutlet weak var viewForReload: UIView!
    @IBOutlet weak var VFRLabelTitle: UILabel!
    @IBOutlet weak var VFRLabelInfo: UILabel!
    
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
    var gender = ""
    let animationEmpty: LOTAnimationView = LOTAnimationView(name: "empty_box")
    let animationNoMore: LOTAnimationView = LOTAnimationView(name: "empty_status")
    
    
    //MARK:- BasicFunctions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppStrings.MAKE_MATCH_TITLE
        self.VFRLabelTitle.text = AppStrings.VFR_TITLE_LABEL
        self.VFRLabelInfo.text = AppStrings.VFR_INFO_LABEL
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewForReload.isHidden = true
        checkGender()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reloadCardsGesturePress(_ sender: UITapGestureRecognizer) {
        logger.log("me presionaron weon")
    }
    
    @IBAction func reloadButtonPress(_ sender: UIButton) {
           logger.log("me presionaron weon")
    }
    override func viewDidAppear(_ animated: Bool) {
        if genderSingleton.actualGender.genderHasBeenChange{
            genderSingleton.actualGender.genderHasBeenChange =  false
//            clean the actual cardViewNames and show the new name list
            self.getBabynameFromServer()
        }
    }
    
    func checkGender()  {
        if genderSingleton.actualGender.gender != ""{
            gender = UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.Gender.rawValue) as! String
            self.getBabynameFromServer()
        }else{
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
            self.gender = component
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
           self.nameIndex = 0
           self.swipeInit()
           self.setupViewForEmptyState(status: true)
        }) { (ErrorSttring:String) in
             MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
             self.setupViewForEmptyState(status: false)
//            show empty state and reload button
        }
    }
    
    func setupViewForEmptyState(status:Bool){
       
        if status{
            animationNoMore.contentMode = .scaleAspectFit
            animationNoMore.frame = CGRect(x: 0, y: 0, width: self.viewForEmptyState.frame.width , height: self.viewForEmptyState.frame.height)
            animationNoMore.animationSpeed = 0.5
            animationNoMore.play()
            animationNoMore.loopAnimation = true
            self.viewForEmptyState.addSubview(animationNoMore)
        }else{
            animationEmpty.contentMode = .scaleAspectFit
            animationEmpty.frame = CGRect(x: 0, y: 0, width: self.viewForEmptyState.frame.width , height: self.viewForEmptyState.frame.height)
            animationEmpty.animationSpeed = 0.5
            animationEmpty.play()
            animationEmpty.loopAnimation = true
            self.viewForEmptyState.addSubview(animationEmpty)
        }
        
    }
    //MARK:- swipeInit
    func swipeInit()  {
        if isInit{
            
            self.swipeableView.discardViews()
            self.swipeableView.updateViews()
        }else{
            isInit = true
        }
        swipeableView = ZLSwipeableView()
        self.swipeableView.discardViews()
        self.swipeableView.loadViews()
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
            print(nameIndex)
            print(self.dataHelper.namesArray.count)
            viewForReload.isHidden = false
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
