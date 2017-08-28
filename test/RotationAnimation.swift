//
//  R.swift
//  test
//
//  Created by bb on 17/3/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class RotationAnimation: NSObject {
    
    
    /***  缩略图旋转动画  ***/
    
    //初始化旋转动画
    class func initImageAnimation(view: UIView){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.fromValue = 0
        anim.toValue = 2 * Double.pi
        anim.duration = 25
        anim.repeatCount = .infinity
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        view.layer.speed = 0
        view.layer.add(anim, forKey: "transform.rotation")
    }
    
    //暂停动画
    class func pauseAnimation(view: UIView){
        //（0-5）
        //开始时间：0
        //    myView.layer.beginTime
        //1.取出当前时间，转成动画暂停的时间
        let pauseTime:CFTimeInterval = view.layer.convertTime(CACurrentMediaTime(), from: nil)
        //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
        view.layer.timeOffset = pauseTime
        //3.将动画的运行速度设置为0， 默认的运行速度是1.0
        view.layer.speed = 0
    }
    
    //恢复动画
    class func resumeAnimation(view: UIView){
        //1.将动画的时间偏移量作为暂停的时间点
        let pauseTime:CFTimeInterval = view.layer.timeOffset
        //2.计算出开始时间
        let begin:CFTimeInterval = CACurrentMediaTime() - pauseTime
        view.layer.timeOffset = 0
        view.layer.beginTime = begin
        view.layer.speed = 1
    }


}
