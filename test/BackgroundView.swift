//
//  BackgroundView.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    //动态修改
    var backgroundImageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 背景大图
        backgroundImageView = UIImageView()
        backgroundImageView.frame = self.frame
        backgroundImageView.image = UIImage(named: "音乐_播放器_默认模糊背景")
        backgroundImageView.contentMode = .scaleAspectFill
        self.addSubview(backgroundImageView)
        
        //半透明遮罩
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addSubview(blurView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
