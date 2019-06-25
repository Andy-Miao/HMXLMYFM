//
//  HM_MineMakeCell.swift
//  HMXMLYFM
//
//  Created by humiao on 2019/6/25.
//  Copyright © 2019 humiao. All rights reserved.
//

import UIKit

class HM_MineMakeCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        setUpLayout()
    }
    /// 布局
    func setUpLayout(){
        
        let margin:CGFloat = SCREEN_WIDTH/8
        let titleArray = ["我要录音","我要直播","我的作品","主播工作台"]
        let imageArray = ["麦克风","直播","视频","工作台"]
        for index in 0..<4 {
            let button = UIButton.init(frame: CGRect(x:margin*CGFloat(index)*2+margin/2,y:10,width:margin,height:margin))
            button.setImage(UIImage(named: imageArray[index]), for: UIControlState.normal)
            self.addSubview(button)
            
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[index]
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            if index == 0 {
                titleLabel.textColor = SYC_Tools.RGBColor(r: 213, g: 54, b: 13)
                let waveView = HM_CVLayerView(frame: CGRect(x: margin*CGFloat(index)*2+margin/2, y: 10, width: margin, height: margin))
                waveView.center = button.center
                // 因为我的VC是XIB  所以将图层添加在到按钮之下 一般用法就直接addSubview就可以了
                self.addSubview(waveView)
                waveView.starAnimation()  // 开始动画
                
            }else {
                titleLabel.textColor = UIColor.gray
            }
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin+30)
                make.top.equalTo(margin+10+5)
            })
            button.tag = index
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
