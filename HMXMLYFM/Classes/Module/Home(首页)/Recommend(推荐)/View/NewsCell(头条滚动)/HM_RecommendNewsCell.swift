//
//  HM_RecommendNewsCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/16.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_RecommendNewsCell: UICollectionViewCell {
    private var topBuzz:[HM_TopBuzzModel]?
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "news.png")
        return imageView
    }()
    
    private var moreBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("|  更多", for: UIControlState.normal)
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (SCREEN_WIDTH - 150), height:40)
        let collectionView = UICollectionView.init(frame:CGRect(x:80,y:5, width:SCREEN_WIDTH-150, height:40), collectionViewLayout: layout)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        collectionView.contentSize = CGSize(width: (SCREEN_WIDTH - 150), height: 40)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.register(HM_NewsCell.self, forCellWithReuseIdentifier:"HM_NewsCell")
        return collectionView
    }()
    
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        // 开启定时器
        starTimer()
    }
    
    func setupLayout(){
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.top.equalTo(10)
        }
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(5)
        }
        // 添加滑动视图
        self.addSubview(self.collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var topBuzzList:[HM_TopBuzzModel]? {
        didSet{
            guard let model = topBuzzList else { return }
            self.topBuzz = model
            self.collectionView.reloadData()
        }
    }
}

extension HM_RecommendNewsCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.topBuzz?.count ?? 0)*100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HM_NewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HM_NewsCell", for: indexPath) as! HM_NewsCell
        cell.titleLabel.text = self.topBuzzList?[indexPath.row%(self.topBuzz?.count)!].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row%(self.topBuzz?.count)!)
    }
    
    /// 开启定时器
    func starTimer () {
        let timer = Timer.init(timeInterval: 2, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        // 这一句代码涉及到runloop 和 主线程的知识,则在界面上不能执行其他的UI操作
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        self.timer = timer
    }
    
    /// 在1秒后,自动跳转到下一页
    @objc func nextPage() {
        // 1.获取collectionView的X轴滚动的偏移量
        let currentOffsetY = collectionView.contentOffset.y
        let offsetY = currentOffsetY + collectionView.bounds.height
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    }
    
    /// 当collectionView开始拖动的时候,取消定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    /// 当用户停止拖动的时候,开启定时器
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        starTimer()
    }
}

class HM_NewsCell: UICollectionViewCell {
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.height.top.equalToSuperview()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
