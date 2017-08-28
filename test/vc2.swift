//
//  vc1.swift
//  test
//
//  Created by bb on 16/9/1.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit




class vc2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView2:UITableView!
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "2222"
        cell.accessoryType = .checkmark
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.lightGray
        
        tableView2 = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
        tableView2.tag = 2
        tableView2.showsHorizontalScrollIndicator = false
        tableView2.showsVerticalScrollIndicator = false
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView2.separatorColor = SeparatorColor
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        //headerView.backgroundColor = UIColor.green
        tableView2.tableHeaderView = headerView
        self.view.addSubview(tableView2)
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.tableviewOffsetY), name: NSNotification.Name(rawValue: "tableview-offsetY"), object: nil)
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tableview-offsetY"), object: nil, userInfo: ["offsetY":offsetY, "tableview":"tableview2"])
    }
    

    func tableviewOffsetY(userInfo:NSNotification){
        let offsetY = userInfo.userInfo?["offsetY"] as! CGFloat
        let tableview = userInfo.userInfo?["tableview"] as! String
        if offsetY >= 96{
            if tableview != "tableview2"{
                tableView2.contentOffset.y = 96
            }else{
                tableView2.contentOffset.y = offsetY
            }
        }else{
            tableView2.contentOffset.y = offsetY
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
