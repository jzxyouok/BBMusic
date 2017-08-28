//
//  SearchRecordListCell.swift
//  test
//
//  Created by bb on 2017/1/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class RealTimeSearchCell: UITableViewCell {
    
    
    var keywordLabel:UILabel!
    
    var searchImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            
            for subview in self.subviews{
                subview.removeFromSuperview()
            }
            
            //搜索放大镜 图标
            searchImage = UIImageView()
            searchImage.image = UIImage(named: "search_all")
            self.addSubview(searchImage)
            searchImage.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(10)
                make.top.equalTo(self).offset(5)
                make.bottom.equalTo(self).offset(-5)
                make.width.equalTo(searchImage.snp.height)
            }
            
            
            //搜索记录列表
            keywordLabel = UILabel()
            keywordLabel.textColor = TitleColor
            keywordLabel.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(keywordLabel)
            keywordLabel.snp.makeConstraints { (make) in
                make.left.equalTo(searchImage.snp.right)
                make.top.equalTo(self)
                make.bottom.equalTo(self)
                make.right.equalTo(self).offset(-10)
            }
            
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
