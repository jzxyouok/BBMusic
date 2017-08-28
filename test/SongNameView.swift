//
//  SongNameView.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol SongNameViewDelegate {
    func navigationButtonAction(button:UIButton)
}

class SongNameView: UIView {

    var songNameLabel:UILabel!
    
    var closeButton:UIButton!
    
    var moreButton:UIButton!
    
    var delegate:SongNameViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //关闭
        closeButton = UIButton()
        closeButton.tag = 1004
        let closeImage = scaleToSize(img: UIImage(named: "icon-down")!, size: CGSize(width: 26, height: 26))
        closeButton.setImage(closeImage, for: .normal)
        closeButton.addTarget(self, action: #selector(SongNameView.buttonAction), for: .touchUpInside)
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        //当前播放歌曲名
        songNameLabel = UILabel()
        songNameLabel.textColor = UIColor.white
        songNameLabel.textAlignment = .center
        songNameLabel.font = UIFont.systemFont(ofSize: defaultSize_18_20)
        self.addSubview(songNameLabel)
        songNameLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 44+15, 0, 44+15))
        }
        
        //更多
        moreButton = UIButton(type: .system)
        moreButton.tag = 1005
        moreButton.contentMode = .right
        moreButton.setImage(UIImage(named: "allMusic_more"), for: .normal)
        moreButton.tintColor = UIColor.white
        moreButton.addTarget(self, action: #selector(SongNameView.buttonAction), for: .touchUpInside)
        self.addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
    }
    
    //关闭／更多按钮点击事件
    func buttonAction(button:UIButton){
        delegate?.navigationButtonAction(button: button)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
