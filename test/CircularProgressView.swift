//
//  CircularProgressView.swift
//  test
//
//  Created by bb on 2017/5/12.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {
    
    var LineWidth:CGFloat =  5
    var Space:CGFloat = 7
    var progress:Float = 0{
        didSet {
            if progress >= 100 {
                progress = 100
            }
            self.setNeedsDisplay()
        }
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }

    
    override func draw(_ rect: CGRect){
        super.draw(rect)
        self.drawBackground()
        self.drawProgressLine()
    }
    
    func drawProgressLine(){
        self.drawCircleDashed(dash: false)
    }
    
    func drawBackground(){
        let rect:CGRect = self.bounds
        let center:CGPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius:CGFloat = min(rect.height, rect.width) / 2 - Space - LineWidth
        
        // draw pie
        let path:UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        UIColor.init(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 0.5).setFill()
        path.fill()
        
        // draw dash circle
        self.drawCircleDashed(dash: true)
    }
    
    
    func drawCircleDashed(dash: Bool){
        let rect:CGRect = self.bounds
        let center:CGPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius:CGFloat = min(rect.height, rect.width) / 2 - LineWidth / 2
        
        var endAngle:CGFloat = CGFloat(2 * Double.pi)
        var startAngle:CGFloat = 0
        
        if !dash{
            startAngle = -CGFloat(Double.pi/2)
            endAngle = CGFloat(Double.pi * 2) * CGFloat(self.progress) / 100 - CGFloat(Double.pi/2)
        }

        let path:UIBezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        if dash{
            let lengths:[CGFloat] = [2, 6]
            path.setLineDash(lengths, count: 2, phase: 0)
        }
        
        path.lineWidth = LineWidth
        UIColor.white.setStroke()
        path.stroke()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
