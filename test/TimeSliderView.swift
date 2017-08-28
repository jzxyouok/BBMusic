//
//  TimeSliderView.swift
//  test
//
//  Created by bb on 2017/3/23.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class TimeSliderView: UIView {
    
    var timeSlider:UISlider!
    var progressView:UIProgressView!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        
        progressView = UIProgressView()
        progressView.trackTintColor = UIColor.init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        progressView.progressTintColor = UIColor.init(red: 184/255, green: 184/255, blue: 153/255, alpha: 1)
        self.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(2)
        }
        
        
        //播放进度条
        timeSlider = UISlider()
        timeSlider.addTarget(self, action: #selector(sliderValueChange), for: .valueChanged)
        //timeSlider.backgroundColor = UIColor.brown
        timeSlider.isEnabled = false
        timeSlider.maximumValue = 100
        timeSlider.isContinuous = true
        timeSlider.minimumTrackTintColor = MainColor
        timeSlider.maximumTrackTintColor = UIColor.clear
        timeSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
        timeSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .highlighted)
        self.addSubview(timeSlider)
        timeSlider.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(progressView).offset(-1)
            make.right.equalTo(self)
            make.height.equalTo(self)
        }
    
    }
    
    func sliderValueChange(timeSlider:UISlider){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SliderValueChange"), object: nil, userInfo: ["value":timeSlider.value])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
