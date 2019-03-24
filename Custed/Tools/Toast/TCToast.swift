//
//  TCToast.swift
//  Custed
//
//  Created by faker on 2019/3/18.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
class TCToast: UIView {
    var messageLabel : UILabel
    var showDurationTime : Int = 3
    var shadeDurationTime : Double = 0.5
    override init(frame: CGRect) {
        self.messageLabel = UILabel()
        super.init(frame: frame)
        //自身设置
        self.backgroundColor = UIColor.init(white: 0.2, alpha: 0.5)
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = 10
        // 一个label用于展示信息 一个label的罩子用于套住label
        self.addSubview(self.messageLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init:coder is not be implemented")
    }
    private func widgetsPrepareWith(_ message: String){
        self.messageLabel.sizeToFit()
        self.messageLabel.numberOfLines = 0
        self.messageLabel.lineBreakMode = .byWordWrapping
        self.messageLabel.font = UIFont.systemFont(ofSize: 15)
        self.messageLabel.text = message
        self.messageLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            //超过屏幕一半换行
            make.width.lessThanOrEqualTo(ScreenWidth/2)
        }
        self.snp.makeConstraints { (make) in
            //四个边界边距都为10
            make.top.left.equalTo(self.messageLabel).offset(-10)
            make.bottom.right.equalTo(self.messageLabel).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    class func showWithMessage(_ message: String){
        let toast : TCToast = TCToast()
        let windows:UIWindow = (UIApplication.shared.delegate?.window! ?? nil)!
        windows.addSubview(toast)
        toast.widgetsPrepareWith(message)
        DispatchQueue.main.asyncAfter(deadline:.now() + 3) {
            UIView.animate(withDuration: toast.shadeDurationTime, animations: {
                toast.alpha = 0
            }, completion: { (true) in
                toast.removeFromSuperview()
            })
        }
    }

}
