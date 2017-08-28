//
//  RecentPlayFooterView.swift
//  test
//
//  Created by bb on 2017/2/23.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol RecentPlayFooterViewDelegate {
    func clearAllRecordAction(button:UIButton)
}

class RecentPlayFooterView: UIView {
    
    var delegate:RecentPlayFooterViewDelegate?
    var clearAllRecordButton:UIButton?
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        //self.backgroundColor = UIColor.white
        
        clearAllRecordButton = UIButton()
        clearAllRecordButton?.tag = 902
        let image = scaleToSize(img: UIImage(named: "label_delete_icon")!, size: CGSize(width: 30, height: 30))
        clearAllRecordButton?.setImage(image, for: .normal)
        clearAllRecordButton?.setTitle("清除全部播放记录", for: .normal)
        clearAllRecordButton?.setTitleColor(UIColor.lightGray, for: .normal)
        clearAllRecordButton?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        clearAllRecordButton?.addTarget(self, action: #selector(RecentPlayFooterView.clearAllRecordAction), for: .touchUpInside)
        self.addSubview(clearAllRecordButton!)
        clearAllRecordButton?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.lessThanOrEqualToSuperview()
        })
        

        
    }
    
    //随机播放全部／管理
    func clearAllRecordAction(button:UIButton){
        self.delegate?.clearAllRecordAction(button: button)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
