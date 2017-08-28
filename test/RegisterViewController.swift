//
//  registerViewController.swift
//  bbb
//
//  Created by bb on 16/8/16.
//  Copyright © 2016年 bb. All rights reserved.
//
import UIKit
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var formView:RegisterFormView!
    
    //前端验证textfield逻辑
    func checkTextField(){
        //
        if formView.emailTextField.text! == ""{
            formView.emailTextField.becomeFirstResponder()
            showProgressHUD(title: "请填写邮箱")
            return
        }else{
            if Validate.email(formView.emailTextField.text!).isRight == true{
                formView.passwordTextField.becomeFirstResponder()
            }else{
                formView.emailTextField.becomeFirstResponder()
                showProgressHUD(title: "邮箱格式不正确")
                return
            }
        }
        //
        if formView.passwordTextField.text! == ""{
            showProgressHUD(title: "请填写密码")
            return
        }else{
            if (formView.passwordTextField.text?.characters.count)! >= 6{
                formView.comfirmPasswordTextField.becomeFirstResponder()
            }else{
                formView.passwordTextField.becomeFirstResponder()
                showProgressHUD(title: "密码长度最少6位")
                return
            }
        }
        //
        if formView.emailTextField.text! != "" && formView.passwordTextField.text! != "" && formView.comfirmPasswordTextField.text! == ""{
            showProgressHUD(title: "请填写确认密码")
            return
        }else{
            if formView.passwordTextField.text! == formView.comfirmPasswordTextField.text!{
                formView.emailTextField.resignFirstResponder()
                formView.passwordTextField.resignFirstResponder()
                formView.comfirmPasswordTextField.resignFirstResponder()
                //前端验证通过，请求服务器验证数据
                UserModel.register(username: formView.emailTextField.text!, password: formView.passwordTextField.text!)
            }else{
                showProgressHUD(title: "两次密码不一致")
                return
            }
        }
    }
    

    
    func textFieldTextDidChange(sender:UITextField){
        switch sender.tag {
        case 0:
            if formView.emailTextField.text! == ""&&formView.emailTextField.becomeFirstResponder() != true{
                showProgressHUD(title: "请填写邮箱")
            }
            break
        case 1:
            if formView.passwordTextField.text! == ""&&formView.passwordTextField.becomeFirstResponder() != true{
                showProgressHUD(title: "请填写密码")
            }
            break
        case 2:
            if formView.comfirmPasswordTextField.text! == ""&&formView.comfirmPasswordTextField.becomeFirstResponder() != true{
                showProgressHUD(title: "请填写确认密码")
            }
            break
        default:
            break
        }
        if formView.emailTextField.text! != "" && formView.passwordTextField.text! != "" && formView.comfirmPasswordTextField.text! != ""{
            formView.registerButton.isEnabled = true
        }else{
            formView.registerButton.isEnabled = false
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
            formView.comfirmPasswordTextField.resignFirstResponder()
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
        let cancelBtn = UIBarButtonItem(title: "取消", style: .plain, target: self, action:#selector(RegisterViewController.closeViewController))
        cancelBtn.tintColor = MainColor
        self.navigationItem.leftBarButtonItem = cancelBtn
        
        //注册触摸事件
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap(_:))))
        
        //表单view
        formView = RegisterFormView.init(frame: self.view.frame)
        formView.emailTextField.delegate = self
        formView.emailTextField.addTarget(self, action: #selector(RegisterViewController.textFieldTextDidChange), for: .editingChanged)
        formView.passwordTextField.delegate = self
        formView.passwordTextField.addTarget(self, action: #selector(RegisterViewController.textFieldTextDidChange), for: .editingChanged)
        formView.comfirmPasswordTextField.delegate = self
        formView.comfirmPasswordTextField.addTarget(self, action: #selector(RegisterViewController.textFieldTextDidChange), for: .editingChanged)
        formView.registerButton.addTarget(self, action: #selector(RegisterViewController.checkTextField), for: .touchUpInside)
        self.view.addSubview(formView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.closeViewController), name: NSNotification.Name(rawValue: "RegisterStatus"), object: nil)

    }
    
    
    
    //关闭
    func closeViewController(){
        if UserModel.isUserLogin == true{
            UIApplication.shared.statusBarStyle = .lightContent
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
