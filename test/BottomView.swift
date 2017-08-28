//
//  BottomView.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class BottomView: UIView {

    var playProgressView:PlayProgressView!
    
    var songOperationsView:SongOperationsView!
    
    var controlButtonsView:ControlButtonsView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //播放进度条／播放时间view
        playProgressView = PlayProgressView()
        //playProgressView.backgroundColor = UIColor.lightGray
        self.addSubview(playProgressView)
        playProgressView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(30)
        }
        
        
        //播放设置／单曲。。／分享／下载
        songOperationsView = SongOperationsView()
        //songOperationsView.backgroundColor = UIColor.red
        self.addSubview(songOperationsView)
        songOperationsView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(50)
        }
        
        // 上一首／播放／下一首 按钮
        controlButtonsView = ControlButtonsView()
        //controlButtonsView.backgroundColor = UIColor.green
        self.addSubview(controlButtonsView)
        controlButtonsView.snp.makeConstraints { (make) in
            make.top.equalTo(playProgressView.snp.bottom)
            make.bottom.equalTo(songOperationsView.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
