//
//  RightViewControllerForPageController.swift
//  Custed
//
//  Created by faker on 2019/4/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class RightViewControllerForPageController: UIViewController {
    private var GPARound:GPARoundView!
    private var frame:CGRect
    private var _GPA:CGFloat = 0.0
    private var DataSource:GradeLevels
    private var LabelArray=[UILabel]()
    var GPA:CGFloat{
        set{
            self._GPA = newValue
            self.GPARound.animationWith(GPA: newValue)
        }
        get{
            return _GPA
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        let size:CGFloat = frame.height - StatusBarheight - NavigationHeight - 30 - 20 - 20 - 40
        GPARound = GPARoundView.init(frame: CGRect.init(x: 30, y: 20, width: size, height: size))
        self.view.addSubview(GPARound)
        
        let stack = UIStackView.init()
            //UIStackView.init(frame: CGRect.init(x: 30+size, y: 20, width: ScreenWidth-30-size, height: size))
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fillEqually
        //第一学期 共修 门课 共计 学分 去选修绩点
        for i in 0..<4{
            let lbl = UILabel()
            lbl.tag = i
            lbl.backgroundColor = .clear
            lbl.textColor = .white
            lbl.textAlignment = .center
            if i == 0{
                lbl.font = UIFont.fontFitWidth(size: 22)
            }
            else{
                lbl.font = UIFont.fontFitWidth(size: 17)
            }
            lbl.backgroundColor = nil
            LabelArray.append(lbl)
            stack.addArrangedSubview(lbl)
        }
        
        self.view.addSubview(stack)
        stack.snp_makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(GPARound.snp_right)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.reloadData(DataSource: self.DataSource)
    }
    init(frame:CGRect,level:GradeLevels){
        self.frame = frame
        self.DataSource = level
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reloadData(DataSource:GradeLevels){
        let formatArray =  [
            String.init(format: "%@", DataSource.description ?? ""),
            String.init(format: "共修%d门课", DataSource.all_num),
            String.init(format: "共计%@学分", stripZero(DataSource.credit)),
            String.init(format: "去选修绩点:%@",stripZero(DataSource.required_point))
        ]
        for i in LabelArray{
            i.text = formatArray[i.tag]
        }
        self.GPA = DataSource.point
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RightViewControllerForPageController{
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
