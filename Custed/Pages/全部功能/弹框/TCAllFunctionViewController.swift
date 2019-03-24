//
//  TCAllFunctionViewController.swift
//  Custed
//
//  Created by faker on 2019/3/6.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCAllFunctionViewController: UIViewController {
    func clicked(target: UIView, index: NSInteger) {
        target.removeFromSuperview()
    }
    
    var fcModel : TCAllFunctionModel?
    var fcView : TCAllFunctionView?
    /// 初始化
    init(){
        super.init(nibName: nil, bundle: nil)
        //装配mvc
        fcModel = TCAllFunctionModel()
//        self.requestData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) is not be implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func remove(){
        removeFromParent()
    }
    
    
    
    
    

    

}
