//
//  ShowLRCViewController.swift
//  test
//
//  Created by bb on 2017/5/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class ShowLRCViewController: UIViewController, UIScrollViewDelegate {

    
    //标记是否正在拖动
    var isDragging:Bool = false
    var lrcScrollView:UIScrollView!
    var heightOfLCRLabel:CGFloat = 40
    var lrcLabelViewArray = [UILabel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRect(x: 0, y: 0, width: WIN_WIDTH, height: WIN_HEIGHT - 180 - 64)

        self.lrcScrollView = UIScrollView()
        self.lrcScrollView.frame = self.view.frame
        self.lrcScrollView.contentSize.width = self.view.frame.width * 0.98
        self.lrcScrollView.contentSize.height = self.view.frame.height * 0.65 + (heightOfLCRLabel * CGFloat(LrcProcessModel.time2LRC.count))
        // 初始化LRCScrollView的位置
        self.lrcScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.lrcScrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.lrcScrollView)
        
        //渐变颜色
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        //设置渐变的主颜色（可多个颜色添加）
        let white = UIColor.white.cgColor
        let clear = UIColor.clear.cgColor
        gradientLayer.colors = [clear, white, clear]
        //将gradientLayer作为子layer
        self.view.layer.mask = gradientLayer
        
        //将歌词内容显示在scrollview上
        showLRCToScrollView()
        
        //监听当前播放歌词 段 通知
        NotificationCenter.default.addObserver(self, selector: #selector(updateLRCScrollView), name: NSNotification.Name(rawValue: "currentLrcStr"), object: nil)
 
    }
    
    
    
    func showLRCToScrollView(){
        // 定义处理的是第几行歌词
        var i:CGFloat = 0
        // 因为字典是无序的，所以要用到sort
        for key in LrcProcessModel.time2LRC.keys.sorted() {
            // 创建显示一行歌词的label，并设置位置、大小、内容
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            let str:NSString = LrcProcessModel.time2LRC[key]! as NSString
            label.text = "\(str)"
            label.backgroundColor = UIColor.clear
            label.textColor = UIColor.lightText
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            let textSize:CGSize = str.boundingRect(with: CGSize(), options: .truncatesLastVisibleLine, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16)], context: nil).size
            label.frame = CGRect(
                x: (self.view.frame.width - textSize.width)/2,
                y: (self.view.frame.height * 0.65 / 2 + (heightOfLCRLabel * i)),
                width: textSize.width,
                height: heightOfLCRLabel)
            // 添加到scrollView
            self.lrcScrollView.addSubview(label)
            
            
            //渐变颜色
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.frame = CGRect(x: 0, y: 0, width: 60, height: label.frame.height)
//            //设置渐变的主颜色（可多个颜色添加）
//            let white = UIColor.white.cgColor
//            let clear = UIColor.clear.cgColor
//            gradientLayer.colors = [clear, white, clear]
//            //将gradientLayer作为子layer
//            label.layer.mask = gradientLayer
            
            
            // 添加到数组lrcLabelViewArray
            lrcLabelViewArray.append(label)
            
            i += 1
        }
    }
    

    func updateLRCScrollView() {

        var newOffset = self.lrcScrollView.contentOffset
        
        newOffset.y = lrcLabelViewArray[LrcProcessModel.lrcRowNumber].center.y - self.view.frame.height * 0.65 / 2
        // 如果正在拖动，则不更新位移
        if isDragging == false{
            self.lrcScrollView.setContentOffset(newOffset, animated: true)
        }
        
        // 取消非当前Label歌词的高亮、字体加大
        for itemLabel in lrcLabelViewArray {
            itemLabel.textColor = UIColor.lightText
        }
        
        // 高亮当前Label中的歌词
        lrcLabelViewArray[LrcProcessModel.lrcRowNumber].textColor = MainColor

    }

    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //print("准备拖动")
        isDragging = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //print("已经停止拖动")
        isDragging = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lrcScrollView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.lrcScrollView.delegate = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
