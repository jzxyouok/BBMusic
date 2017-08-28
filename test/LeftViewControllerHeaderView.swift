//
//  LeftViewControllerHeaderView.swift
//  test
//
//  Created by bb on 2017/4/26.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class LeftViewControllerHeaderView: UIView {
    
    //数据模型
    let sectionArray1 = [["image":"more_icon_vip_normal", "title":"升级为VIP", "subTitle":"畅享音乐特权"],["image":"more_icon_personal_center", "title":"个性化中心", "subTitle":"盗墓笔记主题"],["image":"more_icon_notificationcenter", "title":"消息中心", "subTitle":""]]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIImageView()
        bgView.frame = self.frame
        bgView.image = UIImage(named: "rain")
        self.addSubview(bgView)
        
        //半透明遮罩
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addSubview(blurView)
        
        for (index,value) in sectionArray1.enumerated(){
            let button = UIButton()
            button.frame = CGRect(x: frame.size.width/3 * CGFloat(index), y: 30, width: frame.size.width/3, height: frame.size.height - 60)
            //新建uiimage
            let image = UIImageView()
            image.image = UIImage(named: sectionArray1[index]["image"]!)
            image.contentMode = .scaleAspectFit
            
            //新建主标题label
            let titleLabel = UILabel()
            titleLabel.text = value["title"]
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: defaultSize_14_16)
            titleLabel.textColor = UIColor.lightGray
            
            //新建副标题label
            let detailTitleLabel = UILabel()
            detailTitleLabel.text = sectionArray1[index]["subTitle"]
            detailTitleLabel.textAlignment = .center
            detailTitleLabel.font = UIFont.systemFont(ofSize: defaultSize_11_12)
            detailTitleLabel.textColor = UIColor.white
            
            //添加到button
            button.addSubview(image)
            button.addSubview(titleLabel)
            button.addSubview(detailTitleLabel)
            self.addSubview(button)
            //图片
            image.snp.makeConstraints({ (make) in
                make.right.equalTo(button).offset(-25)
                make.top.equalTo(button).offset(10)
                make.left.equalTo(button).offset(25)
                make.bottom.equalTo(button).offset(-40)
            })
            //主标题
            titleLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(button)
                make.top.equalTo(image.snp.bottom)
                make.left.equalTo(button)
                make.bottom.equalTo(button).offset(-30)
            })
            //副标题
            detailTitleLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(button)
                make.top.equalTo(titleLabel.snp.bottom)
                make.left.equalTo(button)
                make.bottom.equalTo(button).offset(-5)
            })
            
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
