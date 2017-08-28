//
//  ViewController.swift
//  test
//
//  Created by bb on 2017/1/10.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {

    var btnsView:UIView?
    
    var wallImageView:UIImageView?
    
    var blurView:UIVisualEffectView!
    
    var barBackgroundImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.navBarTintColor = UIColor.white

        //外层滑动scrollview
        let scrollView = scrollTableViews.init(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: WIN_HEIGHT))
        self.view.addSubview(scrollView)

        let one = vc1()
        self.addChildViewController(one)
        one.view.frame = CGRect(x:0, y:0, width:self.view.bounds.width, height:self.view.bounds.height)
        scrollView.scrollView?.addSubview(one.view)
        
        let two = vc2()
        self.addChildViewController(two)
        two.view.frame = CGRect(x:self.view.bounds.width, y:0, width:self.view.bounds.width, height:self.view.bounds.height)
        scrollView.scrollView?.addSubview(two.view)
        
        
        let three = vc3()
        self.addChildViewController(three)
        three.view.frame = CGRect(x:self.view.bounds.width*2, y:0, width:self.view.bounds.width, height:self.view.bounds.height)
        scrollView.scrollView?.addSubview(three.view)
        
        wallImageView = UIImageView(frame:CGRect(x:0, y:0, width:self.view.bounds.width, height:180))
        wallImageView?.image = UIImage(named: "rain")
        wallImageView?.isUserInteractionEnabled = true
        wallImageView?.contentMode = .scaleAspectFill
        wallImageView?.layer.masksToBounds = true
        self.view.addSubview(wallImageView!)
        
        //半透明遮罩
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame.size = (wallImageView?.frame.size)!
        self.view.addSubview(blurView)
        
        
        btnsView = buttonGroupView.init(frame: CGRect(x:0, y:160, width:self.view.bounds.width, height:44))
        btnsView?.backgroundColor = UIColor.white
        btnsView?.layer.borderWidth = 0.5
        btnsView?.layer.borderColor = SeparatorColor.cgColor
        btnsView?.layer.shadowColor = UIColor.lightGray.cgColor
        btnsView?.layer.shadowOffset = CGSize(width: self.view.bounds.width, height: 2)
        btnsView?.layer.shadowRadius = 2
        self.view.addSubview(btnsView!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.tableviewOffsetY), name: NSNotification.Name(rawValue: "tableview-offsetY"), object: nil)
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.isEqual(scrollView){
//            let offsetX = scrollView.contentOffset.x
//            switch offsetX {
//            case WIN_WIDTH*0:
//                print("0")
//                swithcButtonSelected(index: 0)
//                break
//            case WIN_WIDTH*1:
//                print("1")
//                swithcButtonSelected(index: 1)
//                break
//            case WIN_WIDTH*2:
//                print("2")
//                swithcButtonSelected(index: 2)
//                break
//            default:
//                break
//            }
//        }
//    }
//    
//    
//    func swithcButtonSelected(index:Int){
//        for button in detailViewControllerModel.buttonArray{
//            if detailViewControllerModel.buttonArray[index] == button{
//                detailViewControllerModel.buttonArray[index].isSelected = true
//            }else{
//                button.isSelected = false
//            }
//        }
//    }
    
    
    func tableviewOffsetY(userInfo:NSNotification){
        let offsetY = userInfo.userInfo?["offsetY"] as! CGFloat
        if (160.0 - offsetY) >= 64.0{
            btnsView?.frame.origin.y = CGFloat(160.0 - offsetY)
            var alpha = offsetY/64
            if alpha > 1{
                alpha = 1
            }else if alpha < 0{
                alpha = 0
            }
        }else{
            btnsView?.frame.origin.y = 64.0
        }
        //上
        if offsetY > 0{
            if offsetY <= 160 - 64{
                wallImageView?.frame.origin.y = -offsetY
                blurView.frame.origin.y = -offsetY
            }
        }else{//下
            wallImageView?.center.x = self.view.center.x
            wallImageView?.frame = CGRect(x: offsetY/2, y: 0, width: WIN_WIDTH - offsetY, height: 180 - offsetY)
            blurView.frame = CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 180 - offsetY)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        drawerController.openDrawerGestureModeMask = .init(rawValue: 0)
        drawerController.closeDrawerGestureModeMask = .init(rawValue: 0)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        drawerController.openDrawerGestureModeMask = .all
        drawerController.closeDrawerGestureModeMask = .all
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

