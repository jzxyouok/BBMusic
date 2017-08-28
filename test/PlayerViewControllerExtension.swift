//
//  PlayerViewControllerExtension.swift
//  test
//
//  Created by bb on 2017/5/13.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit


extension PlayerViewController {
    
    //切换播放模式 ／ 打开播放列表
    func playerButtonAction(button: UIButton){
        switch button.tag {
        case 1113:
            APPSetting.switchPlayModel()
            let index = APPSetting.getPlayModel
            let playModel = bottomView.controlButtonsView.playModel
            switch index {
            case 0:
                playModel?.setImage(UIImage(named: "miniplayer_btn_repeat_normal"), for: .normal)
                playModel?.setImage(UIImage(named: "miniplayer_btn_repeat_highlight"), for: .highlighted)
                break
            case 1:
                playModel?.setImage(UIImage(named: "miniplayer_btn_repeatone_normal"), for: .normal)
                playModel?.setImage(UIImage(named: "miniplayer_btn_repeatone_highlight"), for: .highlighted)
                break
            case 2:
                playModel?.setImage(UIImage(named: "miniplayer_btn_random_normal"), for: .normal)
                playModel?.setImage(UIImage(named: "miniplayer_btn_random_highlight"), for: .highlighted)
                break
            default:
                break
            }
            break
        case 1114:
            print("openPlayListView")
            break
        default:
            break
        }
    }

}

extension PlayerViewController: SongNameViewDelegate {
    
    //关闭播放页面
    func navigationButtonAction(button: UIButton) {
        switch button.tag {
        case 1004:
            self.playerScrollviewController.view.alpha = 0
            self.pageController.alpha = 0.1
            UIView.animate(withDuration: 0.2, animations: {
                self.songNameView.frame.origin.y = -64
                self.bottomView.frame.origin.y = WIN_HEIGHT
                
                self.songNameView.alpha = 0.1
                self.bottomView.alpha = 0.1
                self.backgroundView.alpha = 0.1
            }, completion: { (true) in
                self.dismiss(animated: false, completion: nil)
            })
            break
        case 1005:
            print("点击了更多")
            break
        default:
            break
        }
    }
}

extension PlayerViewController: SongOperationsViewDelegate {
    
    // 收藏／下载／分享／评论
    func songOperationsAction(button: UIButton) {
        switch button.tag {
        case 0:
            button.isSelected = !button.isSelected
            if button.isSelected == true{
                print("收藏成功")
                button.setImage(UIImage(named: "player_btn_favorited_normal"), for: .normal)
                button.setImage(UIImage(named: "player_btn_favorited_highlight"), for: .highlighted)
            }else{
                print("取消收藏")
                button.setImage(UIImage(named: "player_btn_favorite_normal"), for: .normal)
                button.setImage(UIImage(named: "player_btn_favorite_highlight"), for: .highlighted)
            }
            break
        case 1:
            print("download")
            break
        case 2:
            print("share")
            MOBShare()
            break
        case 3:
            print("comment")
            break
        default:
            break
        }
    }
    
    
    //分享ShareViewController
    func MOBShare(){
        let vc = ShareViewController()
        vc.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.present(vc, animated: false, completion: nil)
    }
    
}


extension PlayerViewController: PlayerScrollviewDegelate {
    
    // 歌曲信息／封面／歌词
    func playerScrollview(page: Int) {
        pageController.currentPage = page
    }
    
}
