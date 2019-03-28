//
//  TCAccountViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCAccountViewController: UIViewController {
    let myView = TCAccountView()
    let myModel = TCAccountModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //test
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "我的账户"
        self.view = myView
        TCNetWorkingManager.shared.gettingTakenID(id: "2017000254", pass: "028298")
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    


}
