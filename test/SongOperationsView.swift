//
//  OptionView.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol SongOperationsViewDelegate {
    func songOperationsAction(button:UIButton)
}

class SongOperationsView: UIView {

    var delegate:SongOperationsViewDelegate?
    var button:UIButton!
    var lastButton:UIButton?
    
    var operationButtonArray = playerViewModel.operationButtonArray

    override init(frame: CGRect) {
        super.init(frame: frame)

        let count = CGFloat(operationButtonArray.count)
        for (index,_) in operationButtonArray.enumerated(){
            
            button = UIButton()
            button.addTarget(self, action: #selector(SongOperationsView.currentSongOperations), for: .touchUpInside)
            button.tag = index
            button.contentMode = .scaleAspectFill
            button.contentEdgeInsets = UIEdgeInsets.zero
            self.addSubview(button)
            switch index {
            case 0:
                button.setImage(UIImage(named:"player_btn_favorite_disable"), for: .disabled)
                button.setImage(UIImage(named:"player_btn_favorite_normal"), for: .normal)
                button.setImage(UIImage(named:"player_btn_favorite_highlight"), for: .highlighted)
                button.snp.makeConstraints({ (make) in
                    make.left.equalTo(self).offset(20)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                    make.width.equalTo((WIN_WIDTH - 40)/count)
                })
                break
            case 1:
                button.setImage(UIImage(named:"player_btn_download_disable"), for: .disabled)
                button.setImage(UIImage(named:"player_btn_download_normal"), for: .normal)
                button.setImage(UIImage(named:"player_btn_download_highlight"), for: .highlighted)
                button.snp.makeConstraints({ (make) in
                    make.left.equalTo((lastButton?.snp.right)!)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                    make.width.equalTo(lastButton!)
                })
                break
            case 2:
                button.setImage(UIImage(named:"player_btn_share_disable"), for: .disabled)
                button.setImage(UIImage(named:"player_btn_share_normal"), for: .normal)
                button.setImage(UIImage(named:"player_btn_share_highlight"), for: .highlighted)
                button.snp.makeConstraints({ (make) in
                    make.left.equalTo((lastButton?.snp.right)!)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                    make.width.equalTo(lastButton!)
                })
                break
            case 3:
                button.setImage(UIImage(named:"player_btn_comment_1_disable"), for: .disabled)
                button.setImage(UIImage(named:"player_btn_comment_1_normal"), for: .normal)
                button.setImage(UIImage(named:"player_btn_comment_1_highlight"), for: .highlighted)
                button.snp.makeConstraints({ (make) in
                    make.left.equalTo((lastButton?.snp.right)!)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                    make.width.equalTo(lastButton!)
                })
                break
            default:
                break
            }
            lastButton = button
        }
        
    }
    
    
    // 收藏／下载／分享／评论
    func currentSongOperations(_ button: UIButton){
       
       self.delegate?.songOperationsAction(button: button)
        
    }
    
    

    
    
    
    func share(){
    
        // 1.创建分享参数
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: "\(currentSongInfoModel_kugou.singername)",
                                          images : UIImage(named: "appIcon.png"),
                                          url : URL(string:currentSongInfoModel_kugou.url),
                                          title : "\(currentSongInfoModel_kugou.songname)",
                                          type : SSDKContentType.auto)
        
        
        
        //2.进行分享
        ShareSDK.share(SSDKPlatformType.typeWechat, parameters: shareParames) { (state : SSDKResponseState, nil, entity : SSDKContentEntity?, error :Error?) in
        
            switch state{
        
            case SSDKResponseState.success: print("分享成功")
            case SSDKResponseState.fail:    print("授权失败,错误描述:\(String(describing: error))")
            case SSDKResponseState.cancel:  print("操作取消")
                
            default:
                break
            }
            
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
