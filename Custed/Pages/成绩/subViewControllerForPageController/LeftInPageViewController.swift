//
//  LeftInPageViewController.swift
//  Custed
//
//  Created by faker on 2019/4/28.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class LeftInPageViewController: UIViewController {
    private var labelArray:[UILabel]!
    private var formatArray:[String]!
    private var DataSourceP:GradePersonalInfo
    private var DataSourceT:GradeTotal
    private var DataSourceR:gradeRanking
    var loaded:Bool = false
    private func reloadData(leftP:GradePersonalInfo,leftT:GradeTotal,leftR:gradeRanking){
        if loaded == false{
            self.DataSourceP = leftP
            self.DataSourceT = leftT
            return
        }
        formatArray = [
            String.init(format:"总绩点:%@  学分:%@  通过:%d/%d" ,stripZero(leftT.point) ,stripZero(leftT.credit),leftT.pass,leftT.all),
            String.init(format: "学院排名:%d/%d  院系排名:%d/%d  专业排名:%d/%d",leftR.data.college.rank, leftR.data.college.total,leftR.data.faculty.rank,leftR.data.faculty.total, leftR.data.major.rank,leftR.data.major.total ),
            String.init(format: "%@ > %@ > %@", leftP.realname,leftP.major,leftP.class_num)
        ]
        for i in labelArray{
            i.text = formatArray[i.tag]
        }
    }
    override func viewDidLoad() {
        labelArray = [UILabel]()
        super.viewDidLoad()
        //总绩点 学分 通过
        //学院排名 院系排名 专业排名
        //姓名>专业>班级
        for i in 0..<3{
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .white
            label.tag = i
            label.font = UIFont.fontFitHeight(size: 21-CGFloat(i))
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
        loaded = true
        self.reloadData(leftP: self.DataSourceP, leftT: self.DataSourceT,leftR: self.DataSourceR)
    }
    init(leftP:GradePersonalInfo,leftT:GradeTotal,leftR:gradeRanking) {
        self.DataSourceP = leftP
        self.DataSourceT = leftT
        self.DataSourceR = leftR
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension LeftInPageViewController{
    func stripZero(_ number:CGFloat)->String{
        var str = String.init(format: "%f", number)
        for _ in 0..<str.count{
            if str.hasSuffix("0") || str.hasSuffix("."){
                str.removeLast()
            }
            else{
                break
            }
        }
        return str
    }
}
