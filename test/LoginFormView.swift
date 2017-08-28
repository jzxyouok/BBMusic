//
//  RegisterFormView.swift
//  myForm
//
//  Created by bb on 2017/4/2.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class LoginFormView: UIView {
    
    lazy var scrollView = UIScrollView()
    lazy var loginTitle = UILabel()
    lazy var emailView = UIView()
    lazy var emailLabel = UILabel()
    lazy var emailTextField = UITextField()
    lazy var passwordView = UIView()
    lazy var passwordLabel = UILabel()
    lazy var passwordTextField = UITextField()
    lazy var loginButton = UIButton(type: .custom)
    lazy var weibo = UIButton()
    lazy var weixin = UIButton()
    lazy var QQ = UIButton()
    var statusBarView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        //scrollview 弹性效果
        self.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: 0, height: self.frame.height)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets.zero)
        }
        
        
        //标题label
        scrollView.addSubview(loginTitle)
        loginTitle.textColor = UIColor.init(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)
        loginTitle.text = "使用账号和密码登录"
        loginTitle.font = UIFont.systemFont(ofSize: defaultSize_20_24)
        loginTitle.textAlignment = .center
        loginTitle.snp.makeConstraints { (make) in
            make.width.equalTo(scrollView)
            make.height.equalTo(80)
            make.top.equalTo(scrollView).offset(64)
        }
        
        
        //账号view（含label和textfield）
        scrollView.addSubview(emailView)
        emailView.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalTo(scrollView).offset(-15)
            make.top.equalTo(loginTitle.snp.bottom)
            make.left.equalTo(scrollView).offset(15)
            
        }
        //账号label
        emailView.addSubview(emailLabel)
        emailLabel.text = "账号"
        emailLabel.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(emailView)
            make.top.equalTo(emailView)
            make.left.equalTo(emailView)
        }
        //账号textfield
        emailView.addSubview(emailTextField)
        emailTextField.tag = 0
        emailTextField.enablesReturnKeyAutomatically  = true
        emailTextField.placeholder = "BB音乐账号/邮箱地址"
        emailTextField.returnKeyType = .next
        emailTextField.tintColor = MainColor
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.keyboardType = .emailAddress
        emailTextField.snp.makeConstraints { (make) in
            make.height.equalTo(emailView)
            make.top.equalTo(emailView)
            make.left.equalTo(emailLabel.snp.right).offset(15)
            make.right.equalTo(emailView.snp.right).offset(-15)
        }
        //账号view底部细线
        let layer1 = CALayer()
        layer1.backgroundColor = SeparatorColor.cgColor
        layer1.frame = CGRect(x: 0, y: 44-0.5,width: self.frame.width-15, height: 0.5)
        emailView.layer.addSublayer(layer1)
        
        
        
        //密码view（含label和textfield）
        scrollView.addSubview(passwordView)
        passwordView.snp.makeConstraints { (make) in
            make.height.equalTo(emailView)
            make.top.equalTo(emailView.snp.bottom)
            make.left.equalTo(emailView)
            make.right.equalTo(emailView)
        }
        
        //密码label
        passwordView.addSubview(passwordLabel)
        passwordLabel.text = "密码"
        passwordLabel.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(passwordView)
            make.top.equalTo(passwordView)
            make.left.equalTo(passwordView)
        }
        //密码textfield
        passwordView.addSubview(passwordTextField)
        passwordTextField.tag = 1
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.placeholder = "请填写密码"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .done
        passwordTextField.tintColor = MainColor
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(passwordView)
            make.top.equalTo(passwordView)
            make.left.equalTo(passwordLabel.snp.right).offset(15)
            make.right.equalTo(passwordView.snp.right).offset(-15)
        }
        //密码view底部细线
        let layer2 = CALayer()
        layer2.backgroundColor = SeparatorColor.cgColor
        layer2.frame = CGRect(x: 0, y: 44-0.5,width: self.frame.width-15, height: 0.5)
        passwordView.layer.addSublayer(layer2)
          
        
        //登陆按钮
        scrollView.addSubview(loginButton)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5), for: .disabled)
        loginButton.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8), for: .highlighted)
        loginButton.setBackgroundImage(imageMainColor, for: .normal)
        loginButton.setBackgroundImage(imageDisabled, for: .disabled)
        loginButton.setBackgroundImage(imageHightLight, for: .highlighted)
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        loginButton.isEnabled = false
        loginButton.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.top.equalTo(passwordView.snp.bottom).offset(30)
            make.left.equalTo(emailView)
            make.right.equalTo(emailView).offset(-15)
        }
        
        
        
        weixin.setImage(scaleToSize(img: UIImage(named: "share0")!, size: CGSize(width: 44, height: 44)), for: .normal)
        //weixin.addTarget(self, action: #selector(LoginViewController.weixinLogin), for: .touchUpInside)
        scrollView.addSubview(weixin)
        weixin.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.top.equalTo(loginButton.snp.bottom).offset(100)
            make.width.equalTo(weixin.snp.height)
            make.centerX.equalTo(self)
        }
        
        QQ.setImage(scaleToSize(img: UIImage(named: "share1")!, size: CGSize(width: 42, height: 42)), for: .normal)
        //QQ.addTarget(self, action: #selector(LoginViewController.QQLogin), for: .touchUpInside)
        scrollView.addSubview(QQ)
        QQ.snp.makeConstraints { (make) in
            make.height.equalTo(weixin)
            make.top.equalTo(weixin.snp.top)
            make.width.equalTo(weixin)
            make.right.equalTo(weixin.snp.left).offset(-44)
        }
        
        
        weibo.setImage(scaleToSize(img: UIImage(named: "share3")!, size: CGSize(width: 44, height: 44)), for: .normal)
        //weibo.addTarget(self, action: #selector(LoginViewController.weiboLogin), for: .touchUpInside)
        scrollView.addSubview(weibo)
        weibo.snp.makeConstraints { (make) in
            make.height.equalTo(weixin)
            make.top.equalTo(weixin.snp.top)
            make.width.equalTo(weixin)
            make.left.equalTo(weixin.snp.right).offset(44)
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
