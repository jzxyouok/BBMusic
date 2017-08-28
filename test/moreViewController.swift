//
//  moreViewController.swift
//  bbb
//
//  Created by bb on 16/8/16.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit

class TimerPowerOffViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let array = ["不开启", "15分钟", "30分钟", "60分钟", "90分钟", "自定义"]
    
    var tableView:UITableView!
    
    
    //生产5个section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 根据请求结果返回的数据，决定cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = array[indexPath.row]
        cell.detailTextLabel?.text = "11"
        return cell
    }
    
    //section尾部高度
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.0
//    }
    //section头部高度
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.0
//    }

    
    //点击row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "定时关闭"
        //修改导航栏背景色
        self.navigationController?.navigationBar.barTintColor = MainColor
        
        self.view.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        //修改返回按钮 颜色 UIBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        //修改title颜色
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]

        //列表
        tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
