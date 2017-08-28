//
//  TabBarViewModel.swift
//  test
//
//  Created by bb on 2017/1/11.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SDWebImage

let currentSongInfoModel_kugou = CurrentSongInfoModel_kugou()

class CurrentSongInfoModel_kugou: NSObject {
    
    //文件缓冲进度
    var cacheProgress:Float = 0.0
    //是否正在播放
    var isplaying:Bool = false
    //当前播放进度
    var currentTime:Double = 0
    //时长
    var durationTime:Double  = 0
    
    //当前播放歌曲索引
    var currentSongIndex:Int = 0
    
    var singername:String = ""

    var songname:String = ""
    
    var othername:String = ""
    
    var album_name:String = ""
    
    var songhash:String = ""
    
    var imgUrl:String = ""
    
    var url:String = ""
    
    var error:String = ""
    
    var topic_url:String = ""
    
    //文件格式 mp3/aac
    var extName:String = ""

    //字典（其他mp3资源）
    var extra = Dictionary<String, Any>()
    
    var isCached:Bool = false
    
    //获取已缓存的图片
    func getCacheImage(url:URL) -> UIImage{
        let manager = SDWebImageManager.shared()
        let key = manager.cacheKey(for: url)
        let cache = SDImageCache.shared()
        let cacheImage = cache.imageFromDiskCache(forKey: key)
        return (cacheImage != nil ? cacheImage : UIImage(named: "音乐_播放器_默认唱片头像"))!
    }
    
    
    
    //初始化当前播放歌曲数据(本地／网络)
    func initCurrentSongInfoData(array: [SongListModel1], index: Int){
        if index > array.count - 1{
           currentSongInfoModel_kugou.currentSongIndex = 0
        }else{
            currentSongInfoModel_kugou.currentSongIndex = index
        }
        let i = currentSongInfoModel_kugou.currentSongIndex
        currentSongInfoModel_kugou.songhash = array[i].songhash
        currentSongInfoModel_kugou.songname = array[i].songname
        currentSongInfoModel_kugou.othername = array[i].othername
        currentSongInfoModel_kugou.singername = array[i].singername
        currentSongInfoModel_kugou.album_name = array[i].album_name
        LrcModel.duration = array[i].duration*1000
        let dic = CheckCache.isCached(hash: currentSongInfoModel_kugou.songhash)
        currentSongInfoModel_kugou.isCached = dic["isCached"] as! Bool
        //检测是否已缓存过
        if currentSongInfoModel_kugou.isCached == true{
            //("该歌曲已经缓存过了，可以直接播放本地资源")
            currentSongInfoModel_kugou.url = dic["songFilePath"] as! String
            currentSongInfoModel_kugou.imgUrl = array[i].imgUrl
            currentSongInfoModel_kugou.cacheProgress = 1.0
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "SongHashSearchDone"), object: nil)
            
        }else{
            //print("该歌曲尚未缓存，正在请求网络资源")
            currentSongInfoModel_kugou.cacheProgress = 0
            Kugou_SongHashSearch_Http.songHashSearchRequest(hash: currentSongInfoModel_kugou.songhash)
        }
    }
    

}
