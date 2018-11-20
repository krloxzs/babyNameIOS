//
//  AboutUSViewController.swift
//  babyNameIOS
//
//  Created by Carlos Rodriguez on 12/13/17.
//  Copyright © 2017 Carlos Rodriguez. All rights reserved.
//

import UIKit

class LicensesVC: BaseViewController,UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let loginHandler = LoginHandler.sharedInstance
    var userInfo: UserItem?
    let MIT = "\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the Software), to deal\nin the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
    var LicensesArray = [""]
    
    
    
    
    override func viewDidLoad() {
        self.title = "\(AppStrings.LICENSES)"
        LicensesArray = [
            "---TextFieldEffects/LICENSE\n\naulriera/TextFieldEffects is licensed under the MIT License A short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.\n\n \(MIT)",
            "---SDWebImage/LICENSE\n\n rs/SDWebImage is licensed under the MIT License A short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.\n\(MIT)",
            "---Alamofire/LICENSE\n\nAlamofire/Alamofire is licensed under the\nMIT License\n\nA short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.\n\(MIT)",
            "---SwiftyJSON/LICENSE SwiftyJSON/SwiftyJSON is licensed under the MIT License A short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.\n\n \(MIT)",
            "---MBProgressHUD/LICENSE\n\ndg/MBProgressHUD is licensed under the MIT License A short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.\n\n \(MIT)"]
        super.navigationBackButton = NavigationBackButton.navigationBackButtonDefault
        super.navigationBarType = NavigationBarType.navigationBarTypeDefault
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setupTV()
        // Do any additional setup after loading the view.
    }
    func setupTV() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.keyboardDismissMode = .none
        
        self.tableView?.register(UINib(nibName: "LicensesTableViewCell", bundle: nil), forCellReuseIdentifier: "LicensesTableViewCell")
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK:- ScrollViewDElegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        default:
            var cell = tableView.dequeueReusableCell(withIdentifier: "LicensesTableViewCell", for: indexPath) as? LicensesTableViewCell
            if (cell == nil){ cell = LicensesTableViewCell() }
            cell?.selectionStyle = UITableViewCell.SelectionStyle.none
            cell?.textInfo.text = self.LicensesArray[indexPath.row]
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        default:
            let hei = self.LicensesArray[indexPath.row].heightForWithFont("".setBodyFont(), width: self.tableView.frame.width )
            return hei
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

