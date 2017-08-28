//
//  buttonGroupView.swift
//  test
//
//  Created by bb on 2017/1/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class buttonGroupView: UIView {
    
    var titleArray = [String]()

    var button:UIButton?

    var buttonArray = [UIButton]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleArray = detailViewControllerModel.titleArray
        
        if detailViewControllerModel.buttonArray.count != 0{
            detailViewControllerModel.buttonArray.removeAll()
        }
        //循环创建按钮
        for (index,value) in titleArray.enumerated(){
            button = UIButton()
            detailViewControllerModel.buttonArray.append(button!)
            buttonArray = detailViewControllerModel.buttonArray
            button?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button?.tag = index
            button?.addTarget(self, action: #selector(buttonGroupView.buttonAction), for: .touchUpInside)
            switch index {
            case 0:
                button?.frame = CGRect(x: 0, y: 0, width: WIN_WIDTH/3, height: self.bounds.height)
                button?.setTitle(value, for: .normal)
                button?.setTitleColor(UIColor.darkGray, for: .normal)
                button?.setTitleColor(MainColor, for: .selected)
                button?.isSelected = true
                break
            case 1:
                button?.frame = CGRect(x: WIN_WIDTH/3, y: 0, width: WIN_WIDTH/3, height: self.bounds.height)
                button?.setTitle(value, for: .normal)
                button?.setTitleColor(UIColor.darkGray, for: .normal)
                button?.setTitleColor(MainColor, for: .selected)
                button?.isSelected = false
                break
            case 2:
                button?.frame = CGRect(x: WIN_WIDTH/3*2, y: 0, width: WIN_WIDTH/3, height: self.bounds.height)
                button?.setTitle(value, for: .normal)
                button?.setTitleColor(UIColor.darkGray, for: .normal)
                button?.setTitleColor(MainColor, for: .selected)
                button?.isSelected = false
                break
            default:
                break
            }
            self.addSubview(button!)
        }
    }
    
    
    //点击切换选中状态
    func buttonAction(sender:UIButton){
        for button in buttonArray{
            if sender == button{
                sender.isSelected = true
            }else{
                button.isSelected = false
            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
