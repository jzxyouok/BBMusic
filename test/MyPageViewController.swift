//
//  vc1.swift
//  test
//
//  Created by bb on 16/9/1.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MyPageButtonViewDelegate, MyPageUserViewDelegate {
    
    var headerView:MyPageHeaderView!
    var tableView:UITableView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyPageModel.radioStationArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RadioStationCell
        cell.itemImage.image = UIImage(named: MyPageModel.radioStationArray[indexPath.row]["image"]!)
        cell.markImage.image = UIImage(named: MyPageModel.radioStationArray[indexPath.row]["markImage"]!)
        cell.titleLabel.text = MyPageModel.radioStationArray[indexPath.row]["title"]
        cell.detailLabel.text = MyPageModel.radioStationArray[indexPath.row]["subtitle"]
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 64 - 60 - 10), style: .grouped)
        self.tableView.tag = 1
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(RadioStationCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorColor = SeparatorColor
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 0)
        headerView = MyPageHeaderView(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 3*WIN_WIDTH/16 + 30 + 10 + 110))
        headerView.myPageButtonView.delegate = self
        headerView.myPageUserView.delegate = self
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        //
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MyPageViewController.setupUI), name: NSNotification.Name(rawValue: "loginStatus"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MyPageViewController.setupUI), name: NSNotification.Name(rawValue: "RegisterStatus"), object: nil)
    }
    
    
    //设置／更新UI
    func setupUI(){
        DispatchQueue.main.async {
            if UserModel.isUserLogin == true{
                self.headerView.myPageUserView.alreadyUseTimeButton.isHidden = false
                self.headerView.myPageUserView.userImageButton.isHidden = false
                self.headerView.myPageUserView.memberButton.isHidden = false
                self.headerView.myPageUserView.userNameLabel.isHidden = false
                
                self.headerView.myPageUserView.tipsLabel.isHidden = true
                self.headerView.myPageUserView.loginButton.isHidden = true
            }else{
                self.headerView.myPageUserView.alreadyUseTimeButton.isHidden = true
                self.headerView.myPageUserView.userImageButton.isHidden = true
                self.headerView.myPageUserView.memberButton.isHidden = true
                self.headerView.myPageUserView.userNameLabel.isHidden = true
                
                self.headerView.myPageUserView.tipsLabel.isHidden = false
                self.headerView.myPageUserView.loginButton.isHidden = false
            }
        }
    }
    
    
    
    //MyPageUserView delegate代理方法
    func MyPageUserViewButtonAction(button: UIButton) {
        switch button.tag {
        case 0:
            if UserModel.isUserLogin == false{
                let vc = LoginViewController()
                let nvc = UINavigationController(rootViewController: vc)
                self.present(nvc, animated: true, completion: nil)
            }
            break
        case 1:
            
            break
        case 2:
            
            break
        case 3:
            
            break
        case 5:

            break
        default:
            break
        }
    }
    
    
    
    //MyPageHeaderView delegate代理方法
    func MyPageButtonViewButtonAction(button: UIButton) {
        switch button.tag {
        case 0:
            print("0")
            break
        case 1:
            
            break
        case 2:
            
            break
        case 3:
            self.navigationController?.pushViewController(RecentPlayViewController(), animated: true)
            break
        default:
            break
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
