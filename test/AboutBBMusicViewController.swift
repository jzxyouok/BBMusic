//
//  AboutBBMusicViewController.swift
//  bbb
//
//  Created by bb on 16/8/18.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit

class AboutBBMusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var array = ["我来评分", "功能介绍", "用户协议", "版权指引", "邀请好友"]
    
    var tableView:UITableView!
    
    //生产1个section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 根据请求结果返回的数据，决定cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.textColor = TitleColor
        return cell
    }
    
    //section头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showProgressHUD(title: "马上更新，敬请期待～")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "关于BB音乐"
        self.view.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        //状态了背景色(透明)
        self.navigationController?.navigationBar.setBackgroundImage(imageMainColor, for: .default)
        self.navigationController?.navigationBar.shadowImage = imageMainColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navBarTintColor = UIColor.white
        
        //列表
        tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = SeparatorColor
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let headerView = AboutHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150))
        let footerView = AboutFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawerController.openDrawerGestureModeMask = .init(rawValue: 0)
        drawerController.closeDrawerGestureModeMask = .init(rawValue: 0)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        drawerController.openDrawerGestureModeMask = .all
        drawerController.closeDrawerGestureModeMask = .all
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
