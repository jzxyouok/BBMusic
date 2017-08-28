//
//  HomeViewController.swift
//  test
//
//  Created by bb on 2017/3/16.
//  Copyright © 2017年 bb. All rights reserved.
//



import UIKit

class HomeViewController: UIViewController {
    
    let fontSize:CGFloat = WIN_WIDTH < 375 ? 16 : 17
 
    var mainScrollview: MainScrollview!
    var navigationView: UIView!
    var commentView: UIView!
    var searchBarView: UIView!
    var searchBar: UISearchBar!
    var navigationTitleView: NavigationTitleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.automaticallyAdjustsScrollViewInsets = false
        let backBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBtn
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.setBackgroundImage(imageMainColor, for: .any, barMetrics: .default)
        self.navBarTintColor = UIColor.white
        
        //
        let frame = CGRect(x: 0, y: 38 + 64, width: WIN_WIDTH, height: WIN_HEIGHT - 60 - 64)
        self.commentView = UIView()
        self.commentView.frame = frame
        self.commentView.isUserInteractionEnabled = false

        //
        self.mainScrollview = MainScrollview()
        self.mainScrollview.frame = frame
        self.mainScrollview.contentSize = CGSize(width: self.view.frame.width * 3, height: 0)
        self.mainScrollview.isPagingEnabled = true
        self.mainScrollview.bounces = false
        self.mainScrollview.backgroundColor = UIColor.green
        self.mainScrollview.delegate = self
        for (index,value) in setChildVcs().enumerated(){
            value.view.frame.origin.x = self.view.frame.width * CGFloat(index)
            self.addChildViewController(value)
            self.mainScrollview.addSubview(value.view)
        }
        self.view.addSubview(self.mainScrollview)
        
        configureSearchController()
        
    }
    
    //切换子控制器
    func switchChildViewController(controller: UIViewController){
        removeChildViewController()
        self.addChildViewController(controller)
        self.view.addSubview(self.commentView)
        self.commentView.addSubview(controller.view)
    }
    
    //移除所有的子控制器／子控制器view
    func removeChildViewController(){
        for i in self.commentView.subviews{
            i.removeFromSuperview()
        }
        self.commentView.removeFromSuperview()
    }
    


    //设置搜索栏 
    func configureSearchController(){
        //
        self.navigationView = UIView(frame: CGRect(x: 0, y: 0, width: WIN_WIDTH, height: 38 + 64))
        self.navigationView.backgroundColor = MainColor
        self.view.addSubview(self.navigationView)

        
        //silder
        NavigationTitleViewModel.titleArray = ["我的","音乐馆","发现"]
        self.navigationTitleView = NavigationTitleView.init(frame: CGRect(x: 0, y: 20, width: WIN_WIDTH, height: 44))
        self.navigationTitleView.delegate = self
        self.navigationTitleView.fontSize = fontSize
        self.navigationView.addSubview(navigationTitleView)
        
        
        self.searchBar = UISearchBar()
        self.searchBar.frame = CGRect(x: 0, y: 64, width: WIN_WIDTH, height: 38)
        self.searchBar.delegate = self
        self.searchBar.tintColor = UIColor.white
        self.searchBar.placeholder = "少年！来一首？"
        self.searchBar.setValue("取消", forKey: "_cancelButtonText")
        self.searchBar.setImage(UIImage(named: "icon-search"), for: .search, state: .normal)
        self.searchBar.setImage(UIImage(named: "icon-search"), for: .search, state: .highlighted)
        self.searchBar.setImage(UIImage(named: "mymusic_search_clear"), for: .clear, state: .normal)
        self.searchBar.setImage(UIImage(named: "mymusic_search_clear"), for: .clear, state: .highlighted)
        //背景颜色
        self.searchBar.setBackgroundImage(creatImageWithColor(color: MainColor), for: .any, barMetrics: .default)
        //文本输入框
        let textField = self.searchBar.value(forKey: "searchField") as! UITextField
        textField.backgroundColor = UIColor.init(red: 43/255, green: 170/255, blue: 109/255, alpha: 1)
        textField.textColor = UIColor.white
        //提示文本
        let placeholderLabel = textField.value(forKey: "_placeholderLabel") as! UILabel
        placeholderLabel.textColor = UIColor.white
        self.navigationView.addSubview(self.searchBar)

        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.searchByKeywordAction), name: NSNotification.Name(rawValue: "searchByRealTimeKeyword"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.openViewControllers), name: NSNotification.Name(rawValue: "leftViewCellClick"), object: nil)
    }
    

    
    //1. 设置子控制器,类似
    func setChildVcs() -> [UIViewController] {
        let vc1 = MyPageViewController()
        vc1.title = "我的"
        let vc2 = SVideoViewController()
        vc2.title = "音乐馆"
        let vc3 = vc03()
        vc3.view.backgroundColor = UIColor.red
        vc3.title = "发现"
        return [vc1, vc2, vc3]
    }
    

    //打开不同的侧滑面板控制器
    func openViewControllers(notification: Notification){
        let index = notification.object as! Int
        switch index {
        case 1:
            print(" 定时关闭")
            self.navigationController?.pushViewController(TimerPowerOffViewController(), animated: false)
            break
        case 2:
            print("免费流量")
            showProgressHUD(title: "马上更新，敬请期待～")
            break
        case 3:
            print("传个到手机")
            showProgressHUD(title: "马上更新，敬请期待～")
            break
        case 4:
            print("车载")
            showProgressHUD(title: "马上更新，敬请期待～")
            break
        case 5:
            print("清理空间")
            self.navigationController?.pushViewController(CleanCacheViewController(), animated: false)
            break
        case 6:
            print("帮助")
            showProgressHUD(title: "马上更新，敬请期待～")
            break
        case 7:
            print("关于")
            self.navigationController?.pushViewController(AboutBBMusicViewController(), animated: false)
            break
        default:
            break
        }
        
    }

    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


