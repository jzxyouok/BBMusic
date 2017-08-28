//
//  TabBarView.swift
//  test
//
//  Created by bb on 2017/1/11.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol TabBarViewDelegate {
    func buttonAction(button:UIButton)
    //func sliderValueChange(timeSlider:UISlider)
}

class TabBarView: UIView {

    var delegate:TabBarViewDelegate?
    var smallImage:UIImageView!
    var songNameLabel:UILabel!
    var authorLabel:UILabel!
    var playButton:UIButton!
    var nextButton:UIButton!
    //进度条封装
    var circleView:CurrentProgressView!

    override init(frame: CGRect){
        super.init(frame: frame)

        //歌曲缩略图
        smallImage = UIImageView()
        smallImage.isUserInteractionEnabled = true
        smallImage.isMultipleTouchEnabled = true
        smallImage.tag = 1003
        smallImage.image = UIImage(named: "音乐_播放器_默认唱片头像")
        smallImage.layer.cornerRadius = 25
        smallImage.layer.masksToBounds = true
        self.addSubview(smallImage)
        smallImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        

        //下一首按钮)
        nextButton = UIButton()
        nextButton.isEnabled = false
        nextButton.tag = 1001
        //nextButton.backgroundColor = UIColor.red
        nextButton.setImage(UIImage(named: "miniplayer_btn_playlist_normal"), for: .normal)
        nextButton.setImage(UIImage(named: "miniplayer_btn_playlist_disable"), for: .disabled)
        nextButton.setImage(UIImage(named: "miniplayer_btn_playlist_highlight"), for: .highlighted)
        nextButton.imageView?.contentMode = .scaleAspectFit
        nextButton.addTarget(self, action: #selector(TabBarView.buttonAction), for: .touchUpInside)
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(-8)
            make.width.equalTo(nextButton.snp.height)
        }
        
        //圆形进度条
        circleView = CurrentProgressView()
        circleView.isHidden = true
        circleView.progress = 0
        self.addSubview(circleView)
        circleView.snp.makeConstraints { (make) in
            make.right.equalTo(nextButton.snp.left).offset(-10)
            make.top.equalTo(nextButton).offset(4)
            make.bottom.equalTo(nextButton).offset(-4)
            make.width.equalTo(circleView.snp.height)
        }
        
        
        //播放／暂停按钮
        playButton = UIButton()
        playButton.isEnabled = false
        playButton.tag = 1002
        //playButton.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        playButton.setImage(UIImage(named: "miniplayer_btn_play_normal"), for: .normal)
        playButton.setImage(UIImage(named: "miniplayer_btn_play_disable"), for: .disabled)
        playButton.setImage(UIImage(named: "miniplayer_btn_play_highlight"), for: .highlighted)
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.addTarget(self, action: #selector(TabBarView.buttonAction), for: .touchUpInside)
        self.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.center.equalTo(circleView)
            make.width.equalTo(nextButton)
            make.height.equalTo(nextButton)
        }
        
        
        //歌曲名
        songNameLabel = UILabel()
        songNameLabel.text = ""
        //songNameLabel.backgroundColor = UIColor.blue
        songNameLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(songNameLabel)
        songNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(smallImage.snp.right).offset(15)
            make.bottom.equalTo(self.snp.centerY)
            make.right.equalTo(playButton.snp.left)
            make.height.equalTo(18)
        }
        //歌手
        authorLabel = UILabel()
        authorLabel.text = ""
        //authorLabel.backgroundColor = UIColor.brown
        authorLabel.textColor = UIColor.gray
        authorLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(songNameLabel)
            make.top.equalTo(self.snp.centerY)
            make.width.equalTo(songNameLabel.snp.width)
            make.height.equalTo(24)
        }
        
    }
    
    
    //代理方法
    func buttonAction(button:UIButton){
        delegate?.buttonAction(button: button)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
