//
//  ScheduleTitleView.swift
//  Custed
//
//  Created by faker on 2019/4/17.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
protocol titleVIewClick:class{
    func arrowButtonForTitleViewClicked(tag:Int)
}
class ScheduleTitleView: UIView {
    var weeksLabel:UILabel!
    var semesterLabel:UILabel!
    weak var delegate:titleVIewClick?
    
    /// Description:override this variable to make sure self is interactable
    override open var intrinsicContentSize: CGSize{
        get{
            return CGSize.init(width: ScreenWidth/5, height: 44)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = nil
    
        weeksLabel = UILabel()
        weeksLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(weeksLabelTap))
        weeksLabel.addGestureRecognizer(tap)
        weeksLabel.textAlignment = .center
        weeksLabel.textColor = UIColor.white
        self.addSubview(weeksLabel)
        weeksLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        let svgSize = CGSize.init(width: 25, height: 25)
        let leftArrow = SVGKImage.init(named: "left.svg")
        leftArrow?.size = svgSize
        let arrowImage = leftArrow?.uiImage.imageWithColor(color: UIColor.white)
        let leftArrowButton = UIButton.init(type: .custom)
        leftArrowButton.setBackgroundImage(arrowImage, for: .normal)
        leftArrowButton.tag = 1
        leftArrowButton.addTarget(self, action: #selector(arrowButtonClicked(sender:)), for: .touchUpInside)
        self.addSubview(leftArrowButton)
        leftArrowButton.snp.makeConstraints { (make) in
            make.right.equalTo(weeksLabel.snp_left)
            make.centerY.equalTo(weeksLabel)
        }
        let rightArrowButton = UIButton.init(type: .custom)
        rightArrowButton.setBackgroundImage(arrowImage, for: .normal)
        rightArrowButton.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
        rightArrowButton.tag = 2
        rightArrowButton.isUserInteractionEnabled = true
        rightArrowButton.addTarget(self, action: #selector(arrowButtonClicked(sender:)), for: .touchUpInside)
        self.addSubview(rightArrowButton)
        rightArrowButton.snp.makeConstraints { (make) in
            make.left.equalTo(weeksLabel.snp_right)
            make.centerY.equalTo(weeksLabel)
        }
        semesterLabel = UILabel()
        semesterLabel.font = UIFont.fontSizeToFit(size: 11)
        semesterLabel.textAlignment = .center
        semesterLabel.textColor = UIColor.white
        self.addSubview(semesterLabel)
        semesterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weeksLabel.snp_bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    /// Description:tag 1 for leftArrowButton
    ///             tag 2 for rightArrowButton
    ///
    /// - Parameter sender:
    @objc func arrowButtonClicked(sender:UIButton){
        self.delegate?.arrowButtonForTitleViewClicked(tag: sender.tag)
    }
    @objc func weeksLabelTap(){
        self.delegate?.arrowButtonForTitleViewClicked(tag: 3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
