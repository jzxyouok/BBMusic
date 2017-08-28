//
//  TopView.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class TopView: UIView {

    var songInfoView:SongInfoView!
    var lyricButton:UIButton!
    var coverImage:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.isUserInteractionEnabled = false
        
        //1-1.1歌手／mv/dts
        songInfoView = SongInfoView()
        //songInfoView.backgroundColor = UIColor.blue
        self.addSubview(songInfoView)
        songInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(60)
        }
        
        
        //歌词
        lyricButton = UIButton()
        //lyricButton.backgroundColor = UIColor.blueColor()
        lyricButton.setTitle("", for: .normal)
        lyricButton.setTitleColor(UIColor.lightText, for: .normal)
        lyricButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lyricButton)
        lyricButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(44)
            make.right.equalTo(self.snp.right).offset(-44)
            make.height.equalTo(30)
        }
        
        //歌曲图片（圆型）
        coverImage = UIImageView()
        //coverImage.isUserInteractionEnabled = false
        coverImage.image = UIImage(named: "音乐_播放器_默认唱片头像")
        coverImage.layer.masksToBounds = true
        coverImage.layer.cornerRadius = (WIN_HEIGHT - 180 - 64 - 60 - 30 - 10)/2
        coverImage.layer.borderWidth = 8
        coverImage.layer.borderColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.5).cgColor
        self.addSubview(coverImage)
        coverImage.snp.makeConstraints { (make) in
            make.top.equalTo(songInfoView.snp.bottom).offset(5)
            make.bottom.equalTo(lyricButton.snp.top).offset(-5)
            make.width.equalTo(coverImage.snp.height)
            make.centerX.equalTo(self.snp.centerX)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
