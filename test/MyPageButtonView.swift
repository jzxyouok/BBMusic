//
//  RegisterFormView.swift
//  test
//
//  Created by bb on 2017/2/24.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

protocol MyPageButtonViewDelegate {
    func MyPageButtonViewButtonAction(button:UIButton)
}

class MyPageButtonView: UIView {

    var button:UIButton!
    var delegate:MyPageButtonViewDelegate?
    
    var itemArray  = [String]()
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        itemArray = ["我喜欢", "全部歌曲", "已购音乐", "最近播放"]

        self.backgroundColor = UIColor.white
        for (index,value) in itemArray.enumerated(){
            button = UIImageButton()
            button.tag = index
            button.addTarget(self, action: #selector(MyPageButtonView.buttonAction), for: .touchUpInside)
            if index < 4{
                button.frame = CGRect(x: self.frame.size.width/4 * CGFloat(index), y: 0, width: self.frame.size.width/4, height: self.frame.size.height)
                button.setTitle(value, for: .normal)
                button.setTitleColor(TitleColor, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                switch index {
                case 0:
                    button.setImage(UIImage(named: "mymusic_icon_favorite_normal"), for: .normal)
                    button.setImage(UIImage(named: "mymusic_icon_favorite_highlight"), for: .highlighted)
                    break
                case 1:
                    button.setImage(UIImage(named: "mymusic_icon_allsongs_normal"), for: .normal)
                    button.setImage(UIImage(named: "mymusic_icon_allsongs_highlight"), for: .highlighted)
                    break
                case 2:
                    button.setImage(UIImage(named: "mymusic_icon_paidmusic_normal"), for: .normal)
                    button.setImage(UIImage(named: "mymusic_icon_paidmusic_highlight"), for: .highlighted)
                    break
                case 3:
                    button.setImage(UIImage(named: "mymusic_icon_history_normal"), for: .normal)
                    button.setImage(UIImage(named: "mymusic_icon_history_highlight"), for: .highlighted)
                    break
                default:
                    break
                }
                self.addSubview(button)
            }
            
            
        }
        
    }
    
    //点击按钮 代理
    func buttonAction(button:UIButton){
        self.delegate?.MyPageButtonViewButtonAction(button: button)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}
