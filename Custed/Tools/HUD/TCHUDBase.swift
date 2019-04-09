//
//  TCHUDBase.swift
//  Custed
//
//  Created by faker on 2019/3/4.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Foundation
class TCHUDBase: UIView {
    //使用单例设计模式
    static let instance = TCHUDBase()
    class func sharedInstance() -> TCHUDBase{
        return instance
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        /*---HUD的设置---*/
        self.backgroundColor = UIColor.init(white: 0.1, alpha: 0.2)
        self.isUserInteractionEnabled = false
        
        
        /*--中间那一坨黑色的--*/
        let maskView = UIView()
        maskView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.8)
        //设置圆角
        maskView.layer.cornerRadius = 10
        maskView.layer.masksToBounds = true
        self.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        /*---圈圈---*/
        let loading = UIActivityIndicatorView()
        loading.style = .whiteLarge
        loading.startAnimating()
        maskView.addSubview(loading)
        loading.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 60, height: 60))
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        /*---圈圈下面的字---*/
        let lbl = UILabel()
        lbl.text = "加载中"
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        maskView.addSubview(lbl)
        lbl.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not be implement")
    }
}
