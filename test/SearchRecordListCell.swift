//
//  SearchRecordListCell.swift
//  test
//
//  Created by bb on 2017/1/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class SearchRecordListCell: UITableViewCell {
    
    
    var keywordLabel:UILabel!
    
    var removeItemBtn:UIButton!
    
    var clockImage:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            
            for subview in self.contentView.subviews{
                subview.removeFromSuperview()
            }
    
            //时钟 图标
            clockImage = UIImageView()
            clockImage.image = UIImage(named: "icon-chart-act")
            self.contentView.addSubview(clockImage)
            clockImage.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView).offset(10)
                make.top.equalTo(self.contentView).offset(7)
                make.bottom.equalTo(self.contentView).offset(-7)
                make.width.equalTo(clockImage.snp.height)
            }
            
            
            //删除 x 图标按钮
            removeItemBtn = UIButton()
            let image = scaleToSize(img: UIImage(named: "pops_up_close")!, size: CGSize(width: 34, height: 34))
            removeItemBtn.setImage(image, for: UIControlState())
            self.contentView.addSubview(removeItemBtn)
            removeItemBtn.snp.makeConstraints { (make) in
                make.right.equalTo(self.contentView)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
                make.width.equalTo(removeItemBtn.snp.height)
            }
            
            
            //搜索记录列表
            keywordLabel = UILabel()
            keywordLabel.textColor = TitleColor
            keywordLabel.font = UIFont.systemFont(ofSize: 15)
            self.contentView.addSubview(keywordLabel)
            keywordLabel.snp.makeConstraints { (make) in
                make.left.equalTo(clockImage.snp.right).offset(10)
                make.top.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView)
                make.right.equalTo(removeItemBtn.snp.left).offset(-10)
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
