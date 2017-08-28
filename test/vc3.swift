//
//  vc1.swift
//  test
//
//  Created by bb on 16/9/1.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit




class vc3: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView3:UITableView!
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "3333"
        cell.accessoryType = .checkmark
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.lightGray
        
        
        tableView3 = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
        tableView3.tag = 3
        tableView3.showsHorizontalScrollIndicator = false
        tableView3.showsVerticalScrollIndicator = false
        tableView3.delegate = self
        tableView3.dataSource = self
        tableView3.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView3.separatorColor = SeparatorColor
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        //headerView.backgroundColor = UIColor.red
        tableView3.tableHeaderView = headerView
        self.view.addSubview(tableView3)
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.tableviewOffsetY), name: NSNotification.Name(rawValue: "tableview-offsetY"), object: nil)
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tableview-offsetY"), object: nil, userInfo: ["offsetY":offsetY, "tableview":"tableview3"])
    }
    
    
    func tableviewOffsetY(userInfo:NSNotification){
        let offsetY = userInfo.userInfo?["offsetY"] as! CGFloat
        let tableview = userInfo.userInfo?["tableview"] as! String
        if offsetY >= 96{
            if tableview != "tableview3"{
                tableView3.contentOffset.y = 96
            }else{
                tableView3.contentOffset.y = offsetY
            }
        }else{
            tableView3.contentOffset.y = offsetY
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
