//
//  vc1.swift
//  test
//
//  Created by bb on 16/9/1.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit




class vc1: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView1:UITableView!
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "1111+\(indexPath.row)"
        cell.accessoryType = .checkmark
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.lightGray
        
        
        tableView1 = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), style: .plain)
        tableView1.backgroundColor = UIColor.clear
        tableView1.tag = 1
        tableView1.showsHorizontalScrollIndicator = false
        tableView1.showsVerticalScrollIndicator = false
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView1.separatorColor = SeparatorColor
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        //headerView.backgroundColor = UIColor.gray
        tableView1.tableHeaderView = headerView
        self.view.addSubview(tableView1)
        
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.tableviewOffsetY), name: NSNotification.Name(rawValue: "tableview-offsetY"), object: nil)
       
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tableview-offsetY"), object: nil, userInfo: ["offsetY":offsetY, "tableview":"tableview1"])
    }
    
    
    func tableviewOffsetY(userInfo:NSNotification){
        let offsetY = userInfo.userInfo?["offsetY"] as! CGFloat
        let tableview = userInfo.userInfo?["tableview"] as! String
        if offsetY >= 96{
            if tableview != "tableview1"{
                tableView1.contentOffset.y = 96
            }else{
                tableView1.contentOffset.y = offsetY
            }
        }else{
            tableView1.contentOffset.y = offsetY
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("page01")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
