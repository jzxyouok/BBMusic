//
//  PlayAction.swift
//  test
//
//  Created by bb on 2017/5/11.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class PlayAction: NSObject {
    
    
    //下一首歌曲
    class func Next(){
        if recentPlayListModelArray.count > 0{
            currentSongInfoModel_kugou.currentSongIndex += 1
            if currentSongInfoModel_kugou.currentSongIndex == recentPlayListModelArray.count{
                currentSongInfoModel_kugou.currentSongIndex = 0
            }
            let index = currentSongInfoModel_kugou.currentSongIndex
            //初始化当前播放歌曲数据(本地／网络)
            currentSongInfoModel_kugou.initCurrentSongInfoData(array: recentPlayListModelArray, index: index)
        }
    }
    
    
      //上一首歌曲
    class func Prev(){
        if recentPlayListModelArray.count > 0{
            currentSongInfoModel_kugou.currentSongIndex -= 1
            if currentSongInfoModel_kugou.currentSongIndex == -1{
                currentSongInfoModel_kugou.currentSongIndex = recentPlayListModelArray.count - 1
            }
            let index = currentSongInfoModel_kugou.currentSongIndex
            //初始化当前播放歌曲数据(本地／网络)
            currentSongInfoModel_kugou.initCurrentSongInfoData(array: recentPlayListModelArray, index: index)
        }
    }
    
    
    
    //播放／暂停
    class func Pause(){
        if audio.state == .paused {
            print("暂停")
            audio.resume()
        }else if audio.state == .playing {
            print("播放")
            audio.pause()
        }else{
            Play()
        }
    }
    
    
    
    //播放
    class func Play(){
        
        let url = currentSongInfoModel_kugou.url
        let isCached = currentSongInfoModel_kugou.isCached
        
        let imageUrl = currentSongInfoModel_kugou.imgUrl
        let songhash = currentSongInfoModel_kugou.songhash
        let songname = currentSongInfoModel_kugou.songname
        let othername = currentSongInfoModel_kugou.othername
        let singername = currentSongInfoModel_kugou.singername
        let album_name = currentSongInfoModel_kugou.album_name
        let error = currentSongInfoModel_kugou.error
        
        //播放地址不能为空
        guard url != "" || error != "需要付费" else{
            let alert = AlertController(title: "", message: "因版权方要求，试听歌曲“\(singername) - \(songname)”需要购买所属专辑《\(album_name)》", ok: "购买专辑", cancel: "取消", customAction: {
                print("我点击了购买专辑")
                let nvc = UINavigationController(rootViewController: PayForSongViewController())
                //self.present(nvc, animated: true, completion: nil)
                
            })
            //self.present(alert, animated: true, completion: nil)
            return
        }

        if url != ""{
            //新开线程 本地存储读／写操作，避免阻塞主线程
            DispatchQueue.global().async(execute: { 
                //更新本地保存的当前播放歌曲信息
                CurrentPlaySQLite.insert(hash: songhash, name: songname, other: othername, file_link: url, image: imageUrl, artist: singername, albums: album_name, cache: isCached)
                
                // 根据文件是否缓存，切换不同的播放路径
                if isCached == true {
                    let localUrl = URL(fileURLWithPath: url)
                    audio.play(localUrl)
                }else{
                    let networkUrl = URL(string: url)
                    audio.play(networkUrl!)
                }
                
                //插入最近播放记录
                RecentPlaySQLite.insert(hash: songhash, name: songname, other: othername, file_link: url, image: imageUrl, artist: singername, albums: album_name, cache: isCached)
                
                LrcModel.currentLrcRequest(keyword: songname)
            })
        }
    }

}
