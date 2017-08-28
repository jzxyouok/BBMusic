//
//  ProgressView.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class PlayProgressView: UIView {
    
    var currentLabel:UILabel!
    var durationLabel:UILabel!
    //滑动条／进度条封装
    var timeSliderView:TimeSliderView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //播放进度条
        timeSliderView = TimeSliderView()
        //timeSliderView.backgroundColor = UIColor.yellow
        self.addSubview(timeSliderView)
        timeSliderView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left).offset(50)
            make.right.equalTo(self.snp.right).offset(-50)
        }
        
        
        //当前进度
        currentLabel = UILabel()
        currentLabel.textAlignment = .center
        currentLabel.textColor = UIColor.init(red: 162/255, green: 153/255, blue: 169/255, alpha: 1)
        currentLabel.font = UIFont.systemFont(ofSize: 12)
        currentLabel.text = "00:00"
        self.addSubview(currentLabel)
        currentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(timeSliderView.snp.left)
        }
        
        //总时长
        durationLabel = UILabel()
        durationLabel.textAlignment = .center
        durationLabel.textColor = UIColor.init(red: 162/255, green: 153/255, blue: 169/255, alpha: 1)
        durationLabel.font = UIFont.systemFont(ofSize: 12)
        durationLabel.text = "00:00"
        self.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(timeSliderView.snp.right)
            make.right.equalTo(self.snp.right)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
