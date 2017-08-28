//
//  GuideViewController.swift
//  bbb
//
//  Created by bb on 16/8/23.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController, UIScrollViewDelegate {

    let buttonArray = ["登陆/注册", "立即体验"]
    
    var scrollView = UIScrollView()
    var pageController = UIPageControl()
    
    
    override var prefersStatusBarHidden : Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建一个scrollview
        scrollView.frame = self.view.frame
        scrollView.backgroundColor = UIColor.green
        scrollView.contentSize = CGSize(width: 4 * self.view.frame.width, height: self.view.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        //循环创建4个imageview，并在最后一个添加一个button相应点击事件
        for i in 0...3{
            let imageView = UIImageView(frame:CGRect(x: (self.view.frame.width) * CGFloat(i), y: 0, width: self.view.frame.width, height: self.view.frame.height))
            imageView.image = UIImage(named: "\(i+1).PNG")
            imageView.isUserInteractionEnabled = true
            scrollView.addSubview(imageView)
        }
        
        //创建轮播页码
        pageController.numberOfPages = 4
        pageController.pageIndicatorTintColor = UIColor.lightGray
        pageController.currentPageIndicatorTintColor = UIColor.red
        self.view.addSubview(pageController)
        pageController.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-125)
            make.height.equalTo(10)
        }

        
        //立即体验
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(GuideViewController.closeGuideViewController), for: .touchUpInside)
        self.view.addSubview(button)
            button.setTitle("立即体验", for: UIControlState())
            button.setTitleColor(UIColor.white, for: UIControlState())
            button.backgroundColor = UIColor.red
            button.snp.makeConstraints { (make) in
                make.width.equalTo(120)
                make.centerX.equalTo(self.view)
                make.bottom.equalTo(-40)
                make.height.equalTo(44)
            }
        
    }
    
    
    //监听scrollview滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollView 偏移量
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageController.currentPage = Int(page + 0.5)
    }
    
    
    //点击“立即体验”
    func closeGuideViewController(){
        self.dismiss(animated: true, completion: nil)
        // FIX 2017-06-09 修复引导页后无法侧滑的问题
        self.present(drawerController, animated: true, completion: nil)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
