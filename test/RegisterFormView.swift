//
//  RegisterFormView.swift
//  myForm
//
//  Created by bb on 2017/4/2.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class RegisterFormView: UIView {
    
    lazy var scrollView = UIScrollView()
    lazy var loginTitle = UILabel()
    lazy var emailView = UIView()
    lazy var emailLabel = UILabel()
    lazy var emailTextField = UITextField()
    lazy var passwordView = UIView()
    lazy var passwordLabel = UILabel()
    lazy var passwordTextField = UITextField()
    lazy var comfirmPasswordView = UIView()
    lazy var comfirmPasswordLabel = UILabel()
    lazy var comfirmPasswordTextField = UITextField()
    lazy var registerButton = UIButton(type: .custom)
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
        loginTitle.text = "使用邮箱注册"
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
        emailTextField.placeholder = "请填写邮箱"
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
        passwordTextField.returnKeyType = .next
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
        
        
        
        //确认密码view（含label和textfield）
        scrollView.addSubview(comfirmPasswordView)
        comfirmPasswordView.snp.makeConstraints { (make) in
            make.height.equalTo(passwordView)
            make.top.equalTo(passwordView.snp.bottom)
            make.left.equalTo(passwordView)
            make.right.equalTo(passwordView)
        }
        
        //确认密码label
        comfirmPasswordView.addSubview(comfirmPasswordLabel)
        comfirmPasswordLabel.text = "确认密码"
        comfirmPasswordLabel.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(comfirmPasswordView)
            make.top.equalTo(comfirmPasswordView)
            make.left.equalTo(comfirmPasswordView)
        }
        //确认密码textfield
        comfirmPasswordView.addSubview(comfirmPasswordTextField)
        comfirmPasswordTextField.tag = 2
        comfirmPasswordTextField.enablesReturnKeyAutomatically = true
        comfirmPasswordTextField.placeholder = "请再次填写密码"
        comfirmPasswordTextField.isSecureTextEntry = true
        comfirmPasswordTextField.returnKeyType = .done
        comfirmPasswordTextField.tintColor = MainColor
        comfirmPasswordTextField.clearButtonMode = .whileEditing
        comfirmPasswordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(comfirmPasswordView)
            make.top.equalTo(comfirmPasswordView)
            make.left.equalTo(comfirmPasswordLabel.snp.right).offset(15)
            make.right.equalTo(comfirmPasswordView.snp.right).offset(-15)
        }
        //确认密码view底部细线
        let layer3 = CALayer()
        layer3.backgroundColor = SeparatorColor.cgColor
        layer3.frame = CGRect(x: 0, y: 44-0.5,width: self.frame.width-15, height: 0.5)
        comfirmPasswordView.layer.addSublayer(layer3)
        
        
        //登陆按钮
        scrollView.addSubview(registerButton)
        registerButton.setTitle("注册", for: .normal)
        registerButton.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5), for: .disabled)
        registerButton.setTitleColor(UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8), for: .highlighted)
        registerButton.setBackgroundImage(imageMainColor, for: .normal)
        registerButton.setBackgroundImage(imageDisabled, for: .disabled)
        registerButton.setBackgroundImage(imageHightLight, for: .highlighted)
        registerButton.layer.cornerRadius = 5
        registerButton.clipsToBounds = true
        registerButton.isEnabled = false
        registerButton.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.top.equalTo(comfirmPasswordView.snp.bottom).offset(30)
            make.left.equalTo(emailView)
            make.right.equalTo(emailView).offset(-15)
        }
          
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
