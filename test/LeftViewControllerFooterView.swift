//
//  LeftViewControllerFooterView.swift
//  test
//
//  Created by bb on 2017/5/2.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol LeftViewControllerFooterViewDelegate {
    func leftFooterButtonAction(button:UIButton)
}

class LeftViewControllerFooterView: UIView {
    
    var settingButton:UIButton!
    var logoutButton:UIButton!
    
    var delegate:LeftViewControllerFooterViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        settingButton = UIButton()
        settingButton.tag = 1001
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: defaultSize_14_16)
        settingButton.setTitle("设置", for: .normal)
        settingButton.setImage(UIImage(named:"more_icon_settings"), for: .normal)
        settingButton.setImage(UIImage(named:"more_icon_settings"), for: .highlighted)
        settingButton.setTitleColor(TitleColor, for: .normal)
        settingButton.addTarget(self, action: #selector(leftFooterButtonAction), for: .touchUpInside)
        self.addSubview(settingButton)
        settingButton.snp.makeConstraints({ (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.width.greaterThanOrEqualTo(60)
            make.bottom.equalTo(self)
        })
        
        logoutButton = UIButton()
        logoutButton.tag = 1002
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: defaultSize_14_16)
        logoutButton.setTitle("立即登录", for: .normal)
        logoutButton.setImage(UIImage(named:"more_icon_bottom_login"), for: .normal)
        logoutButton.setImage(UIImage(named:"more_icon_bottom_login"), for: .highlighted)
        logoutButton.setTitleColor(TitleColor, for: .normal)
        logoutButton.addTarget(self, action: #selector(leftFooterButtonAction), for: .touchUpInside)
        self.addSubview(logoutButton)
        logoutButton.snp.makeConstraints({ (make) in
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.width.greaterThanOrEqualTo(60)
            make.bottom.equalTo(self)
        })
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 0.5)
        border.backgroundColor = SeparatorColor.cgColor
        self.layer.addSublayer(border)
        
    }
    
    
    
    func leftFooterButtonAction(button:UIButton){
        self.delegate?.leftFooterButtonAction(button: button)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
