//
//  CircularProgressView.swift
//  test
//
//  Created by bb on 2017/5/12.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class CurrentProgressView: UIView {
    
    var LineWidth:CGFloat =  2
    var Space:CGFloat = 7
    var progress:Float = 0{
        didSet {
            //print("复制了了，执行了没")
            if progress >= 100 {
                progress = 100
            }
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    
    override func draw(_ rect: CGRect){
        super.draw(rect)
        self.drawBackground()
        self.drawProgressLine()
    }
    
    func drawProgressLine(){
        self.drawCircleDashed(dash: true)
    }
    
    func drawBackground(){
        let rect:CGRect = self.bounds
        let center:CGPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius:CGFloat = min(rect.height, rect.width) / 2 - Space - LineWidth
        
        // draw pie
        let path:UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        UIColor.init(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 0).setFill()
        path.fill()
        
        // draw dash circle
        self.drawCircleDashed(dash: false)
    }
    
    
    func drawCircleDashed(dash: Bool){
        let rect:CGRect = self.bounds
        let center:CGPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var radius:CGFloat = min(rect.height, rect.width) / 2 - LineWidth
        
        var startAngle:CGFloat = 0
        var endAngle:CGFloat = CGFloat(2 * Double.pi)
        
        if dash == true{
            radius = min(rect.height, rect.width) / 2 - LineWidth * 2 + 1
            startAngle = CGFloat(-90 * Double.pi / 180)
            endAngle = CGFloat(((self.progress / 100) * 360 - 90) ) * CGFloat(Double.pi) / 180
        }
        
        let path:UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        path.lineWidth = LineWidth
        MainColor.setStroke()
        path.stroke()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
