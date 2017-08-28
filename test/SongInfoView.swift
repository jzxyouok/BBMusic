//
//  SongInfoView.swift
//  test
//
//  Created by bb on 2017/1/14.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class SongInfoView: UIView {

    var authorLabel:UILabel!
    
    var otherInfoView:UIView!
    

    override init(frame:CGRect){
        super.init(frame: frame)
        
        //author 歌手
        authorLabel = UILabel()
        //self.backgroundColor = UIColor.gray
        authorLabel.textColor = UIColor.white
        authorLabel.textAlignment = .center
        authorLabel.text = "— sunny day —"
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 0, 30, 0))
        }
        
        //标签组
        otherInfoView = UIView()
        //self.backgroundColor = UIColor.red
        self.addSubview(otherInfoView)
        otherInfoView.snp.makeConstraints { (make) in
            otherInfoView.snp.makeConstraints { (make) in
                make.top.equalTo(authorLabel.snp.bottom)
                make.height.equalTo(authorLabel.snp.height)
                make.width.equalTo(160)
                make.centerX.equalTo(authorLabel.snp.centerX)
            }
        }
        
        
        //标签mv/dts
        var lastButton:UIButton?
        for i in 0...2{
            let buttonType = UIButton()
            buttonType.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            buttonType.layer.cornerRadius = 3
            buttonType.layer.borderWidth = 1
            buttonType.addTarget(self, action: #selector(buttonTypeAction), for: .touchUpInside)
            otherInfoView.addSubview(buttonType)
            switch i {
            case 0:
                //buttonType.backgroundColor = UIColor.greenColor()
                buttonType.setTitle("MV", for: .normal)
                buttonType.setTitleColor(UIColor.init(red: 49/255, green: 194/255, blue: 124/255, alpha: 1), for: .normal)
                buttonType.layer.borderColor = UIColor.init(red: 49/255, green: 194/255, blue: 124/255, alpha: 1).cgColor
                buttonType.snp.makeConstraints { (make) in
                    make.top.equalTo(otherInfoView.snp.top).offset(5)
                    make.bottom.equalTo(otherInfoView.snp.bottom).offset(-5)
                    make.left.equalTo(otherInfoView.snp.left)
                    make.width.equalTo(50)
                }
            case 1:
                //buttonType.backgroundColor = UIColor.yellowColor()
                buttonType.setTitle("独家", for: .normal)
                buttonType.setTitleColor(UIColor.init(red: 49/255, green: 194/255, blue: 124/255, alpha: 1), for: .normal)
                buttonType.layer.borderColor = UIColor.init(red: 49/255, green: 194/255, blue: 124/255, alpha: 1).cgColor
                buttonType.snp.makeConstraints { (make) in
                    make.top.equalTo(otherInfoView.snp.top).offset(5)
                    make.bottom.equalTo(otherInfoView.snp.bottom).offset(-5)
                    make.left.equalTo(lastButton!.snp.right).offset(5)
                    make.width.equalTo(50)
                }
            default:
                //buttonType.backgroundColor = UIColor.greenColor()
                buttonType.setTitle("DTS", for: .normal)
                buttonType.setTitleColor(UIColor.init(red: 162/255, green: 153/255, blue: 169/255, alpha: 1), for: .normal)
                buttonType.layer.borderColor = UIColor.init(red: 162/255, green: 153/255, blue: 169/255, alpha: 1).cgColor
                buttonType.snp.makeConstraints { (make) in
                    make.top.equalTo(otherInfoView.snp.top).offset(5)
                    make.bottom.equalTo(otherInfoView.snp.bottom).offset(-5)
                    make.left.equalTo(lastButton!.snp.right).offset(5)
                    make.width.equalTo(50)
                }
            }
            lastButton = buttonType
        }

    }
    
    
    func buttonTypeAction(){
        print("bbbbbbbbbbbbbbb")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
