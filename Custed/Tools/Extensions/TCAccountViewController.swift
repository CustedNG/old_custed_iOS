//
//  TCAccountViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCAccountViewController: UIViewController {
    let myView = TCAccountView()
    let myModel = TCAccountModel()
    override var prefersStatusBarHidden: Bool{
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "我的账号"
        self.view = myView
//        let rightImage = SVGKImage.init(named: "list.svg")
//        rightImage?.size = CGSize.init(width: 30, height: 30)
//        let rightButton = UIBarButtonItem.init(image: rightImage?.uiImage, style: .plain, target: self, action: #selector(rightButtonClicked))
//        self.navigationItem.rightBarButtonItem = rightButton
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    @objc func rightButtonClicked(){
        
    }
    


}
