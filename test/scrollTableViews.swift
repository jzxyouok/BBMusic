//
//  scrollTableViews.swift
//  test
//
//  Created by bb on 2017/1/11.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class scrollTableViews: UIView, UIScrollViewDelegate {
    
    
    var scrollView:UIScrollView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView()
        scrollView?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        scrollView?.backgroundColor = UIColor.white
        scrollView?.contentSize = CGSize(width: self.bounds.width*3, height: self.bounds.height)
        scrollView?.bounces = false
        scrollView?.alwaysBounceVertical = false
        scrollView?.alwaysBounceHorizontal = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.isPagingEnabled = true
        scrollView?.delegate = self
        self.addSubview(scrollView!)
        
    }
    
    //滑动切换控制器
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(scrollView){
            let offsetX = scrollView.contentOffset.x
            switch offsetX {
            case WIN_WIDTH*0:
                print("0")
                swithcButtonSelected(index: 0)
                break
            case WIN_WIDTH*1:
                print("1")
                swithcButtonSelected(index: 1)
                break
            case WIN_WIDTH*2:
                print("2")
                swithcButtonSelected(index: 2)
                break
            default:
                break
            }
        }
    }
    
    //滑动切换，标题选中效果
    func swithcButtonSelected(index:Int){
        for button in detailViewControllerModel.buttonArray{
            if detailViewControllerModel.buttonArray[index] == button{
                detailViewControllerModel.buttonArray[index].isSelected = true
            }else{
                button.isSelected = false
            }
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
