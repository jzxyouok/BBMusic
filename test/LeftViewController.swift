//
//  moreViewController.swift
//  bbb
//
//  Created by bb on 16/8/16.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit
import DrawerController

class LeftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LeftViewControllerFooterViewDelegate {
    

    let sectionArray = ["仅Wi-Fi联网", "定时关闭", "免流量服务", "传歌到手机", "BPlay与车载音乐", "清理占用空间", "帮助与反馈", "关于BB音乐"]
    let imageArray = ["more_icon_only_wireless","more_icon_timer","more_icon_chinaunicom_small","more_icon_importsongs","more_icon_qplaycar","more_icon_cleancache","more_icon_concisepattern","more_icon_about"]
    
    var tableView:UITableView!
    var leftViewControllerFooterView:LeftViewControllerFooterView!
    
    var remainTime:String = ""
    var switchItem:UISwitch!
    var remainTimeLabel:UILabel!
    var timer:DispatchSourceTimer?
    
    
    //开始倒计时
    func resumeTimer(time:Int){
        // 定义需要计时的时间
        var total = time * 60
        // 在global线程里创建一个时间源
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        timer?.scheduleRepeating(deadline: .now(), interval: .seconds(1))
        // 设定时间源的触发事件
        timer?.setEventHandler(handler: {
            // 每秒计时一次
            total -= 1
            // 时间到了取消时间源
            if total <= 0 {
                self.timer?.cancel()
            }
            self.remainTime = Common.stringFromTimeInterval(interval: Double(total))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TimePowerOffUpdating"), object: nil, userInfo: ["leftTime":self.remainTime])
            DispatchQueue.main.async {
                self.remainTimeLabel.text = self.remainTime
            }
        })
        // 启动时间源
        timer?.resume()
    }
    
    func cancelTimer(){
        timer?.cancel()
        timer = nil
    }

    //接收监听
    func initTimer(notification: Notification){
        let leftTime = notification.userInfo?["leftTime"] as! Int
        guard leftTime != 0 else {
            self.remainTime = ""
            DispatchQueue.main.async {
                self.remainTimeLabel.text = self.remainTime
            }
            cancelTimer()
            return
        }
        //启动定时器
        resumeTimer(time: leftTime)
    }
    
    func switchWifi(sender:UISwitch){
        APPSetting.setWifiOnly(isChecked: sender.isOn)
    }
    
    
    //生产5个section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 根据请求结果返回的数据，决定cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "moreListCell")
        cell.imageView?.image = UIImage(named: imageArray[indexPath.row])
        cell.textLabel?.text = sectionArray[indexPath.row]
        cell.textLabel?.textColor = TitleColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: defaultSize_14_16)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: defaultSize_11_12)
        switch indexPath.row {
        case 0:
            switchItem = UISwitch()
            switchItem.setOn(APPSetting.isWifiOnly, animated: false)
            switchItem.addTarget(self, action: #selector(switchWifi), for: .valueChanged)
            cell.accessoryView = switchItem
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            break
        case 1:
            remainTimeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            remainTimeLabel.font = UIFont.systemFont(ofSize: defaultSize_11_12)
            remainTimeLabel.text = remainTime
            remainTimeLabel.textColor = detailTextColor
            remainTimeLabel.textAlignment = .right
            cell.accessoryView = remainTimeLabel
            break
        case 2:
            cell.detailTextLabel?.text = "在线听歌免流量"
            break
        default:
            break
        }
        return cell
    }

    
    //点击row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        guard indexPath.row != 0 else {
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leftViewCellClick"), object: indexPath.row)
        closeDrawer()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRect(x: 0, y: 0, width: WIN_WIDTH - 60, height: WIN_HEIGHT)
        
        self.view.backgroundColor = UIColor.white
        
        let leftViewControllerHeaderView = LeftViewControllerHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: WIN_WIDTH*170/375))
        self.view.addSubview(leftViewControllerHeaderView)
        
        leftViewControllerFooterView = LeftViewControllerFooterView(frame: CGRect(x: 15, y: self.view.frame.height - 60, width: self.view.frame.width - 30, height: 60))
        leftViewControllerFooterView.delegate = self
        self.view.addSubview(leftViewControllerFooterView)
        
        //列表
        tableView = UITableView(frame: CGRect(x: 0, y: WIN_WIDTH*170/375, width: self.view.frame.width, height: self.view.frame.height - WIN_WIDTH*170/375 - 60), style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "moreListCell")
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LeftViewController.setupUI), name: NSNotification.Name(rawValue: "loginStatus"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LeftViewController.setupUI), name: NSNotification.Name(rawValue: "RegisterStatus"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LeftViewController.initTimer), name: NSNotification.Name(rawValue: "TimePowerOff"), object: nil)
        
    }
    
    //delegate
    func leftFooterButtonAction(button: UIButton) {
        switch button.tag {
        case 1001:
            print("setting")
            break
        case 1002:
            if UserModel.isUserLogin == true{
                UserModel.logout()
                setupUI()
            }else{
                let vc = LoginViewController()
                let nvc = UINavigationController(rootViewController: vc)
                self.present(nvc, animated: true, completion: nil)
            }
            break
        default:
            break
        }
    }
    
    
    //设置／更新UI
    func setupUI(){
        let title = UserModel.isUserLogin == true ? "退出登录" : "立即登录"
        let imageName = UserModel.isUserLogin == true ? "more_icon_bottom_logout" : "more_icon_bottom_login"
        DispatchQueue.main.async { 
            self.leftViewControllerFooterView.logoutButton.setTitle(title, for: .normal)
            self.leftViewControllerFooterView.logoutButton.setImage(UIImage(named:imageName), for: .normal)
            self.leftViewControllerFooterView.logoutButton.setImage(UIImage(named:imageName), for: .highlighted)
        }
    }
    
    
    func closeDrawer(){
        drawerController.closeDrawer(animated: true, completion: nil)
    }
    
    //关闭左侧抽屉
    override func viewDidDisappear(_ animated: Bool) {
        closeDrawer()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
