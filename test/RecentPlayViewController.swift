//
//  RecentPlayViewController.swift
//  test
//
//  Created by bb on 16/9/1.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit

class RecentPlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RecentPlayHeaderViewDelegate, RecentPlayFooterViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var tableView:UITableView!

    var hiddenTextField:UITextField!
    
    var pickView:UIPickerView!
    
    var toolBar:UIToolbar!
    
    // 点击列表
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //初始化当前播放歌曲数据(本地／网络)
        currentSongInfoModel_kugou.initCurrentSongInfoData(array: recentPlayListModelArray, index: indexPath.row)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if recentPlayListModelArray.count == 0{
            return 0
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentPlayListModelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongListCell", for: indexPath) as! SongListCell
        let othername = recentPlayListModelArray[indexPath.row].othername != "" ? " - "+recentPlayListModelArray[indexPath.row].othername:""
        let album_name = recentPlayListModelArray[indexPath.row].album_name != "" ? " -《"+recentPlayListModelArray[indexPath.row].album_name+"》":""
        //根据hash检测是否已缓存过
        let hash = recentPlayListModelArray[indexPath.row].songhash
        let dic = CheckCache.isCached(hash: hash)
        let isCached = dic["isCached"] as! Bool
        //是否显示已缓存图标
        cell.isCachedImage.isHidden = !isCached
        cell.titleLabel.text = recentPlayListModelArray[indexPath.row].songname + othername
        cell.detailLabel.text = recentPlayListModelArray[indexPath.row].singername + album_name
        //更新detailLabel 位移
        var marginLeft:CGFloat = 15
        if isCached == true{
            marginLeft = 30
        }
        cell.detailLabel.snp.updateConstraints { (make) in
            make.left.equalTo(marginLeft)
        }
        cell.moreActionButton.addTarget(self, action: #selector(RecentPlayViewController.moreAction), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = RecentPlayHeaderView()
        sectionHeaderView.frame = CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 44)
        return sectionHeaderView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //查询最近部分 记录
        RecentPlaySQLite.prepare()
        
        self.title = "最近播放"
        
        //状态了背景色(透明)
        self.navigationController?.navigationBar.setBackgroundImage(imageMainColor, for: .default)
        self.navigationController?.navigationBar.shadowImage = imageMainColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navBarTintColor = UIColor.white
        
        let image = scaleToSize(img: UIImage(named: "more_icon_settings")!, size: CGSize(width: 40, height: 40))
        let rightBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(RecentPlayViewController.recentPlayAction))
        //消除右侧 button与窗口距离
        let rightSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightSpacer.width = -10
        self.navigationItem.rightBarButtonItems = [rightSpacer, rightBtn]
        
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: WIN_HEIGHT - 64), style: .plain)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SongListCell.self, forCellReuseIdentifier: "SongListCell")
        tableView.separatorColor = SeparatorColor
        let footView = RecentPlayFooterView(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 44))
        footView.delegate = self
        if recentPlayListModelArray.count != 0{
            tableView.tableFooterView = footView
        }else{
            tableView.tableFooterView = UIView()
        }
        self.view.addSubview(tableView)

        initPickView()
        
        //监听下载/缓冲完成
        NotificationCenter.default.addObserver(self, selector: #selector(SongViewController.reloadData), name:NSNotification.Name(rawValue: "downLoadFileDone"), object: nil)
    }
    
    
    func initPickView(){
        
        pickView = UIPickerView()
        pickView.backgroundColor = UIColor.white
        pickView.dataSource = self
        pickView.delegate = self
        
        toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 44)
        toolBar.backgroundColor = UIColor.white
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        let cancel = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(pickViewClose))
        let comfirm = UIBarButtonItem(title: "确定", style: .plain, target: self, action: #selector(pickViewClose))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let titleLabel = UILabel(frame: CGRect(x: (WIN_WIDTH - 150)/2, y: 0, width: 150, height: 44))
        titleLabel.text = "试听缓存设置"
        titleLabel.textColor = UIColor.darkGray
        titleLabel.textAlignment = .center
        flexibleSpace.customView = titleLabel
        cancel.tintColor = UIColor.darkGray
        comfirm.tintColor = MainColor
        toolBar.items = [cancel, flexibleSpace, comfirm]
        
        //隐藏文本框
        hiddenTextField = UITextField()
        hiddenTextField.isHidden = true
        hiddenTextField.inputView = pickView
        hiddenTextField.inputAccessoryView = toolBar
        self.view.addSubview(hiddenTextField)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RecentPlayModel.countSetting.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let str = RecentPlayModel.countSetting[row].0
        return str
    }
    
    
    //主线程中更新数据
    func reloadData(){
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    

    //点击了更多
    func moreAction(button: UIButton){
        let songhash = recentPlayListModelArray[button.tag].songhash
        print("点击了更多,songhash为:\(songhash)")
    }
    
    //RecentPlayHeaderViewDelegate
    func recentPlayAction(button:UIButton) {
        switch button.tag {
        case 900:
            print("随机播放全部")
            break
        case 901:
            print("管理")
            break
        default:
            print("setting")
            self.hiddenTextField.becomeFirstResponder()
            break
        }
    }
    //RecentPlayFooterViewDelegate
    func clearAllRecordAction(button: UIButton) {
        switch button.tag {
        case 902:
            print("清除所有办法纪录")
            RecentPlayModel.clearAllRecentPlayRecord()
            self.tableView.tableFooterView = UIView()
            self.tableView.reloadData()
            break
        default:
            break
        }
    }
    
    
    //点击 取消／确认 关闭pickView
    func pickViewClose(){
        self.hiddenTextField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawerController.openDrawerGestureModeMask = .init(rawValue: 0)
        drawerController.closeDrawerGestureModeMask = .init(rawValue: 0)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        drawerController.openDrawerGestureModeMask = .all
        drawerController.closeDrawerGestureModeMask = .all
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
