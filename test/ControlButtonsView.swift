//
//  ControlView.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class ControlButtonsView: UIView {

    var controlButton:UIButton!
    
    var playModel:UIButton!
    var playList:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //播放控制按钮
        for i in 0...2{
            controlButton = UIButton()
            controlButton.addTarget(self, action: #selector(ControlButtonsView.playControl), for: .touchUpInside)
            //controlButton.backgroundColor = UIColor.green
            self.addSubview(controlButton)
            //分别为上一首／播放／下一首注册事件
            switch i {
            case 0:
                controlButton.tag = 1110
                controlButton.setImage(UIImage(named: "player_btn_pre_normal"), for: .normal)
                controlButton.setImage(UIImage(named: "player_btn_pre_highlight"), for: .highlighted)
                controlButton.snp.makeConstraints { (make) in
                    make.top.equalTo(self)
                    make.height.equalTo(self.snp.height)
                    make.width.equalTo(self.snp.height)
                    make.centerX.equalTo(self.snp.centerX).offset(-90)
                }
            case 1:
                controlButton.tag = 1111
                controlButton.setImage(UIImage(named: "player_btn_play_normal"), for: .normal)
                controlButton.setImage(UIImage(named: "player_btn_play_highlight"), for: .highlighted)
                controlButton.snp.makeConstraints { (make) in
                    make.top.equalTo(self)
                    make.height.equalTo(self.snp.height)
                    make.width.equalTo(self.snp.height)
                    make.centerX.equalTo(self.snp.centerX)
                }
            default:
                controlButton.tag = 1112
                controlButton.setImage(UIImage(named: "player_btn_next_normal"), for: .normal)
                controlButton.setImage(UIImage(named: "player_btn_next_highlight"), for: .highlighted)
                controlButton.snp.makeConstraints { (make) in
                    make.top.equalTo(self)
                    make.height.equalTo(self.snp.height)
                    make.width.equalTo(self.snp.height)
                    make.centerX.equalTo(self.snp.centerX).offset(90)
                }
            }
            
        }
        
        
        playModel = UIButton(type: .system)
        playModel.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
        self.addSubview(playModel)
        playModel.tag = 1113
        let index = APPSetting.getPlayModel
        switch index {
        case 0:
            playModel.setImage(UIImage(named: "miniplayer_btn_repeat_normal"), for: .normal)
            playModel.setImage(UIImage(named: "miniplayer_btn_repeat_highlight"), for: .highlighted)
            break
        case 1:
            playModel.setImage(UIImage(named: "miniplayer_btn_repeatone_normal"), for: .normal)
            playModel.setImage(UIImage(named: "miniplayer_btn_repeatone_highlight"), for: .highlighted)
            break
        case 2:
            playModel.setImage(UIImage(named: "miniplayer_btn_random_normal"), for: .normal)
            playModel.setImage(UIImage(named: "miniplayer_btn_random_highlight"), for: .highlighted)
            break
        default:
            playModel.setImage(UIImage(named: "miniplayer_btn_repeat_normal"), for: .normal)
            playModel.setImage(UIImage(named: "miniplayer_btn_repeat_highlight"), for: .highlighted)
            break
        }
        playModel.tintColor = UIColor.white
        playModel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.left.equalTo(10)
        }
        
        playList = UIButton(type: .system)
        playList.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -10)
        self.addSubview(playList)
        playList.tag = 1114
        playList.setImage(UIImage(named: "player_btn_playlist_normal"), for: .normal)
        playList.setImage(UIImage(named: "player_btn_playlist_highlight"), for: .highlighted)
        playList.tintColor = UIColor.white
        playList.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.right.equalTo(-10)
        }

    }
    
    
    func playControl(_ button: UIButton){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "controlByHUD"), object: nil, userInfo: ["tag":button.tag])
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
