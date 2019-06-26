//
//  HM_ListenChannelCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/26.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit
import JXMarqueeView

class HM_ListenChannelCell: UITableViewCell {
    private let marqueeView = JXMarqueeView()
    // 背景大图
    private var picView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    // 标题
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    // 滚动文字
    private var scrollLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    // 播放按钮
    private var playBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage(named: "whitePlay"), for: UIControlState.normal)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupView(){
        self.addSubview(self.picView)
        self.picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        self.picView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        // 文字跑马灯效果
        marqueeView.contentView = self.scrollLabel
        marqueeView.contentMargin = 10
        marqueeView.marqueeType = .reverse
        self.picView.addSubview(marqueeView)
        marqueeView.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.left.equalTo(self.titleLabel)
            make.right.equalToSuperview().offset(-70)
        }
        
        self.picView.addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(45)
        }
    }
    
    // 一键听主页数据模型
    var channelResults:HM_ChannelResultsModel? {
        didSet {
            guard let model = channelResults else {return}
            self.picView.kf.setImage(with: URL(string: model.bigCover!))
            self.titleLabel.text = model.channelName
            self.scrollLabel.text = model.slogan
        }
    }
    
    /// 更多频道数据模型
    var channelInfoModel:HM_ChannelInfosModel? {
        didSet {
            guard let model = channelInfoModel else {return}
            self.picView.kf.setImage(with: URL(string: model.bigCover!))
            self.titleLabel.text = model.channelName
            self.scrollLabel.text = model.slogan
            self.titleLabel.font = UIFont.systemFont(ofSize: 22)
            self.scrollLabel.font = UIFont.systemFont(ofSize: 16)
        }
    }
}
