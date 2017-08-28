//
//  AppDelegate.swift
//  test
//
//  Created by bb on 2017/1/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import DrawerController
import AVFoundation
import MediaPlayer

var drawerController: DrawerController!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navBar:UINavigationBar = UINavigationBar.appearance()
        let dict:NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        navBar.titleTextAttributes = dict as? [String : Any]
        
        //启动页 延时2秒关闭
        Thread.sleep(forTimeInterval: 0.5)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        //初始化本地存储数据
        APPSetting.initLocalStorage()
        
        // 侧滑菜单
        let centerViewController = RootTabBarController()
        let leftSideNavController = LeftViewController()
        drawerController = DrawerController(centerViewController: centerViewController, leftDrawerViewController: leftSideNavController, rightDrawerViewController: nil)
        drawerController.showsShadows = true
        drawerController.maximumLeftDrawerWidth = WIN_WIDTH - 60
        drawerController.openDrawerGestureModeMask = .all
        drawerController.closeDrawerGestureModeMask = .all
        drawerController.centerHiddenInteractionMode = .none 
        drawerController.drawerVisualStateBlock = { (drawerController, drawerSide, percentVisible) in
            let block = DrawerVisualStateManager.sharedManager.drawerVisualStateBlock(for: drawerSide)
            block?(drawerController, drawerSide, percentVisible)
        }
        
        //检测app是否第一次打开（下载或更新）
        if APPSetting.isFirstTimeOpen == false{
            self.window!.rootViewController = drawerController
            //显示广告页
            SplashView.showSplashView(defaultImage: UIImage(named: "default_img"), tapSplashImageBlock: {(actionUrl) -> Void in
                print("跳转url: \(String(describing: actionUrl))")
            },splashViewDismissBlock: { (initiativeDismiss) in
                print("自动关闭: \(initiativeDismiss)")
            })
        }else{
            self.window!.rootViewController = GuideViewController()
        }
        //异步加载初始化，加速app冷启动速度
        asyncAfter(launchOptions: launchOptions)
        
        return true
    }
    

    //
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    //iOS 7 及以上iOS 10 及以下的系统版本
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.newData)
        
    }
    //iOS 6 及以下的系统版本
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
    }
    

    
    func applicationWillResignActive(_ application: UIApplication) {
        //一、挂起
        //当有电话进来或者锁屏，这时你的应用程会挂起，在这时，UIApplicationDelegate委托会收到通知，调用 applicationWillResignActive 方法，你可以重写这个方法，做挂起前的工作，比如关闭网络，保存数据。
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //二、复原
        //当程序复原时，另一个名为 applicationDidBecomeActive 委托方法会被调用，在此你可以通过之前挂起前保存的数据来恢复你的应用程序：
        // 清除角标
        application.applicationIconBadgeNumber = 0
        JPUSHService.setBadge(0)
        //锁屏／控制面板
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        //当用户按下按钮，或者关机，程序都会被终止。当一个程序将要正常终止时会调用 applicationWillTerminate 方法。但是如果长主按钮强制退出，则不会调用该方法。这个方法该执行剩下的清理工作，比如所有的连接都能正常关闭，并在程序退出前执行任何其他的必要的工作：
    }


}

