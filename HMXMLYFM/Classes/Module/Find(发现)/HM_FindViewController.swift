//
//  HM_FindViewController.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/5/14.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import LTScrollView

class HM_FindViewController: HM_BasisViewController {
    
    // - headerView
    private lazy var headerView:HM_FindHeaderView = {
        let view = HM_FindHeaderView.init(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:190))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        let findAttentionVC = HM_FindAttentionController()
        let findRecommendVC = HM_FindRecommendController()
        let findDuDYVC = HM_FindDudController()
        return [findAttentionVC, findRecommendVC, findDuDYVC]
    }()
    
    private lazy var titles: [String] = {
        return ["关注动态", "推荐动态", "趣配音"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 56
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - NAVBAR_HEIGHT), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        // advancedManager.hoverY = navigationBarHeight
        /* 点击切换滚动过程动画 */
        // advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        // advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "msg"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "搜索"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
        
        // 导航栏左右item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
    }
    
    deinit {
    }
    
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        print("左边按钮被点击了")
    }
    // - 导航栏左边消息点击事件
    @objc func rightBarButtonClick() {
        print("右边按钮被点击了")
    }
}

extension HM_FindViewController : LTAdvancedScrollViewDelegate {
    // 具体使用请参考以下
    private func advancedManagerConfig() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
    }
}
