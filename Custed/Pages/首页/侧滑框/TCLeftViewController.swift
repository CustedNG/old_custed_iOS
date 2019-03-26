//
//  TCLeftViewController.swift
//  Custed
//
//  Created by faker on 2019/3/24.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCLeftViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
//        self.view.frame = CGRect.init(x: 0, y: 0, width: , height: ScreenHeight)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        let testbtn = UIButton()
        testbtn.setTitle("hello,world", for: .normal)
        testbtn.backgroundColor = UIColor.red
        self.view.addSubview(testbtn)
        testbtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        let img = UIImageView.init(image: UIImage.init(named: "123.jpg"))
        img.clipsToBounds = true
        self.view.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(ScreenHeight/3)
        }
    }

}
