//
//  TCHomePageViewController.swift
//  Custed
//
//  Created by faker on 2019/3/18.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit


class TCHomePageViewController: UIViewController,UIGestureRecognizerDelegate{

    var isMainPage : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        let leftSVGImage = SVGKImage.init(named: "custedid.svg")
        leftSVGImage?.size = CGSize.init(width: 25, height: 25)
        let leftBarItem = UIBarButtonItem.init(image: leftSVGImage?.uiImage, style: .done, target: self, action: #selector(leftBarItemClicked))
        self.title = "首页"
        self.navigationItem.leftBarButtonItem = leftBarItem
        let rightSVGImage = SVGKImage.init(named: "list.svg")
        rightSVGImage?.size = CGSize.init(width: 25, height: 25)
        let rightBarItem = UIBarButtonItem.init(image: rightSVGImage?.uiImage, style: .done, target: self, action: #selector(rightBarItemClicked))
        self.navigationItem.rightBarButtonItem = rightBarItem
        self.view.backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("not be implemented")
    }
    
    @objc func leftBarItemClicked(){
        print("左边点击")
    }
    @objc func rightBarItemClicked(){
        print("右边点击")
    }

    

}
