//
//  ViewController.swift
//  music
//
//  Created by bb on 16-7-31.
//  Copyright (c) 2016年 bb. All rights reserved.
//

import UIKit
import AVFoundation
import StreamingKit
import SDWebImage


class PlayerViewController: UIViewController{

    var backgroundView:BackgroundView!
    var songNameView:SongNameView!
    var bottomView:BottomView!
    var topView:TopView!
    var playerScrollviewController:PlayerScrollviewController!
    var pageController:UIPageControl!
    var timeSlider:UISlider!
    
    
    //下载/缓冲进度 回调
    func cacheProgress(){
        DispatchQueue.main.async(execute: {
            self.bottomView.playProgressView.timeSliderView.progressView.setProgress(currentSongInfoModel_kugou.cacheProgress, animated: false)
        })
    }
    
    
    //获取歌曲信息 并更新播放进度/时间
    func nowPlayingTime(notification:Notification){
        
        let audioPlayer = notification.object as! STKAudioPlayer
        //播放／暂停按钮
        let playButton = self.bottomView.controlButtonsView.viewWithTag(1111) as! UIButton
        let currentLabel = self.bottomView.playProgressView.currentLabel
        let durationLabel = self.bottomView.playProgressView.durationLabel
        
        DispatchQueue.main.async(execute: {
            if audioPlayer.state == .stopped{
                self.timeSlider?.value = 0
                playButton.isSelected = false
                playButton.setImage(UIImage(named: "player_btn_play_normal"), for: .normal)
                playButton.setImage(UIImage(named: "player_btn_play_highlight"), for: .highlighted)
            }else{
                if audioPlayer.state == .playing{
                    self.timeSlider?.value = Float(currentSongInfoModel_kugou.currentTime*100/currentSongInfoModel_kugou.durationTime)
                    playButton.isSelected = true
                    playButton.setImage(UIImage(named: "player_btn_pause_normal"), for: .normal)
                    playButton.setImage(UIImage(named: "player_btn_pause_highlight"), for: .highlighted)
                }else{
                    playButton.isSelected = false
                    playButton.setImage(UIImage(named: "player_btn_play_normal"), for: .normal)
                    playButton.setImage(UIImage(named: "player_btn_play_highlight"), for: .highlighted)
                }
            }
            
            //当前进度／总时长
            currentLabel?.text = Common.stringFromTimeInterval(interval: currentSongInfoModel_kugou.currentTime)
            durationLabel?.text = Common.stringFromTimeInterval(interval: currentSongInfoModel_kugou.durationTime)

        })
    }
    
    
    //获取歌曲信息 并更新歌曲名／歌手／封面图片
    func nowPlayingInfo(){
        
        let coverImage = self.playerScrollviewController.topView.coverImage
        let progressView = self.bottomView.playProgressView.timeSliderView.progressView
        let backgroundImageView = self.backgroundView.backgroundImageView
        let songNameLabel = self.songNameView.songNameLabel
        let authorLabel = self.playerScrollviewController.topView.songInfoView.authorLabel
        let currentLabel = self.bottomView.playProgressView.currentLabel
        let durationLabel = self.bottomView.playProgressView.durationLabel
        
        let isplaying = currentSongInfoModel_kugou.isplaying
        if isplaying == true{
            RotationAnimation.resumeAnimation(view: coverImage!)
        }else{
            RotationAnimation.pauseAnimation(view: coverImage!)
        }

        let songname = currentSongInfoModel_kugou.songname
        let singername = currentSongInfoModel_kugou.singername != "" ? "- \(currentSongInfoModel_kugou.singername) -" : currentSongInfoModel_kugou.singername
        let imgUrl = currentSongInfoModel_kugou.imgUrl
        let isCached = currentSongInfoModel_kugou.isCached
        let url = URL(string: imgUrl)
        let defaultImage = UIImage(named: "音乐_播放器_默认唱片头像")
        songNameLabel?.text = songname
        authorLabel?.text = singername
        
        UIView.transition(with: coverImage!, duration: 0, options: [.transitionCrossDissolve], animations: {
        
            DispatchQueue.main.async(execute: {
                self.timeSlider?.isEnabled = true
                progressView?.setProgress(currentSongInfoModel_kugou.cacheProgress, animated: false)
                //当前进度／总时长
                currentLabel?.text = Common.stringFromTimeInterval(interval: APPSetting.currentTime)
                durationLabel?.text = Common.stringFromTimeInterval(interval: APPSetting.durationTime)
                //圆图
                if url != nil{
                    if isCached == true{
                        let cacheImage = currentSongInfoModel_kugou.getCacheImage(url: url!)
                        coverImage?.image = cacheImage
                        backgroundImageView?.image = cacheImage
                    }else{
                        coverImage?.sd_setImage(with: url, placeholderImage: defaultImage)
                        backgroundImageView?.sd_setImage(with: url, placeholderImage: defaultImage)
                    }
                }else{
                    coverImage?.image = defaultImage
                    backgroundImageView?.image = defaultImage
                }
            })
        }, completion: { (true) in
            
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalPresentationStyle = .custom
        self.modalTransitionStyle = .crossDissolve

        //设置状态栏文字为白色
        UIApplication.shared.statusBarStyle = .lightContent
        
        //背景图片（高斯模糊效果）
        self.backgroundView = BackgroundView.init(frame: self.view.frame)
        self.view.addSubview(self.backgroundView)
        
        //1.navigation 标题
        self.songNameView = SongNameView(frame: CGRect(x: 0, y: -64, width: WIN_WIDTH, height: 44))
        self.view.addSubview(self.songNameView)
        
        //2.顶部view(后期添加滚动效果)
        self.playerScrollviewController = PlayerScrollviewController()
        self.addChildViewController(self.playerScrollviewController)
        self.view.addSubview(self.playerScrollviewController.view)
        self.playerScrollviewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 180, 0))
        }

        //3.中间 －创建轮播页码
        self.pageController = UIPageControl()
        self.pageController.numberOfPages = 3
        self.pageController.currentPage = 1
        self.pageController.pageIndicatorTintColor = UIColor.init(red: 162/255, green: 153/255, blue: 169/255, alpha: 1)
        self.pageController.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(self.pageController)
        self.pageController.snp.makeConstraints { (make) in
            make.top.equalTo(self.playerScrollviewController.view.snp.bottom)
            make.left.equalTo(self.playerScrollviewController.view.snp.left)
            make.right.equalTo(self.playerScrollviewController.view.snp.right)
            make.height.equalTo(20)
        }
        
        //4.底部view
        self.bottomView = BottomView(frame: CGRect(x: 0, y: WIN_HEIGHT, width: WIN_WIDTH, height: 160))
        self.bottomView.controlButtonsView.playModel.addTarget(self, action: #selector(playerButtonAction), for: .touchUpInside)
        self.bottomView.controlButtonsView.playList.addTarget(self, action: #selector(playerButtonAction), for: .touchUpInside)
        self.view.addSubview(self.bottomView)
        
        timeSlider = self.bottomView.playProgressView.timeSliderView.timeSlider
        
        //初始化旋转动画
        RotationAnimation.initImageAnimation(view: self.playerScrollviewController.topView.coverImage)
        
        //在重新打开PlayerViewController时更新ui
        nowPlayingInfo()
        
        //监听来自RootTabBarController的信息 nowPlayingTime
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.nowPlayingTime), name:NSNotification.Name(rawValue: "nowPlayingTime"), object: nil)
        
        //监听来自RootTabBarController的信息 nowPlayingInfo
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.nowPlayingInfo), name:NSNotification.Name(rawValue: "nowPlayingInfo"), object: nil)
        
        //监听下载/缓冲 进度
        NotificationCenter.default.addObserver(self, selector: #selector(PlayerViewController.cacheProgress), name: NSNotification.Name(rawValue: "CacheProgress"), object: nil)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            self.songNameView.frame.origin.y = 20
            self.bottomView.frame.origin.y = WIN_HEIGHT-160
        })
        self.songNameView.delegate = self
        self.playerScrollviewController.delegate = self
        self.bottomView.songOperationsView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.songNameView.delegate = nil
        self.playerScrollviewController.delegate = nil
        self.bottomView.songOperationsView.delegate = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

