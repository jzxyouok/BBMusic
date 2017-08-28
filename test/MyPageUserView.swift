//
//  MyPageUserView.swift
//  test
//
//  Created by bb on 2017/4/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

protocol MyPageUserViewDelegate {
    func MyPageUserViewButtonAction(button:UIButton)
}

class MyPageUserView: UIView {

    var tipsLabel:UILabel!
    var loginButton:UIButton!
    var userImageButton:UIButton!
    var alreadyUseTimeButton:UIButton!
    var memberButton:UIButton!
    var userNameLabel:UILabel!
    var memberMarkImage:UIImageView!
    var delegate:MyPageUserViewDelegate?
    var itemArray  = [String]()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        tipsLabel = UILabel()
        //tipsLabel.backgroundColor = UIColor.yellow
        tipsLabel.text = "登陆听歌，听歌越多，推得越准"
        tipsLabel.textColor = TitleColor
        tipsLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalTo(self)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(15)
        }
        
        loginButton = UIButton()
        loginButton.setTitle("立即登陆", for: .normal)
        loginButton.setTitleColor(MainColor, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: defaultSize_15_16)
        loginButton.layer.borderColor = MainColor.cgColor
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.cornerRadius = 2
        loginButton.tag = 0
        loginButton.addTarget(self, action: #selector(MyPageUserView.buttonAction), for: .touchUpInside)
        self.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(tipsLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(34)
        }
        
        
        
        userImageButton = UIButton()
        userImageButton.isHidden = true
        userImageButton.setImage(UIImage(named: "user_img"), for: .normal)
        userImageButton.layer.cornerRadius = 30
        userImageButton.layer.masksToBounds = true
        self.addSubview(userImageButton)
        userImageButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        alreadyUseTimeButton = UIButton()
        alreadyUseTimeButton.isHidden = true
        alreadyUseTimeButton.setImage(UIImage(named: "apptheme_green_star_icon"), for: .normal)
        alreadyUseTimeButton.setTitle("12分钟", for: .normal)
        alreadyUseTimeButton.setTitleColor(TitleColor, for: .normal)
        alreadyUseTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        alreadyUseTimeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        alreadyUseTimeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        alreadyUseTimeButton.layer.cornerRadius = 14
        alreadyUseTimeButton.layer.masksToBounds = true
        alreadyUseTimeButton.layer.borderWidth = 0.5
        alreadyUseTimeButton.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(alreadyUseTimeButton)
        alreadyUseTimeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(userImageButton)
            make.right.equalTo(userImageButton.snp.left).offset(-20)
            make.width.lessThanOrEqualTo(80)
            make.height.equalTo(28)
        }

        memberButton = UIButton()
        memberButton.isHidden = true
        memberButton.setImage(UIImage(named: "apptheme_green_super_icon"), for: .normal)
        memberButton.setTitle("开通", for: .normal)
        memberButton.setTitleColor(TitleColor, for: .normal)
        memberButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        memberButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        memberButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        memberButton.layer.cornerRadius = 14
        memberButton.layer.masksToBounds = true
        memberButton.layer.borderWidth = 0.5
        memberButton.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(memberButton)
        memberButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(userImageButton)
            make.left.equalTo(userImageButton.snp.right).offset(20)
            make.width.lessThanOrEqualTo(80)
            make.height.equalTo(28)
        }
        
        
        userNameLabel = UILabel()
        userNameLabel.isHidden = true
        userNameLabel.text = "—  海绵宝宝  —"
        userNameLabel.textColor = TitleColor
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(userImageButton)
            make.top.equalTo(userImageButton.snp.bottom).offset(10)
            make.width.greaterThanOrEqualTo(60)
            make.height.lessThanOrEqualTo(30)
        }
        
        
        
    }
    
    //点击按钮 代理
    func buttonAction(button:UIButton){
        self.delegate?.MyPageUserViewButtonAction(button: button)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
