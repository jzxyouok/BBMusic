//
//  moreViewController.swift
//  bbb
//
//  Created by bb on 16/8/16.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit

class CleanCacheViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var timer:DispatchSourceTimer?
    
    var tableView:UITableView!
    var backgroundView:UIView!
    var circularProgressView:CircularProgressView!
    var progressLabel:UIButton!
    var cleanTipsLabel:UILabel!

    //生产1个section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 根据请求结果返回的数据，决定cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CleanCacheModel.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = CleanCacheModel.data[indexPath.row]["title"] as? String
        let isChecked = CleanCacheModel.data[indexPath.row]["isChecked"] as! Bool
        if isChecked == true{
            cell.imageView?.image = UIImage(named: "checkbox_on")
        }else{
            cell.imageView?.image = UIImage(named: "checkbox_off")
        }
        return cell
    }
    
    
    //点击row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //标记选中
        for (index,_) in CleanCacheModel.data.enumerated(){
            if index == indexPath.row{
                let isChecked = CleanCacheModel.data[indexPath.row]["isChecked"] as! Bool
                if isChecked == true{
                    CleanCacheModel.data[index]["isChecked"] = false
                }else{
                    CleanCacheModel.data[index]["isChecked"] = true
                }
            }
        }
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "清理占用空间"
        //状态了背景色(透明)
        self.navigationController?.navigationBar.setBackgroundImage(imageMainColor, for: .default)
        self.navigationController?.navigationBar.shadowImage = imageMainColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.navBarTintColor = UIColor.white

        self.view.backgroundColor = UIColor.white

        //列表
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 60 - 44), style: .grouped)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.separatorColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
        self.tableView.tableHeaderView = UIView(frame: frame)
        self.view.addSubview(self.tableView)
        
        let clearButton = UIButton()
        clearButton.frame = CGRect(x: 15, y: self.view.frame.height - 64 - 60 - 44 + 5, width: WIN_WIDTH - 30, height: 34)
        clearButton.setTitle("一键清理", for: .normal)
        clearButton.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5), for: .disabled)
        clearButton.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8), for: .highlighted)
        clearButton.setBackgroundImage(imageMainColor, for: .normal)
        clearButton.setBackgroundImage(imageDisabled, for: .disabled)
        clearButton.setBackgroundImage(imageHightLight, for: .highlighted)
        clearButton.layer.cornerRadius = 5
        clearButton.clipsToBounds = true
        clearButton.addTarget(self, action: #selector(clearCache), for: .touchUpInside)
        self.view.addSubview(clearButton)
        
        //进度背景
        backgroundView = UIView(frame: self.view.frame)
        backgroundView.backgroundColor = MainColor
        self.view.addSubview(backgroundView)
        //进度 圆圈
        circularProgressView = CircularProgressView(frame: CGRect(x: 50, y: (self.view.frame.height - 64 - 60 - self.view.frame.width + 100)/2, width: self.view.frame.width - 100, height: self.view.frame.width - 100))
        circularProgressView.backgroundColor = UIColor.clear
        circularProgressView.progress = 0
        self.view.addSubview(circularProgressView)
        //进度100%
        progressLabel = UIButton(frame: circularProgressView.frame)
        progressLabel.titleLabel?.lineBreakMode = .byWordWrapping
        progressLabel.setTitle("0%", for: .normal)
        progressLabel.setTitleColor(UIColor.white, for: .normal)
        progressLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        self.view.addSubview(progressLabel)
        
        //“正在清理xx” 提示
        cleanTipsLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.height - 64 - 60 - 88, width: self.view.frame.width, height: 44))
        cleanTipsLabel.text = "正在清理..."
        cleanTipsLabel.textAlignment = .center
        cleanTipsLabel.textColor = UIColor.white
        cleanTipsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.view.addSubview(cleanTipsLabel)
        
        countingTime(time: 0)
    }
    
    //定时器
    func countingTime(time:Int){
        var total = time
        timer?.cancel()
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        // 设定这个时间源是0.3秒循环一次，立即开始
        timer?.scheduleRepeating(deadline: .now(), interval: 1)
        timer?.setEventHandler {
            total += 25
            if total <= 100{
                DispatchQueue.main.async(execute: { 
                    self.circularProgressView.progress = Float(total)
                    self.progressLabel.setTitle("\(total)%", for: .normal)
                    UIView.animate(withDuration: 0.6, animations: {
                        if self.cleanTipsLabel.alpha == 1{
                            self.cleanTipsLabel.alpha = 0
                        }else{
                            self.cleanTipsLabel.alpha = 1
                        }
                    })
                })
            }else{
                DispatchQueue.main.async(execute: {
                    self.cleanTipsLabel.removeFromSuperview()
                    UIView.animate(withDuration: 0.5, animations: { 
                        self.backgroundView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
                        self.circularProgressView.frame = CGRect(x: (self.view.frame.width - 120)/2, y: 15, width: 120, height: 120)
                        self.progressLabel.frame = self.circularProgressView.frame
                    }, completion: { (true) in
                        self.progressLabel.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                        let str = diverseStringOriginalStr(original: "推荐清理\n\(BBCacheTool.cacheSize)MB", conversionStr: BBCacheTool.cacheSize, withFont:UIFont.systemFont(ofSize: 24), withColor:UIColor.white)
                        self.progressLabel.setAttributedTitle(str, for: .normal)
                    })
                })
                self.timer?.cancel()
            }
        }
        timer?.resume()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY >= 0{
            backgroundView.frame = CGRect(x: 0, y: -offsetY, width: self.view.frame.width, height: 150)
            circularProgressView.frame.origin.y = 15-offsetY
            progressLabel.frame.origin.y = 15-offsetY
        }else{
            backgroundView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150-offsetY)
            circularProgressView.frame.origin.y = 15-offsetY/2
            progressLabel.frame.origin.y = 15-offsetY/2
        }
    }
    
    //一键清理
    func clearCache(){
        BBCacheTool.clearCache()
        let str = diverseStringOriginalStr(original: "推荐清理\n\(BBCacheTool.cacheSize)MB", conversionStr: BBCacheTool.cacheSize, withFont:UIFont.systemFont(ofSize: 24), withColor:UIColor.white)
        self.progressLabel.setAttributedTitle(str, for: .normal)
        self.tableView.reloadData()
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawerController.openDrawerGestureModeMask = .init(rawValue: 0)
        drawerController.closeDrawerGestureModeMask = .init(rawValue: 0)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        self.timer?.cancel()
        self.timer = nil
        drawerController.openDrawerGestureModeMask = .all
        drawerController.closeDrawerGestureModeMask = .all
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
