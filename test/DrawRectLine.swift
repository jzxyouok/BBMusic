//
//  DrawRectLine.swift
//  test
//
//  Created by bb on 2017/2/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class DrawRectLine: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        //获取画笔上下文
        let context:CGContext = UIGraphicsGetCurrentContext()!
        //抗锯齿设置
        context.setAllowsAntialiasing(true)
        //画直线
        context.setStrokeColor(SeparatorColor.cgColor)
        context.setLineWidth(0.5) //设置画笔宽度
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: WIN_WIDTH, y: 0))
        context.strokePath()
    }
    

}
