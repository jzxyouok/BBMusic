//
//  AboutBBMusicViewController.swift
//  bbb
//
//  Created by bb on 16/8/18.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit
import WebKit

class PayForSongViewController: UIViewController{
    
    var theWebView:UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view标题
        self.title = "\(currentSongInfoModel_kugou.album_name)"
        
        //取消按钮
        let cancelBtn = UIBarButtonItem(title: "取消", style: .plain, target: self, action:#selector(PayForSongViewController.closeViewController))
        cancelBtn.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = cancelBtn
        
        //状态了背景色(透明)
        self.navigationController?.navigationBar.setBackgroundImage(imageMainColor, for: .default)
        self.navigationController?.navigationBar.shadowImage = imageMainColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        //修改返回按钮 颜色 UIBarButtonItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        //修改title颜色
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        
        let url = URL(string: currentSongInfoModel_kugou.topic_url)
        let request = URLRequest(url: url!)
        theWebView?.backgroundColor = UIColor.clear
        theWebView?.isOpaque = false
        theWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64))
        theWebView?.loadRequest(request)
        self.view.addSubview(theWebView!)
    }
    
    
    func closeViewController(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
