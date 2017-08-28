//
//  AboutHeaderView.swift
//  test
//
//  Created by bb on 2017/6/8.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class AboutFooterView: UIView {
    
    var versionLabel: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        //版权信息
        versionLabel = UILabel()
        versionLabel.text = "海绵宝宝版权所有 © 2016-\(Common.getCurrentDate().year!)"
        versionLabel.textAlignment = .center
        versionLabel.textColor = UIColor.lightGray
        versionLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(44)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
