//
//  SpecialListCell.swift
//  test
//
//  Created by bb on 2017/3/27.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class RadioStationCell: UITableViewCell {
    
    var subTitle:UILabel!
    var titleLabel:UILabel!
    var detailLabel:UILabel!
    var itemImage:UIImageView!
    var markImage:UIImageView!
    
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
            
            
            //图片
            markImage = UIImageView()
            itemImage.addSubview(markImage)
            markImage.snp.makeConstraints({ (make) in
                make.center.equalTo(itemImage)
                make.height.equalTo(30)
                make.width.equalTo(30)
            })
        
            
            //标题
            titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(itemImage.snp.right).offset(15)
                make.top.equalTo(self).offset(15)
                make.height.equalTo(12)
                make.right.equalTo(self).offset(-60)
            })
            
            
            //三级标题
            detailLabel = UILabel()
            detailLabel.font = UIFont.systemFont(ofSize: 12)
            detailLabel.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.addSubview(detailLabel)
            detailLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(titleLabel.snp.bottom)
                make.bottom.equalTo(self)
                make.right.equalTo(titleLabel)
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

