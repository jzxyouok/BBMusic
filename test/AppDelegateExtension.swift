//
//  AppDelegate.swift
//  test
//
//  Created by bb on 2017/1/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import AVOSCloud

extension AppDelegate : JPUSHRegisterDelegate{
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter willPresent");
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue))// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter didReceive");
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
        
        // 取得 APNs 标准信息内容
        let json = JSON(userInfo)
        let url = json["url"].string!
        showProgressHUD(title: url)
        //print(url)
    }
}



extension AppDelegate{

    //定义 remoteControlReceivedWithEvent，处理具体的播放、暂停、前进、后退等具体事件
    override func remoteControlReceived(with receivedEvent: UIEvent?) {
        if receivedEvent?.type == UIEventType.remoteControl{
            if receivedEvent?.subtype == .remoteControlNextTrack{
                PlayAction.Next()
            }else if receivedEvent?.subtype == .remoteControlPreviousTrack{
                PlayAction.Prev()
            }else if receivedEvent?.subtype == .remoteControlPause{
                PlayAction.Pause()
            }else if receivedEvent?.subtype == .remoteControlPlay{
                PlayAction.Pause()
            }else if receivedEvent?.subtype == .remoteControlTogglePlayPause{
                //耳机线控 播放／暂停
                PlayAction.Pause()
            }
        }
    }
    
    
    //第一响应者
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    //延迟2s启动执行
    func asyncAfter(launchOptions: [UIApplicationLaunchOptionsKey: Any]?){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //初始化leancloud
            AVOSCloud.setApplicationId(LeanCloudModel.applicationID, clientKey: LeanCloudModel.clientKey)
            //监听网络变化
            APPSetting.listenNetworkChange()
            //初始化社会化分享
            ShareModel.initMOBShareSDK(byAppId: ShareModel.byAppId, appSecret: ShareModel.appSecret)
            //后台播放
            APPSetting.audioSession()
            //推送
            if #available(iOS 10.0, *){
                let entiity = JPUSHRegisterEntity()
                entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
                    UNAuthorizationOptions.badge.rawValue |
                    UNAuthorizationOptions.sound.rawValue)
                JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self as JPUSHRegisterDelegate)
            } else if #available(iOS 8.0, *) {
                let types = UIUserNotificationType.badge.rawValue |
                    UIUserNotificationType.sound.rawValue |
                    UIUserNotificationType.alert.rawValue
                JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
            }else {
                let type = UIRemoteNotificationType.badge.rawValue |
                    UIRemoteNotificationType.sound.rawValue |
                    UIRemoteNotificationType.alert.rawValue
                JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
            }
            
            JPUSHService.setup(withOption: launchOptions, appKey: "5c77d04e519529c32295048a", channel: "app store", apsForProduction: false)
        }
    }

}
