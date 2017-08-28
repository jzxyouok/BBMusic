//
//  APPSetting.swift
//  myForm
//
//  Created by bb on 2017/4/2.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Alamofire
import MediaPlayer
import AudioToolbox

class APPSetting: NSObject {
    
    static let userDefaults = UserDefaults.standard
    
    //初始化本地存储数据
    class func initLocalStorage(){
        CurrentPlaySQLite.creat()
        RecentPlaySQLite.creat()
        //查询
        CurrentPlaySQLite.prepare()
        RecentPlaySQLite.prepare()
    }
    
    
    //检测app是否是首次启动
    static var isFirstTimeOpen:Bool{
        get{
            let alertViewShowedFirstTime = userDefaults.string(forKey: "alertViewShowedFirstTime")
            if alertViewShowedFirstTime == nil {
                userDefaults.set("showed", forKey: "alertViewShowedFirstTime")
                userDefaults.synchronize()
                return true
            }else{
                return false
            }
        }
    }
    
    //仅wifi联网
    static var isWifiOnly:Bool{
        get{
            var wifiOnly = false
            if userDefaults.value(forKey: "wifiOnly") != nil{
                wifiOnly = userDefaults.bool(forKey: "wifiOnly")
            }
            return wifiOnly
        }
    }
    
    //设置仅wifi联网
    class func setWifiOnly(isChecked:Bool){
        userDefaults.set(isChecked, forKey: "wifiOnly")
        userDefaults.synchronize()
    }
    
    //获取本地存储的播放模式 0-顺序播放 1-单曲循环 2-随机播放
    static var getPlayModel:Int{
        get{
            var i = 0
            if userDefaults.value(forKey: "playModel") != nil{
                i = userDefaults.integer(forKey: "playModel")
            }
            return i
        }
    }
    
    //依次切换播放模式 0-顺序播放 1-单曲循环 2-随机播放
    class func switchPlayModel(){
        var i = getPlayModel
        i += 1
        if i > 2{
            i = 0
        }
        userDefaults.set(i, forKey: "playModel")
        userDefaults.synchronize()
    }
    
    
    //获取本地存储的播放进度
    static var currentTime:Double{
        get{
            var i = 0.0
            if userDefaults.value(forKey: "currentTime") != nil{
                i = userDefaults.double(forKey: "currentTime")
            }
            return i
        }
    }
    
    //设置当前播放歌曲进度
    class func setCurrentTime(currentTime:Double){
        userDefaults.set(currentTime, forKey: "currentTime")
        userDefaults.synchronize()
    }
    
    //获取本地存储的当前播放歌曲长度
    static var durationTime:Double{
        get{
            var i = 0.0
            if userDefaults.value(forKey: "durationTime") != nil{
                i = userDefaults.double(forKey: "durationTime")
            }
            return i
        }
    }
    
    //设置当前播放歌曲长度
    class func setDurationTime(durationTime:Double){
        userDefaults.set(durationTime, forKey: "durationTime")
        userDefaults.synchronize()
    }

    
    //检测当前网络类型－实时检测
    static let NetworkManager = NetworkReachabilityManager(host: "www.baidu.com")
    class func listenNetworkChange(){
        //实时监测网络变化
        NetworkManager!.listener = { status in
            print("检测到网络变化")
            switch status {
            case .notReachable:
                print("网络无法连接，请检查网络配置")
            case .unknown:
                print("未知网络")
            case .reachable(.ethernetOrWiFi):
                print("wifi")
            case .reachable(.wwan):
                print("2g/3g/4g")
            }
        }
        NetworkManager!.startListening()
    }
    
    
    
    //后台播放
    class func audioSession(){
        //创建会话，后台播放必须
        let audioSession = AVAudioSession.sharedInstance()
        //激活会话
        do{
            try audioSession.setActive(true)
        }catch{
            
        }
        //设置后台播放
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }catch{
            
        }
    }
     
}
