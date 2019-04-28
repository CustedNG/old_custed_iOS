//
//  LeftInPageViewController.swift
//  Custed
//
//  Created by faker on 2019/4/28.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class LeftInPageViewController: UIViewController {
    var labelArray:[UILabel]!
    private var formatArray:[String]!
    override func viewDidLoad() {
        labelArray = [UILabel]()
        super.viewDidLoad()
        formatArray = [
            "总绩点:%f  学分:%f  通过:%f/%f",
            "学院排名:%f  院系排名:%f  专业排名:%f",
            "%s>%s>%s"
        ]
        //总绩点 学分 通过
        //学院排名 院系排名 专业排名
        //姓名>专业>班级
        for i in 0..<3{
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.fontFitHeight(size: 21-CGFloat(i))
            
            label.text = "你好鸭:\(i)"
            labelArray.append(label)
            self.view.addSubview(label)
        }
        labelArray[0].snp_makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        labelArray[1].snp_makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        labelArray[2].snp_makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
        
    }

}
