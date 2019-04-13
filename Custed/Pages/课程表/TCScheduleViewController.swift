//
//  TCScheduleViewController.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class TCScheduleViewController: UIViewController {

    let myView = TCScheduleView()
    let myModel = TCScheduleModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        myModel.getScheduleData {
            print("completed")
        }
        
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "课程表"
        let right = SVGKImage.init(named: "list.svg")
        right?.size = CGSize.init(width: 20, height: 20)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: right?.uiImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightNavClicked))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    override func loadView() {
        self.view = myView
    }
    
    @objc func rightNavClicked(){
        print("rightNav")
    }

}
