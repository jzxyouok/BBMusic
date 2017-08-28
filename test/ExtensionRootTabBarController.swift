//
//  Extension.swift
//  test
//
//  Created by bb on 2017/1/19.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

extension RootTabBarController{
    
    //声音输出设备改变
    func routChange(notification:NSNotification){
        let dic = notification.userInfo
        let changeReason = dic?["AVAudioSessionRouteChangeReasonKey"] as! Int
        if changeReason == 2{
            audio.pause()
        }
    }
    
    //播放被其他操作中断（电话／闹钟等）
    func interRuption(notification:NSNotification){
        let dic = notification.userInfo
        let interRuptionReason = dic?["AVAudioSessionInterruptionTypeKey"] as! Int
        if interRuptionReason == 1{
            audio.pause()
        }
    }
    
    //主线程更新UI(播放进度)
    func updatingProgress(){
        //更新歌词
        LrcProcessModel.updateLRCContent()
        DispatchQueue.main.async(execute: {
            if audio.state == .stopped{
                self.tabBarView.circleView.progress = 0
            }else{
                if audio.state == .playing{
                    self.tabBarView.circleView.progress = Float(currentSongInfoModel_kugou.currentTime*100/currentSongInfoModel_kugou.durationTime)
                }else{
 
                }
            }
        })
    }
    
    
    
    //主线程更新UI(播放／暂停 按钮)
    func updateButtonStatus(){
        DispatchQueue.main.async(execute: {
            if audio.state == .stopped{
                self.tabBarView.playButton.isSelected = false
                self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_play_normal"), for: .normal)
                self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_play_disable"), for: .disabled)
                self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_play_highlight"), for: .highlighted)
            }else{
                if audio.state == .playing{
                    self.tabBarView.playButton.isSelected = true
                    self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_pause_normal"), for: .normal)
                    self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_pause_disable"), for: .disabled)
                    self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_pause_highlight"), for: .highlighted)
                }else{
                    self.tabBarView.playButton.isSelected = false
                    self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_play_normal"), for: .normal)
                    self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_play_disable"), for: .disabled)
                    self.tabBarView.playButton.setImage(UIImage(named: "miniplayer_btn_play_highlight"), for: .highlighted)
                }
            }
        })
    }
    //主线程更新UI(歌曲信息)
    func currentSongInfo(){
        let imgUrl = currentSongInfoModel_kugou.imgUrl
        let isCached = currentSongInfoModel_kugou.isCached
        let songname = currentSongInfoModel_kugou.songname
        let othername = currentSongInfoModel_kugou.othername
        let singername = currentSongInfoModel_kugou.singername
        let url = URL(string: imgUrl)
        
        let defaultImage = UIImage(named: "音乐_播放器_默认唱片头像")
        let currentImage = self.tabBarView.smallImage
        let songNameLabel = self.tabBarView.songNameLabel
        let authorLabel = self.tabBarView.authorLabel
        
        songNameLabel?.text = songname + othername
        authorLabel?.text = singername
        
        UIView.transition(with: currentImage!, duration: 1, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            
            DispatchQueue.main.async(execute: {
                print("看看imgUrl---------\(imgUrl)")
                    //缩略圆图
                    if url != nil{
                        if isCached == true{
                            let cacheImage = currentSongInfoModel_kugou.getCacheImage(url: url!)
                            currentImage?.image = cacheImage
                        }else{
                            currentImage?.sd_setImage(with: url)
                        }
                    }else{
                        currentImage?.image = defaultImage
                    }
            })
        }, completion: { (true) in
            
        })
    }
    
    //获取锁屏播放图片对象
    func getAlbumArt() -> MPMediaItemArtwork{
        let imgUrl = currentSongInfoModel_kugou.imgUrl
        let isCached = currentSongInfoModel_kugou.isCached
        let url = URL(string: imgUrl)
        var albumArt:MPMediaItemArtwork!
        var image:UIImage!
        //封面
        let defaultImage = UIImage(named: "音乐_播放器_默认唱片头像")
        if url != nil{
            if isCached == true{
                image = currentSongInfoModel_kugou.getCacheImage(url: url!)
            }else{
                do{
                    let imageData = try Data(contentsOf: url!)
                    image = UIImage.sd_image(with: imageData)
                }catch{
                    image = defaultImage
                }
            }
        }else{
            image = defaultImage
        }
        let waterMarkedImage = image.waterMarkedImage(waterMarkText: LrcProcessModel.currentLrcStr, corner: .BottomLeft, margin: CGPoint(x: 20, y: 20), waterMarkTextColor: MainColor, waterMarkTextFont: UIFont.systemFont(ofSize: 14), backgroundColor: UIColor.clear)
        albumArt = MPMediaItemArtwork(image: waterMarkedImage)
        return albumArt
    }
    
    
    
    //设置锁屏播放 歌曲信息
    func lockScreenPlayingSongInfo(){
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            //歌手／歌曲名／封面    
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyArtist: currentSongInfoModel_kugou.singername, MPMediaItemPropertyArtwork: getAlbumArt(), MPMediaItemPropertyTitle: currentSongInfoModel_kugou.songname,  MPMediaItemPropertyAlbumTitle: currentSongInfoModel_kugou.album_name, MPNowPlayingInfoPropertyElapsedPlaybackTime:audio.progress, MPMediaItemPropertyPlaybackDuration:audio.duration, MPNowPlayingInfoPropertyPlaybackRate:1.0]
        }
    }

}
