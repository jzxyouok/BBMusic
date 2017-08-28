//
//  moreInfoView_Style1.swift
//  test
//
//  Created by bb on 2017/6/11.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class MoreInfoView_Style: UIView {
    
    var videoPlayButton:UIButton!
    var discussCountButton:UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        videoPlayButton = UIButton(type: .system)
        videoPlayButton.isUserInteractionEnabled = false
        videoPlayButton.setImage(UIImage(named: "MVPlayTimeIcon"), for: .normal)
        videoPlayButton.setTitle(" 0", for: .normal)
        videoPlayButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        videoPlayButton.tintColor = UIColor.white
        self.addSubview(videoPlayButton)

        discussCountButton = UIButton(type: .system)
        discussCountButton.isUserInteractionEnabled = false
        discussCountButton.setImage(UIImage(named: "MVPlayTimeIcon"), for: .normal)
        discussCountButton.setTitle(" 0", for: .normal)
        discussCountButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        discussCountButton.tintColor = UIColor.white
        self.addSubview(discussCountButton)
        
        
        videoPlayButton.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.lessThanOrEqualToSuperview()
        }
        
        discussCountButton.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.lessThanOrEqualToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
