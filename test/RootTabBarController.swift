//
//  RootTabBarController.swift
//  bbb
//
//  Created by bb on 16/8/17.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit
import AVFoundation
import StreamingKit
import SDWebImage

var audio:STKAudioPlayer!

class RootTabBarController: UITabBarController, TabBarViewDelegate, STKAudioPlayerDelegate {
    
    var tabBarView:TabBarView!
    var timer:DispatchSourceTimer?

    func audioPlayer(_ audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
         //print("开始播放")
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, with stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        //print("结束播放:原因::\(stopReason.rawValue)")
        if stopReason == .eof{
            PlayAction.Next()
        }
    }

    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        print("完成加载")
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        //print("播放状态改变:\(state)")
        //更新播放／暂停 按钮状态
        updateButtonStatus()
        if audio.state == .playing{
            //启动定时器
            timeInterval()
            //更新锁屏部分信息
            lockScreenPlayingSongInfo()
            //更新ui，歌曲名／歌手
            currentSongInfo()
            currentSongInfoModel_kugou.isplaying = true
            RotationAnimation.resumeAnimation(view: self.tabBarView.smallImage)
        }else{
            currentSongInfoModel_kugou.isplaying = false
            RotationAnimation.pauseAnimation(view: self.tabBarView.smallImage)
        }
        DispatchQueue.main.async(execute: {
            if currentSongInfoModel_kugou.url != ""{
                self.tabBarView.nextButton.isEnabled = true
                self.tabBarView.playButton.isEnabled = true
                self.tabBarView.circleView.isHidden = false
            }else{
                self.tabBarView.nextButton.isEnabled = false
                self.tabBarView.playButton.isEnabled = false
                self.tabBarView.circleView.isHidden = true
            }
        })
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nowPlayingInfo"), object: nil)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, logInfo line: String) {
        //print("播放信息:\(line)")
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didCancelQueuedItems queuedItems: [Any]) {
        //print("取消播放")
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        //print("错误代码：\(errorCode.rawValue)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        //创建导航控制器
        let mainVc = HomeViewController()
        let nvc = UINavigationController(rootViewController: mainVc)
        self.viewControllers = [nvc]
        
        tabBarView = TabBarView.init(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 60))
        tabBarView.delegate = self
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(RootTabBarController.openPlayerHUD))
        tabBarView.smallImage.addGestureRecognizer(gesture)
        
        self.tabBar.addSubview(tabBarView)
        
        //初始化播放器
        initPlayer()
        //初始化当前歌曲信息
        currentSongInfo()
        //初始化播放进度条
        updatingProgress()
        //监听播放歌曲请求完成
        NotificationCenter.default.addObserver(self, selector: #selector(RootTabBarController.Play), name: NSNotification.Name(rawValue: "SongHashSearchDone"), object: nil)
        //监听通过hud控制播放
        NotificationCenter.default.addObserver(self, selector: #selector(RootTabBarController.HUDPlay), name: NSNotification.Name(rawValue: "controlByHUD"), object: nil)
        //监听输出改变
        NotificationCenter.default.addObserver(self, selector: #selector(RootTabBarController.routChange), name:NSNotification.Name.AVAudioSessionRouteChange, object: nil)
        //监听播放被中断
        NotificationCenter.default.addObserver(self, selector: #selector(RootTabBarController.interRuption), name:NSNotification.Name.AVAudioSessionInterruption, object: nil)
        //监听进度条滑动
        NotificationCenter.default.addObserver(self, selector: #selector(RootTabBarController.sliderValueChange), name:NSNotification.Name(rawValue: "SliderValueChange"), object: nil)
        //监听当前播放歌词 段 通知
        NotificationCenter.default.addObserver(self, selector: #selector(lockScreenPlayingSongInfo), name: NSNotification.Name(rawValue: "currentLrcStr"), object: nil)
        
        //初始化旋转动画
        RotationAnimation.initImageAnimation(view: self.tabBarView.smallImage)
        
        //获取最新广告图片
        SplashView.updateSplashData("http://ww2.sinaimg.cn/large/72f96cbagw1f5mxjtl6htj20g00sg0vn.jpg", actUrl: "http://jkyeo.com")
    }


    //初始化播放器
    func initPlayer(){
        audio = Streamer.shareInstance.player
        audio.delegate = self
    }
    
    
    //播放
    func Play(){
        PlayAction.Play()
    }
    

    //定时器
    func timeInterval(){
        //定时器
        timer?.cancel()
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer?.scheduleRepeating(deadline: .now(), interval: 0.3)
        timer?.setEventHandler { 
            currentSongInfoModel_kugou.durationTime = audio.duration
            currentSongInfoModel_kugou.currentTime = audio.progress
            //更新当前进度
            self.updatingProgress()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nowPlayingTime"), object: audio)
        }
        timer?.resume()
    }
    
 
    //拖动进度条
    func sliderValueChange(n: Notification) {
        let value =  Double(n.userInfo?["value"] as! Float32)
        audio.seek(toTime: value*currentSongInfoModel_kugou.durationTime/100)
    }
    
    
    //TabBarViewDelegate 播放／暂停／下一首 按钮
    func buttonAction(button: UIButton) {
        switch button.tag {
        case 1001:
            PlayAction.Next()
            break
        case 1002:
            PlayAction.Pause()
            break
        default:
            break
        }
    }
    
    
    func HUDPlay(notication: Notification){
        let tag = notication.userInfo?["tag"] as! Int
        switch tag {
        case 1110:
            //print("prev")
            PlayAction.Prev()
            break
        case 1111:
            //print("play")
            PlayAction.Pause()
            break
        case 1112:
            //print("next")
            PlayAction.Next()
            break
        default:
            break
        }
    }
    
    
    //HUD
    func openPlayerHUD(){
        print("click")
        let vc = PlayerViewController()
        vc.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        self.present(vc, animated: false, completion: nil)
    }
    

    //重写UITabBarController的UITabBarController方法 修改默认高度
    override func viewWillLayoutSubviews() {
        self.tabBar.barTintColor = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        self.tabBar.frame.size.height = 60
        self.tabBar.frame.origin.y = self.view.frame.size.height - 60
        self.tabBar.frame = self.tabBar.frame
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
        timer?.cancel()
        timer = nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
