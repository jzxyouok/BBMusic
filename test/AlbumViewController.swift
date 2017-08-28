//
//  SongResultViewController.swift
//  test
//
//  Created by bb on 2017/1/16.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var AlbumTableView:UITableView!
    
    
    // 点击列表
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
    
    // 根据请求结果返回的数据，决定cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialListModelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialListCell", for: indexPath) as! SpecialListCell
        cell.accessoryType = .disclosureIndicator
        let imgurl = specialListModelArray[indexPath.row].imgurl.replacingOccurrences(of: "{size}", with: "")
        let url = URL(string: imgurl)
        cell.itemImage.sd_setImage(with: url, placeholderImage: UIImage(named: "demo6"))
        cell.titleLabel.text = specialListModelArray[indexPath.row].specialname
        //富文本
        cell.titleLabel.attributedText = diverseStringOriginalStr(original: specialListModelArray[indexPath.row].specialname, conversionStr:SearchKeywordModel.keyword, withFont:UIFont.systemFont(ofSize: 15), withColor:MainColor)
        //富文本
        cell.subTitle.attributedText = diverseStringOriginalStr(original: specialListModelArray[indexPath.row].nickname, conversionStr:SearchKeywordModel.keyword, withFont:UIFont.systemFont(ofSize: 12), withColor:MainColor)
        cell.detailLabel.text = "\(specialListModelArray[indexPath.row].songcount)首，播放: \(Common.playCount(count: Double(specialListModelArray[indexPath.row].playcount)))次"
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpecialModel.page = 0
        specialListModelArray.removeAll()
        
        //设置searchSongViewController背景色为白色
        self.view.backgroundColor = UIColor.white
        
        //搜索结果列表
        self.AlbumTableView = UITableView()
        self.AlbumTableView.register(SpecialListCell.self, forCellReuseIdentifier: "SpecialListCell")
        self.AlbumTableView.delegate = self
        self.AlbumTableView.dataSource = self
        self.AlbumTableView.separatorColor = SeparatorColor
        self.AlbumTableView.tableFooterView = UIView()
        self.AlbumTableView.separatorInset = UIEdgeInsets(top: 0, left: 85, bottom: 0, right: 0)
        self.view.addSubview(self.AlbumTableView)
        self.AlbumTableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        
        //默认【上拉加载】
        self.AlbumTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(SpecialViewController.loadMoreData))
        
        
        //监听关键字搜索结果
        NotificationCenter.default.addObserver(self, selector: #selector(SpecialViewController.reloadData), name:NSNotification.Name(rawValue: "SpecialListSearchDone"), object: nil)
    }
    
    //主线程中更新数据
    func reloadData(){
        DispatchQueue.main.async(execute: {
            self.AlbumTableView.reloadData()
            var marginBottom:CGFloat = 0
            if keywordRecommendModel.isRecommend == true{
                marginBottom = -52
            }
            self.AlbumTableView.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.view).offset(marginBottom)
            })
            //数据是否加载完成
            if SpecialModel.noMoreData == false{
                self.AlbumTableView.mj_footer.endRefreshing()
            }else{
                self.AlbumTableView.mj_footer.endRefreshingWithNoMoreData()
            }
        })
    }
    
    
    
    //初始化单曲列表/加载更多数据
    func loadMoreData(){
        SpecialModel.page += 1
        Kugou_SpecialListSearch_Http.specialListSearchRequest(keyword: SearchKeywordModel.keyword, page: SpecialModel.page)
    }
    
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadMoreData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
