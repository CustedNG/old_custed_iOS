//
//  TCAccountView.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Foundation
import SVGKit
class TCAccountView: UIView {
    
    var upperPartView : UIView?
    let itemCompact : CGFloat = ScreenHeight/50
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.widgetsPrepare()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    func widgetsPrepare(){
        upperPartView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight/3))
        upperPartView?.backgroundColor = UIColor.red
        self.addSubview(upperPartView!)
        upperPartView?.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.height.lessThanOrEqualToSuperview()
        })
        
        //我的账户
        let rightButton = UIButton.init(type: .custom)
        let rightImage = SVGKImage.init(named: "list.svg")
        rightButton.tintColor = UIColor.white
        rightImage?.size = CGSize.init(width: 25, height: 25)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.setImage(rightImage?.uiImage, for: .normal)
        upperPartView?.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(StatusBarheight)
            make.rightMargin.equalTo(-compactWidth)
        }
        let titleLabel = UILabel()
        titleLabel.text = "我的账户"
        //titleLabel.textColor = UIColor.white
        titleLabel.sizeToFit()
        titleLabel.font = UIFont.init(name: "Helvetica-Bold", size: 18)
        upperPartView?.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(rightButton)
            make.centerX.equalToSuperview()
        }
        //图
        let avatarView = UIImageView.init()
        avatarView.layer.cornerRadius = ScreenWidth/5/2
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.layer.borderWidth = 3
        avatarView.image = UIImage.init(named: "test1.JPG")
        avatarView.clipsToBounds = true
        avatarView.layer.masksToBounds = true
        upperPartView?.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: ScreenWidth/5, height: ScreenWidth/5))
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        //姓名
        let nameLabel = UILabel()
        nameLabel.text = "王宇阳"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.sizeToFit()
        upperPartView?.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarView.snp.bottom).offset(10)
        }
        //major
        let majorLabel = UILabel()
        majorLabel.text = "广电信息科学与工程"
        majorLabel.textColor = UIColor.white
        majorLabel.sizeToFit()
        upperPartView?.addSubview(majorLabel)
        majorLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            
        }
        //CID
        let CIDLable = UILabel()
        CIDLable.text = "[CID:XX] 170121610"
        CIDLable.textColor = UIColor.white
        CIDLable.sizeToFit()
        upperPartView?.addSubview(CIDLable)
        CIDLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(majorLabel.snp.bottom).offset(20)
            make.bottomMargin.equalTo(-10)
        }

        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientColors = [
            UIColor.FromRGB(RGB: 0x34C6FB).cgColor,
            UIColor.FromRGB(RGB: 0x4A9FF2).cgColor]
        
        let gradientColor = CAGradientLayer()
        gradientColor.startPoint = CGPoint.init(x: 0, y: 0)
        gradientColor.endPoint = CGPoint.init(x: 1, y: 0)
        gradientColor.colors = gradientColors
        gradientColor.frame = upperPartView!.frame
        upperPartView?.layer.insertSublayer(gradientColor, at: 0)
    }

}
