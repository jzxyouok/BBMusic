//
//  imageButton.swift
//  test
//
//  Created by bb on 2017/4/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class UIImageButton: UIButton {

 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {

        super.layoutSubviews()
    
        // Center image
        var center:CGPoint = self.imageView!.center
        center.x = self.frame.size.width/2
        center.y = (self.imageView?.frame.size.height)!
        self.imageView?.center = center
        
        //Center text
        var newFrame:CGRect = (self.titleLabel?.frame)!
        newFrame.origin.x = 0;
        newFrame.origin.y = (self.imageView?.frame.size.height)! + (self.titleLabel?.frame.height)! + 5
        newFrame.size.width = self.frame.size.width;
        
        self.titleLabel?.frame = newFrame
        self.titleLabel?.textAlignment = .center
    }

}
