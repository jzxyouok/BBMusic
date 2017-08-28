//
//  registerViewController.swift
//  bbb
//
//  Created by bb on 16/8/16.
//  Copyright © 2016年 bb. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var formView:LoginFormView!
    
    //前端验证textfield逻辑
    func checkTextField(){
        //
        if formView.emailTextField.text! == ""{
            formView.emailTextField.becomeFirstResponder()
            showProgressHUD(title: "请填写账号")
            return
        }else{
            formView.passwordTextField.becomeFirstResponder()
        }
        //
        if formView.passwordTextField.text! == ""{
            showProgressHUD(title: "请填写密码")
            return
        }
        //验证通过，请求登录服务器
        UserModel.login(username: formView.emailTextField.text!, password: formView.passwordTextField.text!)
    }
    
    
    
    func textFieldTextDidChange(sender:UITextField){
        switch sender.tag {
        case 0:
            if formView.emailTextField.text! == ""&&formView.emailTextField.becomeFirstResponder() != true{
                showProgressHUD(title: "请填写账号")
            }
            break
        case 1:
            if formView.passwordTextField.text! == ""&&formView.passwordTextField.becomeFirstResponder() != true{
                showProgressHUD(title: "请填写密码")
            }
            break
        default:
            break
        }
        if formView.emailTextField.text! != "" && formView.passwordTextField.text! != ""{
            formView.loginButton.isEnabled = true
        }else{
            formView.loginButton.isEnabled = false
        }
    }
    
    
    //点击returnkey 执行
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        checkTextField()
        return true
    }
    
    
    
    //触摸空白处收起键盘
    func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            formView.emailTextField.resignFirstResponder()
            formView.passwordTextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
        return
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        //设置状态栏文字为白色
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        //背景色为白色
        self.view.backgroundColor = UIColor.white
        
        //状态了背景色(透明)
        self.navigationController?.navigationBar.setBackgroundImage(imageOpacityNavigationBar, for: .default)
        self.navigationController?.navigationBar.shadowImage = imageOpacityNavigationBar
        
        //取消按钮
        let cancelBtn = UIBarButtonItem(title: "取消", style: .plain, target: self, action:#selector(LoginViewController.closeViewController))
        cancelBtn.tintColor = MainColor
        self.navigationItem.leftBarButtonItem = cancelBtn
        
        //注册按钮
        let registerBtn = UIBarButtonItem(title: "注册", style: .plain, target: self, action:#selector(LoginViewController.registerViewController))
        registerBtn.tintColor = MainColor
        self.navigationItem.rightBarButtonItem = registerBtn
        
        //注册触摸事件
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap(_:))))
        
        //表单view
        formView = LoginFormView.init(frame: self.view.frame)
        formView.emailTextField.delegate = self
        formView.emailTextField.addTarget(self, action: #selector(RegisterViewController.textFieldTextDidChange), for: .editingChanged)
        formView.passwordTextField.delegate = self
        formView.passwordTextField.addTarget(self, action: #selector(RegisterViewController.textFieldTextDidChange), for: .editingChanged)
        formView.loginButton.addTarget(self, action: #selector(LoginViewController.checkTextField), for: .touchUpInside)
        self.view.addSubview(formView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.closeViewController), name: NSNotification.Name(rawValue: "loginStatus"), object: nil)
        
    }
    
    
    //关闭
    func closeViewController(){
        UIApplication.shared.statusBarStyle = .lightContent
        self.dismiss(animated: true) { 
            
        }
    }
    
    //打开注册
    func registerViewController(){
        let nvc = UINavigationController(rootViewController: RegisterViewController())
        self.present(nvc, animated: true) { 
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
