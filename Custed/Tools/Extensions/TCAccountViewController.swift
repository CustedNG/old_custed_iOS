//
//  TCAccountViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCAccountViewController: UIViewController {
    let MyView = TCAccountView()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view = MyView
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    


}
