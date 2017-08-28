//
//  SongResultViewController.swift
//  test
//
//  Created by bb on 2017/1/16.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import MJRefresh

class SongViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var songTableView:UITableView!

    
    // 点击列表
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //初始化当前播放歌曲数据(本地／网络)
        currentSongInfoModel_kugou.initCurrentSongInfoData(array: songListModel1Array, index: indexPath.row)
    }
    
    
    // 根据请求结果返回的数据，决定cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songListModel1Array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    
    // 生成cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongListCell", for: indexPath) as! SongListCell
        let othername = songListModel1Array[indexPath.row].othername != "" ? " - "+songListModel1Array[indexPath.row].othername:""
        let album_name = songListModel1Array[indexPath.row].album_name != "" ? " -《"+songListModel1Array[indexPath.row].album_name+"》":""
        let songname = songListModel1Array[indexPath.row].songname
        let singername = songListModel1Array[indexPath.row].singername
        //根据hash检测是否已缓存过
        let hash = songListModel1Array[indexPath.row].songhash
        let dic = CheckCache.isCached(hash: hash)
        let isCached = dic["isCached"] as! Bool
        //是否显示已缓存图标
        cell.isCachedImage.isHidden = !isCached
        //富文本
        cell.titleLabel.attributedText = diverseStringOriginalStr(original: songname + othername, conversionStr:SearchKeywordModel.keyword, withFont:UIFont.systemFont(ofSize: 15), withColor:MainColor)
        //富文本
        cell.detailLabel.attributedText = diverseStringOriginalStr(original: singername + album_name, conversionStr:SearchKeywordModel.keyword, withFont:UIFont.systemFont(ofSize: 12), withColor:MainColor)
        //更新detailLabel 位移
        var marginLeft:CGFloat = 15
        if isCached == true{
            marginLeft = 30
        }
        cell.detailLabel.snp.updateConstraints { (make) in
            make.left.equalTo(marginLeft)
        }
        cell.moreActionButton.addTarget(self, action: #selector(SongViewController.moreAction), for: .touchUpInside)
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SongModel.page = 0
        songListModel1Array.removeAll()
        //初始化单曲列表/加载更多数据
        loadMoreData()
        
        //设置searchSongViewController背景色为白色
        self.view.backgroundColor = UIColor.white

        //搜索结果列表
        self.songTableView = UITableView()
        self.songTableView.register(SongListCell.self, forCellReuseIdentifier: "SongListCell")
        self.songTableView.delegate = self
        self.songTableView.dataSource = self
        self.songTableView.separatorColor = SeparatorColor
        self.songTableView.tableFooterView = UIView()
        self.view.addSubview(self.songTableView)
        self.songTableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.top.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        
        //默认【上拉加载】
        self.songTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(SongViewController.loadMoreData))
        
        
        //监听关键字搜索结果
        NotificationCenter.default.addObserver(self, selector: #selector(SongViewController.reloadData), name:NSNotification.Name(rawValue: "SongListSearchDone"), object: nil)
        //监听下载/缓冲完成
        NotificationCenter.default.addObserver(self, selector: #selector(SongViewController.reloadData), name:NSNotification.Name(rawValue: "downLoadFileDone"), object: nil)
        //监听关键字推荐请求结果
        NotificationCenter.default.addObserver(self, selector: #selector(SearchResultViewController.reloadData), name:NSNotification.Name(rawValue: "KeyRecommendSearchDone"), object: nil)
    }

    //主线程中更新数据
    func reloadData(){
        DispatchQueue.main.async(execute: {
            self.songTableView.reloadData()
            var marginBottom:CGFloat = 0
            if keywordRecommendModel.isRecommend == true{
                marginBottom = -52
            }
            self.songTableView.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.view).offset(marginBottom)
            })
            //数据是否加载完成
            if SongModel.noMoreData == false{
                self.songTableView.mj_footer.endRefreshing()
            }else{
                self.songTableView.mj_footer.endRefreshingWithNoMoreData()
            }
        })
    }
    
    
    //初始化单曲列表/加载更多数据
    func loadMoreData(){
        SongModel.page += 1
        Kugou_SongListSearch_Http.songListSearchRequest(keyword: SearchKeywordModel.keyword, page: SongModel.page)
    }

    
    //点击了更多
    func moreAction(button: UIButton){
        let songhash = songListModel1Array[button.tag].songhash
        print("点击了更多,songid为:\(songhash)")
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
