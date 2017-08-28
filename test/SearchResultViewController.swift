//
//  SearchResultViewController.swift
//  test
//
//  Created by bb on 2017/2/22.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SDWebImage
import ScrollPageView

class SearchResultViewController: UIViewController {
    
    var keywordRecommendView:KeywordRecommendView!
    
    var scrollPageView:ScrollPageView!
    
    var frame:CGRect!
    
    var border:CALayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        //关键字推荐自定义view
        keywordRecommendView = KeywordRecommendView.init(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 52))
        keywordRecommendView.isHidden = true
        self.view.addSubview(keywordRecommendView)
        
        // 2.这个是必要的设置
        self.automaticallyAdjustsScrollViewInsets = false

        
        //3. 自定义效果组合
        var style = SegmentStyle()
        // 显示下划线
        style.showLine = true
        // 下划线颜色
        style.scrollLineColor = MainColor
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // segment可以滚动
        style.scrollTitle = true
        // 标题文字 选择状态 颜色
        style.selectedTitleColor = MainColor
        
        style.titleMargin = (WIN_WIDTH - 29*4 - 22)/6
        
        let childVcs = setChildVcs()
        // 4. 注意: 标题个数和子控制器的个数要相同
        let titles = childVcs.map { $0.title! }
        
        // 5. 这里的childVcs 需要传入一个包含childVcs的数组, parentViewController 传入self
        frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - 64 - 60)
        scrollPageView = ScrollPageView(frame: frame, segmentStyle: style, titles: titles, childVcs: childVcs, parentViewController: self)
        // 底部 浅灰色分割线
        border = CALayer()
        border.frame = CGRect(x: 0, y: 43.5, width: view.bounds.size.width, height: 0.5)
        border.backgroundColor = SeparatorColor.cgColor
        scrollPageView.segmentView.layer.addSublayer(border)
        self.view.addSubview(scrollPageView)
        //监听关键字推荐请求结果
        NotificationCenter.default.addObserver(self, selector: #selector(SearchResultViewController.reloadData), name:NSNotification.Name(rawValue: "KeyRecommendSearchDone"), object: nil)
        //请求关键字推荐
        Kugou_KeyRecommendSearch_Http.keyRecommendSearchRequest(keyword: SearchKeywordModel.keyword)
    }

    
    //1. 设置子控制器,类似
    func setChildVcs() -> [UIViewController] {
        
        let vc1 = SongViewController()
        vc1.view.backgroundColor = UIColor.orange
        vc1.title = "单曲"
        
        let vc2 = AlbumViewController()
        vc2.view.backgroundColor = UIColor.green
        vc2.title = "MV"
        
        let vc3 = AlbumViewController()
        vc3.view.backgroundColor = UIColor.red
        vc3.title = "专辑"
        
        let vc4 = SpecialViewController()
        vc4.view.backgroundColor = UIColor.yellow
        vc4.title = "歌单"
        
        let vc5 = AlbumViewController()
        vc5.view.backgroundColor = UIColor.lightGray
        vc5.title = "歌词"
        
        return [vc1, vc2, vc3, vc4, vc5]
        
    }
    
    //更新 关键字推荐view UI
    func reloadData(){
        DispatchQueue.main.async(execute: {
            if keywordRecommendModel.isRecommend == true{
                self.keywordRecommendView.isHidden = false
                self.frame = CGRect(x: 0, y: 52, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64 - 60 - 52)
                self.scrollPageView.frame = self.frame
                self.keywordRecommendView.albumImageView.sd_setImage(with: URL(string:keywordRecommendModel.imgurl), placeholderImage: UIImage(named: "default_album_guess"))
                self.keywordRecommendView.titleLabel.text = keywordRecommendModel.name
                self.keywordRecommendView.detailLabel.text = keywordRecommendModel.intro
            }else{
                self.keywordRecommendView.isHidden = true
            }
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
