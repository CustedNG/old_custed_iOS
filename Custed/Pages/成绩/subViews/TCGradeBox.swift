//
//  TCGradeBox.swift
//  Custed
//
//  Created by faker on 2019/4/28.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit

class TCGradeBox: UITableViewCell {
    var expend:Bool = false{
        didSet{
            self.animateView()
        }
    }
    var exam:GradeExams!{
        didSet{
            self.reloadData()
        }
    }
    private var sketchView:UIView!
    private var detailView:UIStackView!
    private var rightLabel:UILabel!
    private var leftLabel:UILabel!
    private var labelArray:[UILabel]
    private let labelFontSize:CGFloat = 17
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        labelArray = [UILabel]()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.layer.borderWidth = 8
        self.layer.borderColor = UIColor.white.cgColor
        self.isSelected = false
        //setting border for cells
        let borderView = UIView()
        borderView.layer.borderColor = UIColor.FromRGB(RGB: 0x75B6F5).cgColor
        borderView.layer.borderWidth = 1
        borderView.backgroundColor = nil
        self.addSubview(borderView)
        borderView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8))
        }
        
        //for first appear,and show sketch info
        //subviews in sketchView
        let leftLabel = UILabel() //lesson name
        leftLabel.tag = 1
        leftLabel.textAlignment = .center
        leftLabel.textColor = UIColor.FromRGB(RGB: 0x4A9FF2)
        leftLabel.font = UIFont.boldSystemFont(ofSize: labelFontSize/414*ScreenWidth)
        contentView.addSubview(leftLabel)
        labelArray.append(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leftMargin.equalTo(10)
        }
        
        let rightLabel = UILabel() //grade
        rightLabel.textAlignment = .center
        rightLabel.tag = 2
        rightLabel.text = "98.00"
        //rightLabel.textColor = UIColor.FromRGB(RGB: 0x31A336)
        rightLabel.font = UIFont.fontFitWidth(size: labelFontSize)
        contentView.addSubview(rightLabel)
        labelArray.append(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.rightMargin.equalTo(-10)
        }
        //for expending
        detailView = UIStackView()
        detailView.isHidden = false
        detailView.alpha = 0
        detailView.axis = .vertical
        detailView.spacing = 10
        detailView.distribution = .fillEqually
        contentView.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview()
        }
        //subviews in detailView
        for i in 0..<3{
            let lbl = UILabel()
            lbl.tag = 3+i
            lbl.textAlignment = .center
            //lbl.font = UIFont.fontFitHeight(size: labelFontSize)
            lbl.text = "Testing"
            lbl.backgroundColor = .white
            labelArray.append(lbl)
            detailView.addArrangedSubview(lbl)
        }
        
        
    }
    func reloadData(){
        var formatText:[NSAttributedString] = [NSAttributedString].init()
//            self.exam.name,
//            self.exam.raw_mark,
//            String.init(format: "%@  %@", self.exam.name,self.exam.required),
//            String.init(format: "成绩:%@  类别:%@", self.exam.raw_mark,self.exam.type),
//            String.init(format: "学分:%@  课时:%d 状态:%@",stripZero(exam.credit),self.exam.hours,self.exam.pass )
        
        let markColor:UIColor
        let requiedColor:UIColor
        if exam.mark < 60{
            markColor = UIColor.red
        }
        else{
            markColor = UIColor.FromRGB(RGB: 0x31A336)
        }
        
        if exam.required == "必修"{
            requiedColor = UIColor.FromRGB(RGB: 0x289EAF)
        }
        else{
            requiedColor = UIColor.FromRGB(RGB: 0x9D33AF)
        }
        let name = NSAttributedString.init(string: exam.name, attributes: [NSAttributedString.Key.foregroundColor : UIColor.FromRGB(RGB: 0x4A9FF2)])
        let mark = NSAttributedString.init(string: exam.raw_mark, attributes: [NSAttributedString.Key.foregroundColor : markColor])
        formatText.append(name)
        formatText.append(mark)
        //first line 线性代数 必修
        let firstLineText = String.init(format: "%@  %@", self.exam.name,self.exam.required)
        let firstLine = NSMutableAttributedString.init(string: firstLineText)
        let nameText = exam.name
            //add attribute to name
        firstLine.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.FromRGB(RGB: 0x4A9FF2), range: NSMakeRange(0, nameText.count))
        firstLine.addAttribute(NSAttributedString.Key.foregroundColor, value: requiedColor, range: NSMakeRange(nameText.count+2, exam.required.count))
        formatText.append(firstLine)
        //second line
        let secondText = String.init(format: "成绩:%@  类别:%@", self.exam.raw_mark,self.exam.type)
        let markTextInLines = String.init(format: "成绩:%@", exam.raw_mark)
        let secondLine = NSMutableAttributedString.init(string: secondText)
        secondLine.addAttribute(NSAttributedString.Key.foregroundColor, value: markColor, range: NSMakeRange(0, markTextInLines.count))
        formatText.append(secondLine)
        let thirdLine = NSAttributedString.init(string: String.init(format: "学分:%@  课时:%d 状态:%@",stripZero(exam.credit),self.exam.hours,self.exam.pass ))
        formatText.append(thirdLine)
        for i in labelArray{
            i.attributedText = formatText[i.tag-1]
        }
    }
    func animateView(){
//        print(expend)
//        let enlargeAni = CABasicAnimation.init(keyPath: "transform.scale")
//        enlargeAni.duration = 0.1
//        enlargeAni.fromValue = 1
//        enlargeAni.toValue = 1.05
        
        if expend == true{
            //            self.detailView.layer.add(enlargeAni, forKey: "enlargeAnimation")
            UIView.animate(withDuration: 0.3, animations: {
                self.labelArray[0].alpha = 0
                self.labelArray[1].alpha = 0
                self.detailView.alpha = 1
            }) { (finished) in
//                if finished == true{
//                    self.detailView.layer.add(enlargeAni, forKey: "enlargeAnimation")
//                }
            }
        }
        else{
            UIView.animate(withDuration: 0.2) {
                self.labelArray[0].alpha = 1
                self.labelArray[1].alpha = 1
                self.detailView.alpha = 0
            }
            //collapse
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //print("selected")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension TCGradeBox{
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
