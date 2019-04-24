//
//  ClassDetailsView.swift
//  Custed
//
//  Created by faker on 2019/4/21.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
class ClassDetailsView: UIView {
    var detailView:UIView! //for background
    var detailBackgroundView:UIView!
    var LabelArray=Array<UILabel>()
    let LabelTextArray=["课程名称:","上课教室:","上课时间:","任课老师:","上课周数:","上课班级:"]
    var showedCellFrame:CGRect!
    let headerLabelheight:CGFloat = 22.0
    let messageFont = UIFont.systemFont(ofSize: 13*ScreenWidth/414)
    var alertWidth:CGFloat{
        get{
            if isIpad{
                return 400
            }
            else{
                return ScreenWidth-2*40
            }
        }
    }
    var alertHeight:CGFloat{
        get{
            if isIpad{
                return 300
            }
            else{
                return 40+7*26
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        /*-----------------Alert-----------------*/
        
        self.backgroundColor = nil
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = 10
        backgroundView.frame = self.frame
        backgroundView.backgroundColor = nil
        self.addSubview(backgroundView)
//        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapBackground))
//        backgroundView.addGestureRecognizer(tap)
        
        //for detailview background
        detailBackgroundView = UIView()
        detailBackgroundView.layer.cornerRadius = 10
        self.addSubview(detailBackgroundView)
        /*detailView-------------*/
        detailView = UIView()
        detailView.backgroundColor = nil
        detailView.layer.cornerRadius = 10
        detailView.isHidden = true
        self.addSubview(detailView)
        let titleLabel = UILabel()
        titleLabel.backgroundColor = nil
        titleLabel.textColor = UIColor.white
        titleLabel.text = "课程详情"
        detailView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
        }
        //X
        let closeButton = UIButton.init(type: .custom)
        let closeButtonHeight:CGFloat = 35*ScreenWidth/414
        let closeButtonBG = SVGKImage.init(named: "close.svg")
        closeButtonBG?.size = CGSize.init(width: closeButtonHeight, height: closeButtonHeight)
        closeButton.setBackgroundImage(closeButtonBG?.uiImage.imageWithColor(color: UIColor.white), for: .normal)
        closeButton.backgroundColor = nil
        closeButton.tintColor = UIColor.white
        closeButton.layer.cornerRadius = closeButtonHeight/2
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        closeButton.layer.borderColor = UIColor.white.cgColor
        closeButton.layer.borderWidth = 2.0
        detailView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(CGSize.init(width: closeButtonHeight, height: closeButtonHeight))
            make.rightMargin.equalTo(-10)
            make.topMargin.equalTo(10)
        }
        //array label
        let space:CGFloat = 25
        for i in 0..<6 {
            let lbl = UILabel()
            lbl.textAlignment = .center
            lbl.textColor = UIColor.white
            lbl.font = messageFont
            lbl.text = "test"
            lbl.frame = CGRect.init(x: 0, y: 40+CGFloat(i)*space, width: alertWidth, height: space)
            LabelArray.append(lbl)
            detailView.addSubview(lbl)
        }
        
        
        self.isHidden = true
        let windows = UIApplication.shared.delegate?.window
        windows!!.addSubview(self)
    }
    func showDetail(collectionView:UICollectionView,frame:CGRect,lesson:lesson?,color:UIColor?){
        //detailView.alpha = 0.3
        self.isHidden = false
        let offset = collectionView.contentOffset.y
        self.showedCellFrame = CGRect.init(x: frame.minX, y:frame.minY+self.headerLabelheight*2+NavigationHeight+StatusBarheight-offset , width: frame.width, height: frame.height)
        self.detailBackgroundView.frame = self.showedCellFrame
        self.detailBackgroundView.backgroundColor = color
        UIView.animate(withDuration: 0.6, animations: {
            self.isUserInteractionEnabled = false
            self.detailBackgroundView.frame = CGRect.init(x: (ScreenWidth - self.alertWidth)/2, y: (ScreenHeight - self.alertHeight)/2, width: self.alertWidth, height: self.alertHeight)
            print(self.alertHeight)
        }) { (no) in
            self.isUserInteractionEnabled = true
            self.assignToLabels(lesson: lesson!)
            self.detailView.frame = CGRect.init(x: (ScreenWidth - self.alertWidth)/2, y: (ScreenHeight - self.alertHeight)/2, width: self.alertWidth, height: self.alertHeight)
            self.detailView.isHidden = false
            print("finished")
        }
    }
    func closeDetailAlert(){
        self.detailView.isHidden = true
        UIView.animate(withDuration: 0.6, animations: {
            self.detailBackgroundView.frame = self.showedCellFrame
        }) { (bl) in
            self.isHidden = true
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func assignToLabels(lesson:lesson){
        //["课程名称","上课教室","上课时间","任课老师","上课周数","上课班级"]
        LabelArray[0].text = LabelTextArray[0]+lesson.lesson_name
        LabelArray[1].text = LabelTextArray[1]+lesson.location
        LabelArray[2].text = LabelTextArray[2]+lesson.start_time+"~"+lesson.end_time
        LabelArray[3].text = LabelTextArray[3]+lesson.teacher_name
        LabelArray[4].text = LabelTextArray[4]+lesson.raw_weeks
        LabelArray[5].text = LabelTextArray[5]+lesson.raw_classes
        
        //LabelArray[]
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    @objc func tapBackground(){
        self.closeDetailAlert()
    }
    @objc func closeButtonClicked(){
        self.closeDetailAlert()
    }
}
