//
//  vc1.swift
//  test
//
//  Created by bb on 16/9/1.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit

class RealTimeSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var realTimeTableView:UITableView!
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realTimeSearchModelArray.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RealTimeSearchCell
        cell.keywordLabel.text = "\(realTimeSearchModelArray[indexPath.row].keyword)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.realTimeTableView.deselectRow(at: indexPath, animated: true)
        SearchKeywordModel.keyword = realTimeSearchModelArray[indexPath.row].keyword
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchByRealTimeKeyword"), object: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Kugou_RealTimeSearch_Http.realTimeSearchRequest(keyword: SearchKeywordModel.keyword)
        
        self.realTimeTableView = UITableView(frame: self.view.frame, style: .plain)
        self.realTimeTableView.showsHorizontalScrollIndicator = false
        self.realTimeTableView.showsVerticalScrollIndicator = false
        self.realTimeTableView.delegate = self
        self.realTimeTableView.dataSource = self
        self.realTimeTableView.register(RealTimeSearchCell.self, forCellReuseIdentifier: "cell")
        self.realTimeTableView.separatorColor = SeparatorColor
        self.realTimeTableView.tableFooterView = UIView()
        self.view.addSubview(realTimeTableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SongViewController.reloadData), name:NSNotification.Name(rawValue: "RealTimeSearchDone"), object: nil)

    }
    
    
    //主线程中更新数据
    func reloadData(){
        DispatchQueue.main.async(execute: {
            self.realTimeTableView.reloadData()
        })
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
