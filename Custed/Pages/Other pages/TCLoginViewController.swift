//
//  TCLoginViewController.swift
//  Custed
//
//  Created by faker on 2019/4/1.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //返回
        let backImage = UIImageView.init(image: UIImage.init(named: "widget_week_open.png"))
        //backImage.tintColor = UIColor.FromRGB(RGB: 0x5CA9F3)
        backImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(clicked))
        backImage.addGestureRecognizer(gesture)
        self.view.addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(StatusBarheight)
            make.left.equalToSuperview().offset(compactWidth)
        }
        //logo
        let logoImage = UIImageView.init(image: UIImage.init(named: "custedLogo.png"))
        self.view.addSubview(logoImage)
        logoImage.snp.makeConstraints { (make) in
            make.topMargin.equalTo(ScreenHeight/15)
            make.centerX.equalToSuperview()
        }
        //吐司工作室 - let us imagine
        let label1 = UILabel.init()
        label1.text = "吐司工作室 - Let us imagine"
        label1.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(logoImage.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        //源于学生的高级技术开发团队
        let label2 = UILabel.init()
        label2.text = "源于学生的高级技术开发团队"
        label2.textAlignment = .center
        label2.font = UIFont.systemFont(ofSize: 23)
        self.view.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.top.equalTo(label1.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        //label
        let accountTextFiled = UITextField()
        accountTextFiled.placeholder = "一卡通账号(如:2016001234)"
        accountTextFiled.layer.cornerRadius = 5
        accountTextFiled.layer.borderWidth = 1
        accountTextFiled.layer.borderColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1).cgColor
        let accountImage = SVGKImage.init(named: "custedid.svg")
        accountImage?.size = CGSize.init(width: 20, height: 20)
        let accountImageView = UIImageView.init(image: accountImage?.uiImage)
        accountImageView.frame = CGRect.init(x: 5, y: 0, width: 20, height: 20)
        accountTextFiled.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 35, height: 20))
        accountTextFiled.leftView?.addSubview(accountImageView)
        accountTextFiled.leftViewMode = .always
        self.view.addSubview(accountTextFiled)
        accountTextFiled.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(label2.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: ScreenWidth*4/5, height: 35))
        }
        
        
        
        
        
//        let btn = UIButton.init(type: .system)
//        btn.setTitle("登陆", for: .normal)
//        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
//        self.view.addSubview(btn)
//        btn.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//        }
        //logoGray.svg
    }
    @objc func clicked(){
        print("点击")
        self.dismiss(animated: true, completion: nil)
    }
    


}
