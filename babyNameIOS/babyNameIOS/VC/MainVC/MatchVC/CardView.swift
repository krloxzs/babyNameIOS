//
//  CardView.swift
//  ZLSwipeableViewSwiftDemo
//
//  Created by Zhixuan Lai on 5/24/15.
//  Copyright (c) 2015 Zhixuan Lai. All rights reserved.
//

import UIKit

class CardView: UIView,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    var babyObjecName: NameObject?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
       
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func setupTV()  {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.keyboardDismissMode = .none
        self.tableView?.register(UINib(nibName: "titleCardTableViewCell", bundle: nil), forCellReuseIdentifier: "titleCardTableViewCell")
        self.tableView?.register(UINib(nibName: "InfoCardTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCardTableViewCell")
        self.tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 55
        case 1:
            let hei = self.babyObjecName?.meaning.heightForWithFont("".setBodyFont(), width: self.tableView.frame.width - 16)
            logger.log(hei)
            return hei! + 16
        case 3:
            let hei = self.babyObjecName?.origin.heightForWithFont("".setBodyFont(), width: self.tableView.frame.width - 16)
            logger.log(hei)
            return hei! +  16
        default:
            return 55
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            //
            var cell = tableView.dequeueReusableCell(withIdentifier: "titleCardTableViewCell", for: indexPath) as? titleCardTableViewCell
            if (cell == nil){ cell = titleCardTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.titleLbl.text = "\(AppStrings.MEANING):"
            switch babyObjecName!.type {
            case "male":
                cell?.titleLbl.textColor   = UIColor(hex: Constants.Colors.maleColor.rawValue)
            case "female":
                cell?.titleLbl.textColor    = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            case "unisex":
                cell?.titleLbl.textColor    = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            default:
                break
            }
                
            return cell!
        case 2:
            //
            var cell = tableView.dequeueReusableCell(withIdentifier: "titleCardTableViewCell", for: indexPath) as? titleCardTableViewCell
            if (cell == nil){ cell = titleCardTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.titleLbl.text = "\(AppStrings.ORIGIN):"
            switch babyObjecName!.type {
            case "male":
                cell?.titleLbl.textColor   = UIColor(hex: Constants.Colors.maleColor.rawValue)
            case "female":
                cell?.titleLbl.textColor    = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            case "unisex":
                cell?.titleLbl.textColor    = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            default:
                break
            }
            
            return cell!
        case 1:
            //
            var cell = tableView.dequeueReusableCell(withIdentifier: "InfoCardTableViewCell", for: indexPath) as? InfoCardTableViewCell
            if (cell == nil){ cell = InfoCardTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.infoLbl.text = self.babyObjecName?.meaning ?? ""
           
         
            return cell!
        case 3:
            //
            var cell = tableView.dequeueReusableCell(withIdentifier: "InfoCardTableViewCell", for: indexPath) as? InfoCardTableViewCell
            if (cell == nil){ cell = InfoCardTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.infoLbl.text = self.babyObjecName?.origin ?? ""
            
            return cell!
            
        default:
            var cell = tableView.dequeueReusableCell(withIdentifier: "InfoCardTableViewCell", for: indexPath) as? InfoCardTableViewCell
            if (cell == nil){ cell = InfoCardTableViewCell() }
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell!
        }
    }
    func initWithInfo(_ babyObject: NameObject) {
        self.babyObjecName = babyObject
        self.nameLabel.text = babyObject.name
        switch babyObject.type {
        case "male":
            self.mainView.backgroundColor   = UIColor(hex: Constants.Colors.maleColor.rawValue)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.maleColor.rawValue)
            logger.log("male")
        case "female":
            self.mainView.backgroundColor   = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.femaleColor.rawValue)
            logger.log("female")
        case "unisex":
            self.mainView.backgroundColor   = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            self.headerView.backgroundColor = UIColor(hex: Constants.Colors.neutralColor.rawValue)
            logger.log("unisex")
        default:
            break
        }

    }

    func setup() {
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        // Corner Radius
        layer.cornerRadius = 16.0;
    }
}
