//
//  ScrollViewController.swift
//  test
//
//  Created by bb on 2017/5/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol PlayerScrollviewDegelate {
    func playerScrollview(page: Int)
}

class PlayerScrollviewController: UIViewController, UIScrollViewDelegate {
    
    var delegate:PlayerScrollviewDegelate?
    var scrollView:UIScrollView!
    var topView:TopView!
    var moreInfoViewController:MoreInfoViewController!
    var showLRCViewController:ShowLRCViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView = UIScrollView()
        self.scrollView.contentSize = CGSize(width: WIN_WIDTH*3, height: 0)
        self.scrollView.contentOffset = CGPoint(x: WIN_WIDTH, y: 0)
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        //封面图片／标签
        topView = TopView()
        topView.alpha = 1.0
        scrollView.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        //歌曲更多信息
        moreInfoViewController = MoreInfoViewController()
        self.addChildViewController(moreInfoViewController)
        moreInfoViewController.view.frame = self.scrollView.frame
        self.scrollView.addSubview(moreInfoViewController.view)
        
        //歌词信息 控制器
        changeLrcView()
        //监听歌词获取完成
        NotificationCenter.default.addObserver(self, selector: #selector(getLrcDone), name: NSNotification.Name(rawValue: "getLrcDone"), object: nil)
        
        //监听当前播放歌词 段 通知
        NotificationCenter.default.addObserver(self, selector: #selector(currentLrcStr), name: NSNotification.Name(rawValue: "currentLrcStr"), object: nil)

    }
    
    //歌词信息 控制器
    func changeLrcView(){
        self.showLRCViewController = ShowLRCViewController()
        self.addChildViewController(self.showLRCViewController)
        self.showLRCViewController.view.frame = self.scrollView.frame
        self.showLRCViewController.view.frame.origin.x = WIN_WIDTH*2
        self.scrollView.addSubview(self.showLRCViewController.view)
    }
    
    //获取歌曲完成 通知执行
    func getLrcDone(){
        DispatchQueue.main.async {
            self.showLRCViewController.removeFromParentViewController()
            self.showLRCViewController.view.removeFromSuperview()
            self.changeLrcView()
            LrcProcessModel.currentLrcStr = ""
            self.currentLrcStr()
        }
    }
    
    //当前播放歌词 通知执行
    func currentLrcStr(){
        topView.lyricButton.setTitle(LrcProcessModel.currentLrcStr, for: .normal)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        var alpha:CGFloat = 1.0
        var page:Int = 1
        //左拉
        if offsetX > WIN_WIDTH{
            alpha = (WIN_WIDTH*2 - offsetX)/WIN_WIDTH
        //右拉
        }else{
            alpha = offsetX / WIN_WIDTH
        }
        topView.alpha = alpha
        
        if offsetX > WIN_WIDTH / 2 && offsetX < WIN_WIDTH*3 / 2{
            page = 1
        }else if offsetX > WIN_WIDTH*3 / 2{
            page = 2
        }else{
            page = 0
        }
        //print("当前页数：\(page)")
        self.delegate?.playerScrollview(page: page)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        scrollView.delegate = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
