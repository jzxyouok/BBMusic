//
//  KeywordRecommendView.swift
//  test
//
//  Created by bb on 2017/3/21.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class KeywordRecommendView: UIView {

    var albumImageView:UIImageView!
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var arrowImageView:UIImageView!

    override init(frame:CGRect){
        super.init(frame: frame)
        
        
        //专辑图片
        albumImageView = UIImageView()
        albumImageView.image = UIImage(named: "demo6")
        self.addSubview(albumImageView)
        albumImageView.snp.makeConstraints({ (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.width.equalTo(albumImageView.snp.height)
        })
        
        
        //发现更多操作
        arrowImageView = UIImageView()
        arrowImageView.image = UIImage(named: "discover_right_arrow")
        self.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints({ (make) in
            make.right.equalTo(self)
            make.top.equalTo(self).offset(4)
            make.height.equalTo(44)
            make.width.equalTo(arrowImageView.snp.height)
        })
        
        //专辑名称
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(albumImageView.snp.right).offset(10)
            make.top.equalTo(albumImageView.snp.top)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
            make.height.equalTo(20)
        })
        
        
        //歌手／专辑信息
        detailLabel = UILabel()
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        detailLabel.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        self.addSubview(detailLabel)
        detailLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.width.equalTo(titleLabel.snp.width)
            make.bottom.equalTo(albumImageView.snp.bottom)
        })
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
