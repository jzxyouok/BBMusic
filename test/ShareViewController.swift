//
//  ShareViewController.swift
//  test
//
//  Created by bb on 2017/2/9.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController, ShareViewDelegate {
    
    var playRecord = [String: String]()

    var shareView:ShareView!
    
    var type:SSDKPlatformType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve
        
        shareView = ShareView()
        shareView.delegate = self
        shareView.backgroundColor = UIColor.white
     
        shareView.frame = CGRect(x: 0, y: WIN_HEIGHT, width: WIN_WIDTH, height: WIN_HEIGHT/2 - 44)
        self.view.addSubview(shareView)
        
        //添加单击手势
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(ShareViewController.closeShare))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //分享面板点击动作
    func shareViewAction(button: UIButton) {
        switch button.tag {
        case 0:
            print("wechat")
            ShareModel.shareTo(type: SSDKPlatformType.typeWechat)
            break
        case 1:
            print("qq")
            break
        case 2:
            print("qqzone")
            break
        case 3:
            print("friends")
            ShareModel.shareTo(type: SSDKPlatformType.subTypeWechatTimeline)
            break
        case 4:
            print("sinaweibo")
            break
        case 5:
            print("tecentweibo")
            break
        case 6:
            print("alipay")
            break
        case 10:
            print("phonetext")
            break
        case 11:
            print("email")
            break
        case 12:
            print("reflesh")
            break
        case 13:
            print("copylink")
            break
        case 1006:
            print("取消")
            break
        default:
            break
        }
        closeShare()
    }
    
    
    
    //关闭分享面板
    func closeShare(){
        UIView.animate(withDuration: 0.2, animations: {
            self.shareView.frame.origin.y = WIN_HEIGHT
        }) { (true) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        UIView.animate(withDuration: 0.2) { 
            self.shareView.frame.origin.y = WIN_HEIGHT - WIN_HEIGHT/2 + 44
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
