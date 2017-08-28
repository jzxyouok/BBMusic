//
//  UserModel.swift
//  bbb
//
//  Created by bb on 2016/12/28.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit
import AVOSCloud

class UserModel: NSObject {
    
    
    static var uid:String = ""
    
    static var userName:String = ""
    
    static var password:String = ""
    
    static var email:String = ""
    
    static var emailVerified:Bool = false
    
    static var phone:String = ""
    
    static var phoneVerified:Bool = false
    
    static var imageUrl:String = ""
    
    static var sex:String = ""
    
    static var age:String = ""
    
    static var job:String = ""
    
    static var loginState:Bool = false
    
    static var loginType:String = ""
    
    //检测用户是否已经登录
    static var isUserLogin:Bool{
        if let currentUser = AVUser.current() {
            // 当前用户名
            let username = currentUser.username
            if username != nil{
                return true
            }else{
                return false
            }
        }
        return false
    }
    
    //注册
    class func register(username:String, password:String){
        
        let user:AVUser = AVUser() // 新建 AVUser 对象实例
        user.username = username// 设置用户名
        user.password = password// 设置密码
        user.email = username// 设置邮箱
        user.signUpInBackground { (succeeded, error) in
            if succeeded {
                // 注册成功
                print("注册成功 \(succeeded)")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RegisterStatus"), object: "success")
            }else{
                // 失败的原因可能有多种，常见的是用户名已经存在。
                let code = (error! as NSError).code
                switch code {
                case 203:
                    showProgressHUD(title: "邮箱地址已经被占用")
                    break
                case -1001:
                    showProgressHUD(title: "请求超时")
                    break
                case -1009:
                    showProgressHUD(title: "网络已断开")
                    break
                default:
                    break
                }
            }
        }
        
    }
    
    //登录
    class func login(username:String, password:String){
        
        AVUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil{
                print("登录成功 \(String(describing: user?.username))")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginStatus"), object: "success")
            }else{
                let code = (error! as NSError).code
                print("错误代码：\(code)")
                switch code {
                case 211:
                    showProgressHUD(title: "用户名不存在")
                    break
                case 216:
                    showProgressHUD(title: "邮箱地址未验证")
                    break
                case 219:
                    showProgressHUD(title: "登录失败次数超过限制，请稍候再试，或者通过忘记密码重设密码")
                    break
                case -1001:
                    showProgressHUD(title: "请求超时")
                    break
                case -1009:
                    showProgressHUD(title: "网络已断开")
                    break
                default:
                    break
                }
            }
        }
        
    }
    
    //登出
    class func logout(){
        AVUser.logOut()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginStatus"), object: "success")
    }
    

}
