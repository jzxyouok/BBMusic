//
//  SearchRecordListTitleView.swift
//  test
//
//  Created by bb on 2017/1/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class SearchRecordListTitleView: UIView {

    var titleLabel:UILabel!
    
    var titleButton:UIButton!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        //搜索历史
        titleLabel = UILabel()
        titleLabel.textColor = SubTitleColor
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(60)
        }
        //清空历史
        titleButton = UIButton()
        titleButton.tag = 10001
        titleButton.contentHorizontalAlignment = .right
        titleButton.setTitleColor(MainColor, for: .normal)
        titleButton.setTitleColor(MainColor_HightLight, for: .highlighted)
        self.addSubview(titleButton)
        titleButton.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(60)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
