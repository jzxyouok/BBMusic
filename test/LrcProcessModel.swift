//
//  LrcProcessModel.swift
//  test
//
//  Created by bb on 2017/5/15.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class LrcProcessModel: NSObject {
    
    
    static var currentLrcStr:String = ""
    static var currentkey:TimeInterval = 0
    static var lastLrcStr:String = ""
    static var lastkey:TimeInterval = 0
    static var seconds:TimeInterval = 0
    static var lrcRowNumber:Int = 0
    
    static var number = "0123456789"
    static var time2LRC = [TimeInterval: String]()
    static var lrcTimeArray = [TimeInterval]()
    // 因为想要实现只有在时间变化到一行歌词开始的时间才进行一次位置的更新，其他时间不更新
    // 需要一个bool标记是否应该更新位置
    static var isTimeToChangeScrollView = false
    // 还需要一个temp来记录当前行歌词的时间，让其与下一行歌词时间对比
    static var tempLRCTime:TimeInterval = 0
    
    class func getLRCContent(){
        
        if !time2LRC.isEmpty{
            time2LRC.removeAll()
        }
        
        // 将歌词中的每行字符串截取出来放入数组
        var tempArrayOfLRC = LrcModel.lrcText.components(separatedBy: "\n")
        // 去掉完全没有内容的空行，数组中每个元素的内容将为“[时间]歌词”
        tempArrayOfLRC = tempArrayOfLRC.filter { $0 != "" }
        
        // 将歌词以对应的时间为Key放入字典
        for j in 0 ..< tempArrayOfLRC.count {
            // 用“]”分割字符串，可能含有多个时间对应个一句歌词的现象,并且歌词可能为空,例如：“[00:12.34][01:56.78]”，这样分割后的数组为：["[00:12.34", "[01:56.78", ""]
            var arrContentLRC = tempArrayOfLRC[j].components(separatedBy: "]")
            
            // 这里处理非歌词行，例如"[ti:","[ar:"，判断数组中每个元素的第二个字符是不是数字,如果是数字，则这一行是要显示的歌词，进入循环
            // number:定义的字符串“0123456789”，辅助判断字符是否为数字
            if(number.components(separatedBy: (arrContentLRC[0] as NSString).substring(with: NSMakeRange(1, 1))).count > 1) {
                // 最后一个元素是歌词，不用处理
                // 如果有多个时间对应一个歌词，每个时间处理一次
                for k in 0..<(arrContentLRC.count - 1) {
                    // 将元素内容中的“[”去掉
                    if arrContentLRC[k].contains("["){
                        arrContentLRC[k] = (arrContentLRC[k] as NSString).substring(from: 1)
                    }
                    
                    // 将时间和歌词对应地放入字典
                    //calculatString2Time: 编写的将字符串转化为时间的函数
                    func calculatString2Time(strTime: NSString) -> TimeInterval {
                        var arrTime = strTime.components(separatedBy: ":")
                        let numberTime = (arrTime[0] as NSString).doubleValue * 60 + (arrTime[1] as NSString).doubleValue
                        return numberTime
                    }
                    time2LRC[calculatString2Time(strTime: arrContentLRC[k] as NSString)] = arrContentLRC[arrContentLRC.count - 1]
                }
            }
        }
        if !lrcTimeArray.isEmpty{
            lrcTimeArray.removeAll()
        }
        // 因为字典是无序的，所以要用到sort
        for key in time2LRC.keys.sorted() {
            // 将时间添加到数组lrcTimeArray
            lrcTimeArray.append(key)
        }
    }
    
    

    
    class func updateLRCContent() {
        if lrcTimeArray.isEmpty {
            return
        }
        
        switch currentSongInfoModel_kugou.currentTime {
        case 0..<lrcTimeArray[0]:
            // 不更新位置
            isTimeToChangeScrollView = true
            return
        case lrcTimeArray[0]..<currentSongInfoModel_kugou.durationTime:
            // 判断是否是第一次 到达歌词的时间（小于 当前时间 的歌词时间）
            if tempLRCTime != maxElementOfLRCTime()! {
                tempLRCTime = maxElementOfLRCTime()!
                isTimeToChangeScrollView = true
            } else {
                isTimeToChangeScrollView = false
            }
            
            // 更新到当前歌词的位置
            if isTimeToChangeScrollView {
                // ScrollView滚动到歌词Label的中心位置
                let lrcRowNumber = lrcTimeArray.index(of: tempLRCTime)!
                //获取当天播放的歌词 段
                currentkey = time2LRC.keys.sorted()[lrcRowNumber]
                LrcProcessModel.lrcRowNumber = lrcRowNumber
                LrcProcessModel.currentLrcStr = time2LRC[currentkey]!
                if lrcRowNumber > 0{
                    let lastkey = time2LRC.keys.sorted()[lrcRowNumber - 1]
                    lastLrcStr = time2LRC[lastkey]!
                }
                //时间差
                seconds = currentkey - lastkey
                //发送当前播放歌词 段 通知
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "currentLrcStr"), object: nil)
            }
        default:
            // 不更新位置
            return
        }
    }

    
    
    
    // 判断歌曲时间所属于的歌词时间段(寻找时间数组中小于当前时间的最大值)
    class func maxElementOfLRCTime() -> TimeInterval! {
        return lrcTimeArray.filter { $0 <= currentSongInfoModel_kugou.currentTime }.max()
    }

}
