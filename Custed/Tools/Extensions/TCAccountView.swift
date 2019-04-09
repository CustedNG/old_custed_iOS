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
protocol buttonDelegate: class,UITableViewDataSource{
    func buttonClicked()
    func imageViewClick(tag:Int)
}


class TCAccountView: UIView,UITableViewDelegate{
    
    weak var delegate : buttonDelegate?
    var upperPartView : UIView?
    var underPartView : UIView?
    let itemCompact : CGFloat = ScreenHeight/50
    var avatarView :UIImageView?
    var nameLabel : UILabel?
    var majorLabel : UILabel?
    var CIDLable : UILabel?
    var logOut : UIButton?
    
    let cellWidth : CGFloat = ScreenWidth/10
    let cellHeight : CGFloat = ScreenWidth/10
    let fontSize : CGFloat = 13*ScreenWidth/414
    let cellForTablViewCellHeight = 40*ScreenHeight/896
    let cellIdentifier : String = "AccountCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    func loadView(){
        self.widgetsPrepare()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    func widgetsPrepare(){
        upperPartView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight/3))
        upperPartView?.backgroundColor = UIColor.white
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
        avatarView = UIImageView.init()
        avatarView!.layer.cornerRadius = ScreenWidth/5/2
        avatarView!.layer.borderColor = UIColor.white.cgColor
        avatarView!.layer.borderWidth = 3
        avatarView!.image = UIImage.init(named: "defaultAvatar.jpg")
        avatarView!.clipsToBounds = true
        avatarView!.layer.masksToBounds = true
        upperPartView?.addSubview(avatarView!)
        avatarView!.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: ScreenWidth/5, height: ScreenWidth/5))
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        //姓名
        nameLabel = UILabel()
        nameLabel!.text = "未登陆"
        nameLabel!.textColor = UIColor.white
        nameLabel!.font = UIFont.systemFont(ofSize: 20)
        nameLabel!.sizeToFit()
        upperPartView?.addSubview(nameLabel!)
        nameLabel!.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarView!.snp.bottom).offset(10)
        }
        //major
        majorLabel = UILabel()
        majorLabel!.text = ""
        majorLabel!.textColor = UIColor.white
        majorLabel!.sizeToFit()
        upperPartView?.addSubview(majorLabel!)
        majorLabel!.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel!.snp.bottom).offset(20)
            
        }
        //CID
        CIDLable = UILabel()
        CIDLable!.text = ""
        CIDLable!.textColor = UIColor.white
        CIDLable!.sizeToFit()
        upperPartView?.addSubview(CIDLable!)
        CIDLable!.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(majorLabel!.snp.bottom).offset(20)
            make.bottomMargin.equalTo(-10)
        }
        underPartView = UIView.init()
        underPartView?.backgroundColor = UIColor.white
        self.addSubview(underPartView!)
        underPartView?.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.top.equalTo(upperPartView!.snp_bottom).offset(15)
            make.height.equalToSuperview().dividedBy(2)
        })
        //教务系统
        let JWGLImageVIew = UIImageView()
        JWGLImageVIew.tag = 1
        JWGLImageVIew.isUserInteractionEnabled = true
        let tapGesture1 = UITapGestureRecognizer.init(target: self, action: #selector(JWGLClicked(sender:target:)))
        JWGLImageVIew.addGestureRecognizer(tapGesture1)
        let JWGLsvg = SVGKImage.init(named: "jwgl.svg")
        JWGLsvg?.size = CGSize.init(width: cellWidth, height: cellWidth)
        JWGLImageVIew.image = JWGLsvg?.uiImage
        underPartView!.addSubview(JWGLImageVIew)
        JWGLImageVIew.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        let JWGLLabel = UILabel()
        JWGLLabel.font = UIFont.systemFont(ofSize: fontSize)
        JWGLLabel.text = "教务系统"
        JWGLLabel.textAlignment = .center
        underPartView?.addSubview(JWGLLabel)
        JWGLLabel.snp.makeConstraints { (make) in
            make.top.equalTo(JWGLImageVIew.snp_bottom)
            make.centerX.equalTo(JWGLImageVIew)
        }
        //资料库
        let ZLKImageVIew = UIImageView()
        ZLKImageVIew.isUserInteractionEnabled = true
        ZLKImageVIew.tag = 2
        let tapGesture2 = UITapGestureRecognizer.init(target: self, action: #selector(JWGLClicked(sender:target:)))
        ZLKImageVIew.addGestureRecognizer(tapGesture2)
        let ZLKsvg = SVGKImage.init(named: "dataBank.svg")
        ZLKsvg?.size = CGSize.init(width: cellWidth, height: cellWidth)
        ZLKImageVIew.image = ZLKsvg?.uiImage
        underPartView!.addSubview(ZLKImageVIew)
        ZLKImageVIew.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalTo(JWGLImageVIew.snp_left).offset(-50)
        }
        let ZLKLabel = UILabel()
        ZLKLabel.font = UIFont.systemFont(ofSize: fontSize)
        ZLKLabel.text = "资料库"
        ZLKLabel.textAlignment = .center
        underPartView?.addSubview(ZLKLabel)
        ZLKLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ZLKImageVIew.snp_bottom)
            make.centerX.equalTo(ZLKImageVIew)
        }
        //BB
        let BBImageVIew = UIImageView()
        BBImageVIew.isUserInteractionEnabled = true
        BBImageVIew.tag = 3
        let tapGesture3 = UITapGestureRecognizer.init(target: self, action: #selector(JWGLClicked(sender:target:)))
        BBImageVIew.addGestureRecognizer(tapGesture3)
        let BBsvg = SVGKImage.init(named: "bbplatform.svg")
        BBsvg?.size = CGSize.init(width: cellWidth, height: cellWidth)
        BBImageVIew.image = BBsvg?.uiImage
        underPartView!.addSubview(BBImageVIew)
        BBImageVIew.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(JWGLImageVIew.snp_right).offset(50)
        }
        let BBLabel = UILabel()
        BBLabel.font = UIFont.systemFont(ofSize: fontSize)
        BBLabel.text = "BB平台"
        BBLabel.textAlignment = .center
        underPartView?.addSubview(BBLabel)
        BBLabel.snp.makeConstraints { (make) in
            make.top.equalTo(BBImageVIew.snp_bottom)
            make.centerX.equalTo(BBImageVIew)
        }
        //tableview
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 160), style: UITableView.Style.plain)
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self.delegate
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        underPartView?.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(BBLabel.snp_bottom).offset(20)
            make.size.equalTo(CGSize.init(width: ScreenWidth, height: cellForTablViewCellHeight*4))
        }
        //退出登陆
        logOut = UIButton.init(type: .system)
        logOut!.setTitle("退出账号", for: .normal)
        logOut!.tintColor = UIColor.FromRGB(RGB: 0x4A9FF2)
        //取颜色的插件取出来的RGB不对,所以用这种方式
        logOut!.layer.backgroundColor = UIColor.init(red: 0.894, green: 0.945, blue: 0.992, alpha: 1.0).cgColor
        logOut!.layer.borderWidth = 2
        logOut!.layer.borderColor = UIColor.FromRGB(RGB: 0x4A9FF2).cgColor
        logOut!.addTarget(self, action: #selector(logoutClick), for: .touchUpInside)
        underPartView!.addSubview(logOut!)
        logOut?.snp.makeConstraints({ (make) in
            make.top.equalTo(tableView.snp_bottom).offset(10)
            make.width.equalTo(ScreenWidth*4/5)
            make.centerX.equalToSuperview()
        })
        
    }
    @objc func JWGLClicked(sender: UITapGestureRecognizer,target: UIView){
        self.delegate?.imageViewClick(tag: sender.view?.tag ?? 0)
    }
    @objc func ZLKClicked(){
        
    }
    @objc func BBClicked(){
        
    }
    @objc func logoutClick(){
        self.delegate?.buttonClicked()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientColors = [
            UIColor.FromRGB(RGB: 0x34C6FB).cgColor,
            UIColor.FromRGB(RGB: 0x4A9FF2).cgColor]
        let frame = upperPartView!.frame
        //print(frame)
        let gradientColor = CAGradientLayer()
        gradientColor.startPoint = CGPoint.init(x: 0, y: 0)
        gradientColor.endPoint = CGPoint.init(x: 1, y: 0)
        gradientColor.colors = gradientColors
        gradientColor.frame = frame
        upperPartView?.layer.insertSublayer(gradientColor, at: 0)
        
    }
    override func updateConstraints() {
        super.updateConstraints()
        let frame = upperPartView!.frame
        print(frame)
        underPartView?.snp.remakeConstraints({ (make) in
            make.width.equalToSuperview()
            make.top.equalTo(upperPartView!.snp_bottom).offset(15)
            make.height.equalTo(ScreenHeight-frame.height-TabBarHeight-15)
        })
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellForTablViewCellHeight
    }

}
