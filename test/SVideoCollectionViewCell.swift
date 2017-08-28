//
//  PhotoCollectionViewCell.swift
//  myForm
//
//  Created by bb on 2017/4/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class SVideoCollectionViewCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var titleLabel:UILabel!
    var subView:MoreInfoView_Style!
    
    var h:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for subview in self.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        self.contentView.addSubview(imageView)

        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = TitleColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        self.contentView.addSubview(titleLabel)

        
        subView = MoreInfoView_Style()
        self.contentView.addSubview(subView)

        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.height.equalTo(self.bounds.size.height*3/4 - 10)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalTo(self)
        }

        subView.snp.makeConstraints { (make) in
            make.left.equalTo(imageView).offset(5)
            make.right.equalTo(imageView).offset(-5)
            make.bottom.equalTo(imageView.snp.bottom).offset(-5)
            make.height.equalTo(10)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        // do you something
        
    }
    
}
