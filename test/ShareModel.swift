//
//  ShareModel.swift
//  test
//
//  Created by bb on 17/3/26.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class ShareModel: NSObject {
    
    static var byAppId:String = "wx00ece81a497dccec"
    static var appSecret:String = "08f4f65292c5ef0e4c104503746ad5b1"
    
    
    //初始化shareSDK
    class func initMOBShareSDK(byAppId:String, appSecret:String){
        ShareSDK.registerApp("bbMusic", activePlatforms:[SSDKPlatformType.typeWechat.rawValue],
                             onImport: { (platform : SSDKPlatformType) in
                                switch platform{
                                case SSDKPlatformType.typeWechat:
                                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                                    break
                                default:
                                    break
                                }
        }) { (platform : SSDKPlatformType, appInfo : NSMutableDictionary?) in
            switch platform {
            case SSDKPlatformType.typeWechat:
                //设置微信应用信息
                appInfo?.ssdkSetupWeChat(byAppId: byAppId, appSecret: appSecret)
                break
            default:
                break
            }
            
        }
    }
    
    
    
    //1.分享至微信好友
    class func shareTo(type: SSDKPlatformType){
        
        // 1.创建分享参数
        let author = currentSongInfoModel_kugou.singername
        let songName = currentSongInfoModel_kugou.songname
        let imgUrl = currentSongInfoModel_kugou.imgUrl
        var image:UIImage!
        do{
            let data = try Data(contentsOf: (URL(string: imgUrl))!)
            image = UIImage(data: data)
        }catch{
            print("图片路径错误")
            image = UIImage(named: "demo6")
        }
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: author, images: image, url: URL(string:"\(currentSongInfoModel_kugou.url)"), title : songName, type : SSDKContentType.audio)
        
        //2.进行分享
        ShareSDK.share(type, parameters: shareParames) { (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
            switch state{
            case SSDKResponseState.success:
                print("分享成功")
            case SSDKResponseState.fail:
                //print("授权失败,错误描述:\(String(describing: error))")
                let msg = (error! as NSError).userInfo["error_message"]
                showProgressHUD(title: msg as! String)
            case SSDKResponseState.cancel:
                print("操作取消")
            default:
                break
            }
        }
        
    }
    

}
