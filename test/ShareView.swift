//
//  ShareView.swift
//  test
//
//  Created by bb on 2017/2/9.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

protocol ShareViewDelegate {
    func shareViewAction(button:UIButton)
}

class ShareView: UIView {
    
    
    let items1 = ["微信好友", "手机QQ", "QQ空间", "微信朋友圈", "新浪微博", "腾讯微博", "支付宝"]
    let items2 = ["短信", "邮件", "刷新", "复制链接"]
    var items = [String]()
    
    var delegate:ShareViewDelegate?
    var lastScrollView:UIScrollView?
    var lastButton1:UIButton?
    var lastButton2:UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        
        let closeButton = UIButton()
        closeButton.tag = 1006
        closeButton.setTitle("取消", for: .normal)
        closeButton.setTitleColor(UIColor.gray, for: .normal)
        let image_normal = creatImageWithColor(color: UIColor.white)
        let image_hightlight = creatImageWithColor(color: SeparatorColor)
        closeButton.setBackgroundImage(image_normal, for: .normal)
        closeButton.setBackgroundImage(image_hightlight, for: .highlighted)
        closeButton.addTarget(self, action: #selector(ShareView.shareViewAction), for: .touchUpInside)
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(44)
        }
        
        //创建上下两个scorllview
        for x in 0...1{
            //直线
            let line = DrawRectLine()
            self.addSubview(line)
            //scrollview
            let scrollview1 = UIScrollView()
            var contentSizeWidth1:CGFloat?
            scrollview1.showsVerticalScrollIndicator = false
            scrollview1.showsHorizontalScrollIndicator = false
            self.addSubview(scrollview1)
            if x == 0{
                scrollview1.snp.makeConstraints { (make) in
                    make.left.equalTo(self)
                    make.right.equalTo(self)
                    make.top.equalTo(self).offset((((WIN_HEIGHT/2 - 44 - 44)/2 - (WIN_WIDTH - 100)*2/9)/2))
                    make.height.equalTo((WIN_WIDTH - 100)*2/9 + 20)
                }
                line.snp.makeConstraints { (make) in
                    make.left.equalTo(self).offset(20)
                    make.top.equalTo(scrollview1.snp.bottom).offset(15)
                    make.right.equalTo(self).offset(-20)
                    make.height.equalTo(0.5)
                }
                items = items1
            }else{
                scrollview1.snp.makeConstraints { (make) in
                    make.left.equalTo(self)
                    make.right.equalTo(self)
                    make.top.equalTo((lastScrollView?.snp.bottom)!).offset((((WIN_HEIGHT/2 - 44 - 44)/2 - (WIN_WIDTH - 100)*2/9)/2))
                    make.height.equalTo((lastScrollView?.snp.height)!)
                }
                line.snp.makeConstraints { (make) in
                    make.left.equalTo(self)
                    make.bottom.equalTo(closeButton.snp.top)
                    make.right.equalTo(self)
                    make.height.equalTo(0.5)
                }
                items = items2
            }
            //根据item个数决定scrollview的contentsize宽度
            if items.count > 4 {
                contentSizeWidth1 = ((WIN_WIDTH - 100)*2/9 + 20)*CGFloat(items.count) + 20
            }else{
                contentSizeWidth1 = WIN_WIDTH + 1
            }
            scrollview1.contentSize = CGSize(width: contentSizeWidth1!, height: 0)
            
            //根据item个数创建button
            for (i, value) in items.enumerated(){
                let button = UIButton()
                let imageView = UIImageView()
                let textLabel = UILabel()
                //button.tag = Int("\(x)"+"\(i)")
                button.tag = Int(String(x)+String(i))!
                button.addTarget(self, action: #selector(ShareView.shareViewAction), for: .touchUpInside)
                scrollview1.addSubview(button)
                
                if i == 0 {
                    button.snp.makeConstraints({ (make) in
                        make.left.equalTo(scrollview1).offset(20)
                        make.width.equalTo((WIN_WIDTH - 100)*2/9)
                        make.height.equalTo((WIN_WIDTH - 100)*2/9 + 20)
                        make.top.equalTo(scrollview1)
                    })
                }else{
                    button.snp.makeConstraints({ (make) in
                        make.left.equalTo((lastButton2?.snp.right)!).offset(20)
                        make.width.equalTo((lastButton2?.snp.width)!)
                        make.height.equalTo((lastButton2?.snp.height)!)
                        make.top.equalTo((lastButton2?.snp.top)!)
                    })
                }
                lastButton2 = button
                scrollview1.addSubview(button)
                //item图片
                let image = scaleToSize(img: UIImage(named:"share\(i)")!, size: CGSize(width: 64, height: 64))
                imageView.image = image
                button.addSubview(imageView)
                imageView.snp.makeConstraints({ (make) in
                    make.left.equalTo(button)
                    make.right.equalTo(button)
                    make.top.equalTo(button)
                    make.height.equalTo(imageView.snp.width)
                })
                //item文字
                textLabel.text = "\(value)"
                textLabel.textAlignment = .center
                textLabel.font = UIFont.systemFont(ofSize: 10)
                textLabel.textColor = UIColor.gray
                button.addSubview(textLabel)
                textLabel.snp.makeConstraints({ (make) in
                    make.left.equalTo(button)
                    make.right.equalTo(button)
                    make.top.equalTo(imageView.snp.bottom)
                    make.bottom.equalTo(button)
                })
            }
            lastScrollView = scrollview1
         }
        
    }
    
    
    func shareViewAction(button:UIButton){
        self.delegate?.shareViewAction(button: button)
    }
    
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
