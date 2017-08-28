//
//  test.swift
//  bbb
//
//  Created by bb on 16/9/5.
//  Copyright © 2016年 bb. All rights reserved.
//

import UIKit
import SnapKit

class HotSearchKeywordView: UIView {
    
    var rect: CGSize = CGSize(width: 0, height: 0)
    
    var insureTypeContainer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        //热搜uiview
        insureTypeContainer.frame = frame
        self.addSubview(insureTypeContainer)
        
        //获取当前设备名称
        let modelName = UIDevice.current.modelName
        
        //热门关键字 个数
        var maxNumber:Int = 0
        if modelName == "iPhone 4" || modelName == "iPhone 4s" || modelName == "iPhone 5" || modelName == "iPhone 5c" || modelName == "iPhone 5s"{
            maxNumber = 8
        }else{
            maxNumber = 9
        }
        
        //热搜uibutton
        var recordBtn:UIButton = UIButton()
        for i in 0...maxNumber{
            let btn = UIButton()
            if hotSearchKeywordModelArray.count != 0{
                if hotSearchKeywordModelArray[i].jumpurl != ""{
                    btn.isSelected = true
                }
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                let imageNormal = creatImageWithColor(color: UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1))
                btn.setBackgroundImage(imageNormal, for: .normal)
                btn.setBackgroundImage(imageMainColor, for: .highlighted)
                btn.setBackgroundImage(imageMainColor, for: .selected)
                btn.setTitleColor(UIColor.white, for: .highlighted)
                btn.setTitleColor(UIColor.darkGray, for: .normal)
                btn.setTitleColor(UIColor.white, for: .selected)
                btn.setTitle(hotSearchKeywordModelArray[i].keyword, for: .normal)
                btn.layer.cornerRadius = 13
                btn.layer.masksToBounds = true
                
                let myString = hotSearchKeywordModelArray[i].keyword as NSString
                rect = myString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)])
                
                rect.height = 26;
                rect.width += 20;
                
                
                if i == 0{
                    btn.frame = CGRect(x: 15, y: 0, width: rect.width, height: rect.height);
                }else{
                    let yuWidth = WIN_WIDTH - 20 - recordBtn.frame.origin.x - recordBtn.frame.size.width
                    if yuWidth >= rect.width{
                        btn.frame = CGRect(x: recordBtn.frame.origin.x + recordBtn.frame.size.width + 10, y: recordBtn.frame.origin.y, width: rect.width, height: rect.height)
                    }else{
                        btn.frame = CGRect(x: 15, y: recordBtn.frame.origin.y + recordBtn.frame.size.height+10, width: rect.width, height: rect.height)
                    }
                }
                
                insureTypeContainer.addSubview(btn)
                
                btn.tag = i
                recordBtn = btn
                btn.addTarget(self, action: #selector(hotKeywordButtonAction), for: .touchUpInside)
            }
            
        }
        SearchRecordModel.h = recordBtn.frame.origin.y + rect.height + 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //点击热门关键字 button
    func hotKeywordButtonAction(button: UIButton){
        let index = button.tag
        SearchKeywordModel.keyword = hotSearchKeywordModelArray[index].keyword
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchByRealTimeKeyword"), object: nil)
    }
    


}
