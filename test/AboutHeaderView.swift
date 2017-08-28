//
//  AboutHeaderView.swift
//  test
//
//  Created by bb on 2017/6/8.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class AboutHeaderView: UIView {
    
    var logoImage: UIImageView!
    var versionLabel: UILabel!

    override init(frame: CGRect){
        super.init(frame: frame)
        
        logoImage = UIImageView()
        logoImage.image = UIImage(named: "logo")
        logoImage.contentMode = .scaleAspectFit
        self.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-10)
            make.width.equalTo(self)
            make.height.equalTo(60)
        }
        
        
        versionLabel = UILabel()
        versionLabel.text = "版本号：\(Common.versionCheck())"
        versionLabel.textAlignment = .center
        versionLabel.textColor = UIColor.lightGray
        versionLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(logoImage.snp.bottom)
            make.right.equalTo(self)
            make.height.equalTo(44)
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
