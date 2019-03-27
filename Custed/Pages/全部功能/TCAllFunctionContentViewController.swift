//
//  TCAllFunctionWebViewController.swift
//  Custed
//
//  Created by faker on 2019/3/8.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCAllFunctionContentViewController: UIViewController ,ButtonPressedDelegate{
    func click(target: UIView, index: NSInteger) {
        print(index)
    }
    
    
    
    var tcView :TCAllFunctionContentView = TCAllFunctionContentView()
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "全部功能"
        self.tabBarItem.badgeColor = UIColor.blue
        self.tabBarItem.tag = 3
        self.view.backgroundColor = UIColor.white
        //self.tabBarItem.image = UIImage.init(named: )
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not be implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.tcView

    }
    

}
