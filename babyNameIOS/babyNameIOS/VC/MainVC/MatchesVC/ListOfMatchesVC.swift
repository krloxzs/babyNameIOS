//
//  ListOfMatchesVC.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/11/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class ListOfMatchesVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  AppStrings.FAVOURITES_TITLE
        self.navigationController?.navigationBar.prefersLargeTitles = true
        registerNibs()
        setupCollectionLayout()
        // Do any additional setup after loading the view.
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
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavCollectionViewCell().reuseIdentifierString(), for: indexPath) as! FavCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //        let term = arraySelected[indexPath.row]
        //        let width : CGFloat = term.widthForWithFont(UIFont.systemFont(ofSize: FontSize.Font_size_10) , height: 25.0)
        return CGSize(width:  self.collectionView.frame.width - 4, height: self.collectionView.frame.width / 2.2)
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
