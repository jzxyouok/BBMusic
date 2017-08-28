//
//  NavigationTitleView.swift
//  test
//
//  Created by bb on 2017/1/11.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol NavigationTitleViewDelegate {
    func navigationTitleViewButtonAction(button:UIButton)
}

class NavigationTitleView: UIView {

    var delegate:NavigationTitleViewDelegate?
    
    var fontSize:CGFloat = 16
    
    var titleArray = [String]()
    var leftButton:UIButton!
    var rightButton:UIButton!
    var tabBarButton:UIButton!
    var lastTabBarButton:UIButton!

    override init(frame: CGRect){
        super.init(frame: frame)
        
        titleArray = NavigationTitleViewModel.titleArray
        
        //
        leftButton = UIButton()
        leftButton.tag = 1001
        leftButton.setTitle("left", for: .normal)
        //leftButton.addTarget(self, action: #selector(NavigationTitleView.navigationViewButtonAction), for: .touchUpInside)
        self.addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(44)
            make.bottom.equalTo(self)
        }
        
        //
        rightButton = UIButton()
        rightButton.tag = 1002
        let image = scaleToSize(img: UIImage(named: "search_goto_recoginize")!, size: CGSize(width: 28, height: 28))
        rightButton.setImage(image, for: .normal)
        rightButton.setImage(image, for: .highlighted)
        rightButton.addTarget(self, action: #selector(NavigationTitleView.navigationViewButtonAction), for: .touchUpInside)
        self.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(44)
            make.bottom.equalTo(self)
        }

        //“我的”，“音乐馆”，“发现” uibutton
        for (index,value) in titleArray.enumerated(){
            tabBarButton = UIButton()
            NavigationTitleViewModel.buttonArray.append(tabBarButton)
            tabBarButton.setTitle(value, for: .normal)
            tabBarButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            tabBarButton.setTitleColor(UIColor.white, for: .selected)
            tabBarButton.setTitleColor(UIColor.white, for: .highlighted)
            tabBarButton.setTitleColor(UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1), for: .normal)
            tabBarButton.tag = 1100 + index
            tabBarButton.addTarget(self, action: #selector(NavigationTitleView.navigationViewButtonAction), for: .touchUpInside)
            self.addSubview(tabBarButton)
            if index == 0{
                tabBarButton.isSelected = true
                tabBarButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
                tabBarButton.snp.makeConstraints { (make) in
                    make.left.equalTo(leftButton.snp.right).offset(34)
                    make.top.equalTo(self)
                    make.width.equalTo((self.frame.size.width - 78 - 88)/3)
                    make.bottom.equalTo(self)
                }
            }else{
                tabBarButton.snp.makeConstraints { (make) in
                    make.left.equalTo(lastTabBarButton.snp.right)
                    make.top.equalTo(self)
                    make.width.equalTo(lastTabBarButton.snp.width)
                    make.bottom.equalTo(self)
                }
            }
            lastTabBarButton = tabBarButton
        }
        
    }
    
    
    //代理方法
    func navigationViewButtonAction(button: UIButton){
        
        delegate?.navigationTitleViewButtonAction(button: button)
        //排除非标题按钮
        if button.tag == 1001 || button.tag == 1002{
            return
        }
        //修改标题按钮样式
        for i in NavigationTitleViewModel.buttonArray{
            if i == button{
                i.isSelected = true
                i.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
            }else{
                i.isSelected = false
                i.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            }
        }
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
