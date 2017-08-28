

import UIKit
import MJRefresh

typealias InputClosureType = (String) -> Void

class SVideoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView: UICollectionView?

    var backClosure:InputClosureType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVideoHttp_Request.page = 0
        SVideoModel.sVideoModel.removeAll()
        
        self.navigationController?.navigationBar.tintColor = MainColor
        let rightButton = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(closeViewController))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.view.backgroundColor = UIColor.white
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumInteritemSpacing = 2
        flowlayout.minimumLineSpacing = 2
        flowlayout.scrollDirection = .vertical
        flowlayout.estimatedItemSize = CGSize(width: (WIN_WIDTH - 2)/2, height: (WIN_WIDTH - 2)/2 - 50)
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 60 - 40)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowlayout)
        collectionView!.backgroundColor = UIColor.white
        collectionView!.dataSource  = self
        collectionView!.delegate = self
        collectionView!.showsHorizontalScrollIndicator = false
        collectionView!.allowsMultipleSelection = true
        collectionView!.register(SVideoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView!)
        
        //默认【上拉加载】
        self.collectionView?.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(SpecialViewController.loadMoreData))
        
        NotificationCenter.default.addObserver(self, selector: #selector(SVideoViewController.reloadData), name: NSNotification.Name(rawValue: "SVideoSearchDone"), object: nil)
    }
    

    // CollectionView行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SVideoModel.sVideoModel.count
    }
    
    // 获取单元格
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = SVideoModel.sVideoModel[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SVideoCollectionViewCell
        cell.imageView.sd_setImage(with: URL(string: data.img), placeholderImage: UIImage(named: "demo6"))
        cell.titleLabel.text = data.description + "\(data.comment)"
        
        cell.subView.videoPlayButton.setTitle(" \(Common.playCount(count: Double(data.playcount)))", for: .normal)
        cell.subView.discussCountButton.setImage(UIImage(named: "actionIconComment_b"), for: .normal)
        cell.subView.discussCountButton.setTitle(" \(data.comment)", for: .normal)
        return cell
    }
    
    
    func reloadData(){
        DispatchQueue.main.async { 
            self.collectionView?.reloadData()
            //数据是否加载完成
            if SVideoHttp_Request.noMoreData == false{
                self.collectionView?.mj_footer.endRefreshing()
            }else{
                self.collectionView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }
    }
    
    //初始化单曲列表/加载更多数据
    func loadMoreData(){
        SVideoHttp_Request.page += 1
        SVideoHttp_Request.sVideoSearchRequest()
    }
    
    
    //闭包变量的Seter方法
    func setBackMyClosure(tempClosure:@escaping InputClosureType) {
        self.backClosure = tempClosure
    }
    
    //关闭
    func closeViewController(){
        //闭包传值
        if self.backClosure != nil {
            self.backClosure!("")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMoreData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



