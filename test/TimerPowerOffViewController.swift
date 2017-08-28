//
//  moreViewController.swift
//  bbb
//
//  Created by bb on 16/8/16.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit

class TimerPowerOffViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var remainTime:String = ""
    
    var tableView:UITableView!

    
    //生产5个section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 根据请求结果返回的数据，决定cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimePowerOffModel.data.count
    }
    
    
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TimePowerOffCell
        cell.titleLabel.text = TimePowerOffModel.data[indexPath.row]["title"] as? String
        let isChecked = TimePowerOffModel.data[indexPath.row]["isChecked"] as! Bool
        if isChecked == true{
            switch indexPath.row {
            case 0:
                break
            case TimePowerOffModel.data.count - 1:
                break
            default:
                cell.subtitleLabel.text = self.remainTime
            }
            cell.selectedButton.isSelected = true
        }else{
            cell.subtitleLabel.text = ""
            cell.selectedButton.isSelected = false
        }
        return cell
    }
    
    //section头部高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    
    //点击row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //标记选中
        for (index,_) in TimePowerOffModel.data.enumerated(){
            if index == indexPath.row{
                TimePowerOffModel.data[index]["isChecked"] = true
            }else{
                TimePowerOffModel.data[index]["isChecked"] = false
            }
        }
        tableView.reloadData()

        var leftTime = 0
        switch indexPath.row {
        case 0:
            leftTime = 0
            break
        case 1:
            leftTime = 15
            break
        case 2:
            leftTime = 30
            break
        case 3:
            leftTime = 60
            break
        case 4:
            leftTime = 90
            break
        case TimePowerOffModel.data.count - 1:
            leftTime = 0
            break
        default:
            break
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TimePowerOff"), object: nil, userInfo: ["leftTime":leftTime])
    }
    
    //监听定时起剩余时间 动作
    func initTimer(notification: Notification){
        self.remainTime = notification.userInfo?["leftTime"] as! String
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "定时关闭"
        self.view.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        //状态了背景色(透明)
        self.navigationController?.navigationBar.setBackgroundImage(imageMainColor, for: .default)
        self.navigationController?.navigationBar.shadowImage = imageMainColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navBarTintColor = UIColor.white

        //列表
        tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.register(TimePowerOffCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LeftViewController.initTimer), name: NSNotification.Name(rawValue: "TimePowerOffUpdating"), object: nil)
        
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
