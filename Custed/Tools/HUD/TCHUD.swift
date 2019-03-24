//
//  TCHUD.swift
//  Custed
//
//  Created by faker on 2019/3/5.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCHUD: UIView {

    public class func show() -> (Void){
        let window: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        window.addSubview(TCHUDBase.sharedInstance())
        //填充整个页面
        TCHUDBase.sharedInstance().snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }

    }
    public class func dissmiss() ->(Void){
        TCHUDBase.sharedInstance().removeFromSuperview()
    }

}
