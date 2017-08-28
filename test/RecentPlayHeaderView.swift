//
//  RecentPlayHeaderView.swift
//  test
//
//  Created by bb on 2017/2/23.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol RecentPlayHeaderViewDelegate {
    func recentPlayAction(button:UIButton)
}

class RecentPlayHeaderView: UIView {

    var delegate:RecentPlayHeaderViewDelegate?
    var randomPlayButton:UIButton?
    var editButton:UIButton?

    override init(frame:CGRect){
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.white
        
        randomPlayButton = UIButton()
        randomPlayButton?.tag = 900
        randomPlayButton?.setImage(UIImage(named: "list_play"), for: .normal)
        randomPlayButton?.setImage(UIImage(named: "list_play_pressed"), for: .highlighted)
        randomPlayButton?.setTitle("随机播放全部", for: .normal)
        randomPlayButton?.setTitleColor(UIColor.black, for: .normal)
        randomPlayButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        randomPlayButton?.addTarget(self, action: #selector(RecentPlayHeaderView.recentPlayAction), for: .touchUpInside)
        self.addSubview(randomPlayButton!)
        randomPlayButton?.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.lessThanOrEqualTo(WIN_WIDTH - 30/2)
        })
        
        
        editButton = UIButton()
        editButton?.tag = 901
        editButton?.setImage(UIImage(named: "icon_manage_downloadingView"), for: .normal)
        editButton?.setImage(UIImage(named: "icon_manage_downloadingView_pressed"), for: .highlighted)
        editButton?.setTitle("管理", for: .normal)
        editButton?.setTitleColor(UIColor.black, for: .normal)
        editButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        editButton?.addTarget(self, action: #selector(RecentPlayHeaderView.recentPlayAction), for: .touchUpInside)
        self.addSubview(editButton!)
        editButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.lessThanOrEqualTo(WIN_WIDTH - 30/2)
        })
        
        
        
        
        
        
        
        let subLayer = CALayer()
        subLayer.frame = CGRect(x: 0, y: 43.5, width: WIN_WIDTH, height: 0.5)
        subLayer.backgroundColor = SeparatorColor.cgColor
        self.layer.addSublayer(subLayer)
        
    }
    
    //随机播放全部／管理
    func recentPlayAction(button:UIButton){
        self.delegate?.recentPlayAction(button: button)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
