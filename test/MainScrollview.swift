//
//  MainScrollview.swift
//  test
//
//  Created by bb on 2017/6/8.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class MainScrollview: UIScrollView {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) {
            let pan:UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            if pan.translation(in: self).x > 0 && self.contentOffset.x == 0 {
                // 这里返回 NO
                return false
            }
        }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }
}
