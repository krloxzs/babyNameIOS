//
//  ListOfMatchesVC.swift
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
import Popover


class FavouritesVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables and Constants
    var userInfo: UserItem?
    var dataHelper: UserData = UserData()
    let loginHandler = LoginHandler.sharedInstance
    var loadingNotification: MBProgressHUD! = MBProgressHUD()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let realmData = realmHelper()
    let realm = try! Realm()
    var popover : Popover? = nil
    var position : CGFloat?
    var babys : Results<babyNameRO>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadInfo()
        self.title =  AppStrings.FAVOURITES_TITLE
        self.navigationController?.navigationBar.prefersLargeTitles = true
        registerNibs()
        setupCollectionLayout()
        getBabysFromDB()
        // Do any additional setup after loading the view.
    }
  
    override func viewDidAppear(_ animated: Bool) {
        getBabysFromDB()
    }
    func reloadInfo()  {
        babys = realm.objects(babyNameRO.self)
        self.collectionView.reloadData()
    }
    
    @objc func optionButtonPress(sender: UIButton) {
       let babyOBJ = self.babys[sender.tag]
        // create the alert
        let alert = UIAlertController(title: AppStrings.FAV_OPT_BUTTON_TITLE, message: AppStrings.LOGOUT_MESSAGES, preferredStyle: UIAlertControllerStyle.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: AppStrings.FAV_OPT_BUTTON_ONE, style: UIAlertActionStyle.destructive, handler: { action in
            self.realmData.deletObjectFromBD(babyOBJ, success: {
                print("success the baby has been deleted")
                self.reloadInfo()
            })
        }))
        alert.addAction(UIAlertAction(title: AppStrings.CANCEL, style: UIAlertActionStyle.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    func getBabysFromDB()  {
        babys = realm.objects(babyNameRO.self).sorted(byKeyPath: "id", ascending: true).filter( "%K == true", "like")
        self.collectionView.reloadData()
    }
    
    private func setupCollectionLayout() {
        
        // Attach datasource and delegate
        self.collectionView.layer.cornerRadius = 16
        self.collectionView.dataSource  = self
        self.collectionView.delegate = self

        // Added behavior.
        // TOO: Review this later.
        // self.navigationController?.hidesBarsOnSwipe = false
    }
    
    private func registerNibs() {
        
        // Register xib file.
        self.collectionView!.register(UINib(nibName: FavCollectionViewCell().theClassName, bundle: nil), forCellWithReuseIdentifier: FavCollectionViewCell().reuseIdentifierString())
         self.collectionView!.register(UINib(nibName: EmptyStateFavCollectionViewCell().theClassName, bundle: nil), forCellWithReuseIdentifier: EmptyStateFavCollectionViewCell().reuseIdentifierString())
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if babys!.count > 0 {
              return babys!.count
        }else{
             return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if babys!.count > 0 {
            let babyOBJ = self.babys[indexPath.row]
            switch babyOBJ.gender {
            case "male","female","unisex":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCollectionViewCell().reuseIdentifierString(), for: indexPath) as! FavCollectionViewCell
                cell.SetupCell(babyOBJ)
                cell.optionsButton.tag = indexPath.row
                cell.optionsButton.addTarget(self, action: #selector(self.optionButtonPress(sender:)), for: UIControlEvents.touchUpInside)
                return cell
            // ads
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCollectionViewCell().reuseIdentifierString(), for: indexPath) as! FavCollectionViewCell
                return cell
            }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyStateFavCollectionViewCell().reuseIdentifierString(), for: indexPath) as! EmptyStateFavCollectionViewCell
            cell.parentVC = self
            cell.setupAnim()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if babys!.count > 0 {
            let babyOBJ = self.babys[indexPath.row]
            let hei = babyOBJ.meaning.heightForWithFont("".setBodyFont(), width: self.collectionView.frame.width - 100)
            return CGSize(width:  self.collectionView.frame.width - 4, height: (self.collectionView.frame.width / 2.5) + hei)
        }else{
            return CGSize(width:  self.collectionView.frame.width - 4, height: self.collectionView.frame.height)
        }
      
    }
    


}
