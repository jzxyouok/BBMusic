//
//  HomeViewControllerExtension.swift
//  test
//
//  Created by bb on 2017/3/16.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

//扩展
extension HomeViewController: UISearchBarDelegate{
    
    //将要开始编辑
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.commentView.isUserInteractionEnabled = true
        switchChildViewController(controller: SearchRecordViewController())
        return true
    }
    
    //开始编辑
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.placeholder = "搜索音乐、歌单、歌词"
        self.searchBar.setShowsCancelButton(true, animated: true)
        self.searchBar.showsBookmarkButton = true
        self.searchBar.setImage(UIImage(named: "search_microphone"), for: .bookmark, state: .normal)
        self.searchBar.setImage(UIImage(named: "search_microphone_pressed"), for: .bookmark, state: .highlighted)
        self.searchBar.setPositionAdjustment(UIOffset.zero, for: .bookmark)
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationTitleView.alpha = 0
            self.navigationView.frame.origin.y = -38
            self.commentView.frame.origin.y = 64
        }) { (true) in
            drawerController.openDrawerGestureModeMask = .init(rawValue: 0)
            drawerController.closeDrawerGestureModeMask = .init(rawValue: 0)
        }
    }
    
    //点击取消
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.commentView.isUserInteractionEnabled = false
        self.searchBar.text = ""
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationTitleView.alpha = 1
            self.navigationView.frame.origin.y = 0
            self.commentView.frame.origin.y = 38 + 64
            self.searchBar.setShowsCancelButton(false, animated: true)
            self.searchBar.resignFirstResponder()
        }) { (true) in
            self.removeChildViewController()
            drawerController.openDrawerGestureModeMask = .all
            drawerController.closeDrawerGestureModeMask = .all
        }
    }
    
    //将要结束编辑
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    //结束编辑
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.placeholder = "少年！来一首？"
        self.searchBar.showsBookmarkButton = false
        print("结束编辑")
    }
    
    //点击了return
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchByKeywordAction()
    }
    
    //内容实时改变
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchKeywordModel.keyword = searchText
        realTimeSearchModelArray.removeAll()
        if SearchKeywordModel.keyword != ""{
            switchChildViewController(controller: RealTimeSearchViewController())
        }else{
            switchChildViewController(controller: SearchRecordViewController())
        }
    }
    
    
    //根据实时关键字搜索
    func searchByKeywordAction(){
        self.searchBar.text = SearchKeywordModel.keyword
        self.searchBar.resignFirstResponder()
        if SearchKeywordModel.keyword != ""{
            switchChildViewController(controller: SearchResultViewController())
            searchRecordModel.currentKeyword = SearchKeywordModel.keyword
            searchRecordModel.addKeywordToArray()
        }
    }
    
}

//自定义标题 代理
extension HomeViewController: NavigationTitleViewDelegate{

    //自定义 导航栏 按钮事件
    func navigationTitleViewButtonAction(button: UIButton) {
        switch button.tag {
        case 1001:
            
            break
        case 1002:
            //self.navigationController?.pushViewController(DetailViewController(), animated: true)
            break
        case 1100:
            print("我的")
            self.mainScrollview.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            break
        case 1101:
            print("音乐馆")
            self.mainScrollview.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: false)
            break
        case 1102:
            print("发现")
            self.mainScrollview.setContentOffset(CGPoint(x: self.view.frame.width * 2, y: 0), animated: false)
            break
        default:
            break
        }
    }
    
}

//UINavigationViewController 代理方法
extension HomeViewController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: HomeViewController.self){
            navigationController.setNavigationBarHidden(true, animated: true)
        }else{
            navigationController.setNavigationBarHidden(false, animated: true)
        }
    }
    
}

extension HomeViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let myBtn = view.viewWithTag(1100) as! UIButton
        let musicBtn = view.viewWithTag(1101) as! UIButton
        let discoverBtn = view.viewWithTag(1102) as! UIButton
        if offsetX == WIN_WIDTH{
            myBtn.isSelected = false
            musicBtn.isSelected = true
            discoverBtn.isSelected = false
            myBtn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            musicBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
            discoverBtn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }else if offsetX == WIN_WIDTH * 2 {
            myBtn.isSelected = false
            musicBtn.isSelected = false
            discoverBtn.isSelected = true
            myBtn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            musicBtn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            discoverBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        }else if offsetX == 0{
            myBtn.isSelected = true
            musicBtn.isSelected = false
            discoverBtn.isSelected = false
            myBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
            musicBtn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
            discoverBtn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    
}

