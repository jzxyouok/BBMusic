//
//  MyPageHeaderView.swift
//  test
//
//  Created by bb on 2017/4/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class MyPageHeaderView: UIView {
    
    var myPageUserView:MyPageUserView!
    var myPageButtonView:MyPageButtonView!

    override init(frame:CGRect){
        super.init(frame: frame)
        
        myPageUserView = MyPageUserView(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 110))
        self.addSubview(myPageUserView)
        
        myPageButtonView = MyPageButtonView(frame: CGRect(x: 0, y: 110, width: WIN_WIDTH, height: 3*WIN_WIDTH/16 + 30 + 10))
        self.addSubview(myPageButtonView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
