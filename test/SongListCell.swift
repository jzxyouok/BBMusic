//
//  SongListCell.swift
//  test
//
//  Created by bb on 2017/1/16.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class SongListCell: UITableViewCell {
    
    var isCachedImage:UIImageView!
    var titleLabel:UILabel!
    var availableMark:UILabel!
    var detailLabel:UILabel!
    var moreActionButton:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if !self.isEqual(nil) {
            
            for subview in self.subviews{
                subview.removeFromSuperview()
            }
            
            //更多操作
            moreActionButton = UIButton()
            let normalImage = scaleToSize(img: UIImage(named: "allMusic_more")!, size: CGSize(width: 28, height: 28))
            moreActionButton.setImage(normalImage, for: .normal)
            let hightLightImage = scaleToSize(img: UIImage(named: "allMusic_more_Selected")!, size: CGSize(width: 28, height: 28))
            moreActionButton.setImage(hightLightImage, for: .highlighted)
            self.addSubview(moreActionButton)
            moreActionButton.snp.makeConstraints({ (make) in
                make.right.equalTo(self).offset(-5)
                make.top.equalTo(self)
                make.width.equalTo(44)
                make.bottom.equalTo(self)
            })
            
            //歌曲名称 + othername
            titleLabel = UILabel()
            titleLabel.font = UIFont.systemFont(ofSize: defaultSize_14_15)
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self).offset(15)
                make.top.equalTo(self).offset(5)
                make.right.equalTo(moreActionButton.snp.left).offset(-20)
                make.height.equalTo(25)
            })
            //
            availableMark = UILabel()
            availableMark.isHidden = true
            availableMark.font = UIFont.boldSystemFont(ofSize: 10)
            availableMark.layer.cornerRadius = 2
            availableMark.layer.borderWidth = 1
            availableMark.text = "MV"
            availableMark.textColor = MainColor
            availableMark.textAlignment = .center
            availableMark.layer.borderColor = UIColor.init(red: 49/255, green: 194/255, blue: 124/255, alpha: 1).cgColor
            self.addSubview(availableMark)
            availableMark.snp.makeConstraints({ (make) in
                make.left.equalTo(titleLabel.snp.right).offset(5)
                make.centerY.equalTo(titleLabel)
                make.width.equalTo(20)
                make.height.equalTo(12)
            })
            
            //是否缓存标示
            isCachedImage = UIImageView()
            isCachedImage.isHidden = true
            isCachedImage.image = UIImage(named: "online_autosave_finish")
            self.addSubview(isCachedImage)
            isCachedImage.snp.makeConstraints({ (make) in
                make.left.equalTo(titleLabel)
                make.top.equalTo(titleLabel.snp.bottom).offset(3)
                make.width.equalTo(10)
                make.height.equalTo(10)
            })
            
            
            //歌手／专辑信息
            detailLabel = UILabel()
            detailLabel.font = UIFont.systemFont(ofSize: defaultSize_11_12)
            detailLabel.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
            self.addSubview(detailLabel)
            detailLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(self).offset(15)
                make.top.equalTo(titleLabel.snp.bottom).offset(2)
                make.width.equalTo(titleLabel.snp.width)
                make.height.equalTo(isCachedImage)
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
