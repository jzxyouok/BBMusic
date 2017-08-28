//
//  SpecialListCell.swift
//  test
//
//  Created by bb on 2017/3/27.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class SpecialListCell: UITableViewCell {
    
    var subTitle:UILabel!
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var itemImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            
            for subview in self.subviews{
                subview.removeFromSuperview()
            }
            
            //图片
            itemImage = UIImageView()
            self.addSubview(itemImage)
            itemImage.snp.makeConstraints({ (make) in
                make.left.equalTo(self)
                make.top.equalTo(self).offset(1)
                make.bottom.equalTo(self).offset(-1)
                make.width.equalTo(itemImage.snp.height)
            })
            
            
            //二级标题
            subTitle = UILabel()
            subTitle.font = UIFont.systemFont(ofSize: 12)
            subTitle.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.addSubview(subTitle)
            subTitle.snp.makeConstraints({ (make) in
                make.left.equalTo(itemImage.snp.right).offset(15)
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset(-60)
                make.height.equalTo(12)
            })
            
            
            
            //标题
            titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(subTitle)
                make.top.equalTo(self)
                make.bottom.equalTo(subTitle.snp.top)
                make.right.equalTo(subTitle)
            })
            
 
            //三级标题
            detailLabel = UILabel()
            detailLabel.font = UIFont.systemFont(ofSize: 12)
            detailLabel.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.addSubview(detailLabel)
            detailLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(subTitle)
                make.top.equalTo(subTitle.snp.bottom)
                make.bottom.equalTo(self)
                make.right.equalTo(subTitle)
            })
            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

