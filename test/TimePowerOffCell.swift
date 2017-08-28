//
//  SearchRecordListCell.swift
//  test
//
//  Created by bb on 2017/1/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class TimePowerOffCell: UITableViewCell {
    
    
    var titleLabel:UILabel!
    
    var subtitleLabel:UILabel!
    
    var selectedButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            
            for subview in self.subviews{
                subview.removeFromSuperview()
            }
            
            titleLabel = UILabel()
            titleLabel.textColor = TitleColor
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self).offset(15)
                make.top.equalTo(self)
                make.bottom.equalTo(self)
                make.right.lessThanOrEqualTo(80)
            }
            
            subtitleLabel = UILabel()
            subtitleLabel.textColor = SubTitleColor
            subtitleLabel.font = UIFont.systemFont(ofSize: 13)
            self.addSubview(subtitleLabel)
            subtitleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(titleLabel.snp.right).offset(15)
                make.top.equalTo(self)
                make.bottom.equalTo(self)
                make.right.greaterThanOrEqualTo(80)
            }
            
            selectedButton = UIButton()
            selectedButton.setImage(UIImage(named:""), for: .normal)
            selectedButton.setImage(UIImage(named:"checkbox_on"), for: .selected)
            self.addSubview(selectedButton)
            selectedButton.snp.makeConstraints { (make) in
                make.right.equalTo(self).offset(-10)
                make.top.equalTo(self).offset(5)
                make.bottom.equalTo(self).offset(-5)
                make.width.equalTo(selectedButton.snp.height)
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
