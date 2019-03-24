//
//  WYYTestViewController.swift
//  Custed
//
//  Created by faker on 2019/3/4.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

//test
import SwiftyJSON
import Alamofire
import SVGKit
class WYYTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.brown
        btn.setTitle("click", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(btnPressed) , for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
//        let svgImg : SVGKImage = SVGKImage.init(named: "n.svg")
//        let svgImgView : SVGKImageView = SVGKLayeredImageView.init(svgkImage: svgImg)
//        self.view.addSubview(svgImgView)
//        svgImgView.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(btn).offset(50)
//        }
        // Do any additional setup after loading the view.
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem.title = "test"
        let svgImg : SVGKImage = SVGKImage.init(named:"allFunc.svg")
        svgImg.size = CGSize.init(width: 25, height: 25)
        self.tabBarItem.image = svgImg.uiImage
        self.tabBarItem.tag = 1
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    @objc func btnPressed(){
        testHUD()
    }
    
    
    
    func testHUD() -> Void {
        TCToast.showWithMessage("请你登陆一下子好吧？")
    }
    func testAPI() -> Void{
        
    }

}
