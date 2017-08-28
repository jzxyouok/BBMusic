//
//  SearchRecordViewController.swift
//  bbb
//
//  Created by bb on 16/8/24.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit


class SearchRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var searchTextField:UITextField!
    var recordTableView:UITableView!
    var searchType:Int = 0
    var recordArray = [String]()
    
    
    //初始化列表数据
    func initTableViewData(){
        //初始化数据（本地存储）
        var localStorageDictionar = searchRecordModel.userDefault.dictionaryRepresentation()
        if localStorageDictionar["recordArray"] != nil{
            let localStorageRecordArray = searchRecordModel.userDefault.array(forKey: "recordArray")
            if localStorageRecordArray?.count != 0{
                recordArray = localStorageRecordArray as! [String]
            }else{
                recordArray = searchRecordModel.recordArray
            }
        }
        self.recordTableView.reloadData()
    }

   
    // 点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.recordTableView.deselectRow(at: indexPath, animated: true)
        SearchKeywordModel.keyword = recordArray[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchByRealTimeKeyword"), object: nil)
    }
    
    //section个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    
    //高度：热搜118 ／ 搜索记录 44
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return SearchRecordModel.h
        }else{
            return 44
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    //自定义section view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = SearchRecordListTitleView.init(frame: self.view.bounds)
        sectionView.titleLabel.font = UIFont.systemFont(ofSize: 14)
        sectionView.backgroundColor = UIColor.white
        switch section {
        case 0:
            sectionView.titleLabel.text = "\(searchRecordModel.titleArray[section])"
            break
        case 1:
            if recordArray.count != 0{
                sectionView.titleLabel.text = "\(searchRecordModel.titleArray[section])"
                sectionView.titleButton.setTitle("清空历史", for: .normal)
                sectionView.titleButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                sectionView.titleButton.addTarget(self, action: #selector(SearchRecordViewController.delectLocalStorageSearchRecord), for: .touchUpInside)
            }else{
                //若记录为空，移除对应的sectionview
                sectionView.removeFromSuperview()
            }
            break
        default:
            break
        }
        return sectionView
    }
    
    
    
    // 根据请求结果返回的数据，决定cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return recordArray.count
        }
    }
    
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchRecordListCell.init(style: .default, reuseIdentifier: "recordListCell")
        //自定义 热搜
        if indexPath.section == 0{
            if indexPath.row == 0{
                cell.selectionStyle = .none
            }
            self.recordTableView.separatorColor = UIColor.clear
            let hotRecord = HotSearchKeywordView.init(frame: CGRect(x: 0, y: 6, width: WIN_WIDTH, height: SearchRecordModel.h))
            for subview in cell.subviews{
                subview.removeFromSuperview()
            }
            cell.addSubview(hotRecord)
        }else{
            self.recordTableView.separatorColor = SeparatorColor
            cell.keywordLabel.text = "\(recordArray[indexPath.row])"
            cell.removeItemBtn.addTarget(self, action: #selector(SearchRecordViewController.delectLocalStorageSearchRecord), for: .touchUpInside)
            cell.removeItemBtn.tag = indexPath.row
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置searchSongViewController背景色为白色
        self.view.backgroundColor = UIColor.white
        
        //搜索结果列表
        self.recordTableView = UITableView(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: WIN_HEIGHT - 60 - 64))
        self.recordTableView.register(SearchRecordListCell.self, forCellReuseIdentifier: "recordListCell")
        self.recordTableView.delegate = self
        self.recordTableView.dataSource = self
        self.recordTableView.tableFooterView = UIView()
        self.view.addSubview(self.recordTableView)
        
        //监听热门关键字请求结果
        NotificationCenter.default.addObserver(self, selector: #selector(SearchRecordViewController.reloadData), name:NSNotification.Name(rawValue: "HotKeywordSearchDone"), object: nil)
        //热门关键字 请求
        Kugou_HotKeywordSearch_Http.hotKeywordSearchRequest(count: 50)
    }
    
    //删除搜索记录
    func delectLocalStorageSearchRecord(_ sender:UIButton){
        searchRecordModel.delectLocalStorageSearchRecord(index: sender.tag)
        initTableViewData()
    }
    
    
    func reloadData(){
        DispatchQueue.main.async(execute: {
            self.recordTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initTableViewData()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
