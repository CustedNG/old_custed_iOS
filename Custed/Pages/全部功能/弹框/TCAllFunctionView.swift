//
//  TCAllFunctionView.swift
//  Custed
//
//  Created by faker on 2019/3/6.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Foundation
import SVGKit
/*
 还未完成的：
 1.缓存的处理
 2.一言内容的行间距
 3.天气状况中当前温度的高亮处理
 4.加入cells的点击事件
 5.cells的图片插入
 6.将API改成后端的接口
 */

class TCAllFunctionView: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    /*
        之所以后面加？是因为我想把控件的基础设置 都封装到一个函数里面
     */
    var collecitionDataArray : Array = [["体测成绩","一键教评","文档库","失物招领"],["2-1","吐司大事件","电话黄页","2-4"]
    ]
    var models : TCAllFunctionModel = TCAllFunctionModel()
    /*-------------顶部-------------*/
        //日期lbl
    var dayInMonthLabel : UILabel?
        //那根线
    var borderLabel : UILabel?
        //星期lbl
    var dayInWeekLabel : UILabel?
        //当前温度lbl
    var currenTempLabel : UILabel?
        //今日温度范围lbl
    var tempRangeLabel : UILabel?
    
    //属性
    //50
    var dayFontSize : CGFloat{
        get{
            if isIpad{
                return 50*Iphone2IpadScale
            }
            else{
                return 50
            }
        }
    }
    //11
    var smallFontSize : CGFloat{
        get{
            if isIpad{
                return 11*Iphone2IpadScale
            }
            else{
                return 11
            }
        }
    }
    
    /*-------------中间-------------*/
        //标题lbl
    var titleLabel : UILabel?
        //内容lbl
    var contentLabel : UILabel?
        //来源lbl
    var fromLabel : UILabel?
    
    //属性
    let fontColor = UIColor.gray
    //30
    var titleFontSize : CGFloat{
        get{
            if isIpad{
                return 30*Iphone2IpadScale
            }
            else{
                return 30
            }
        }
    }
    //20
    var contenFontSize : CGFloat{
        get{
            if isIpad{
                return 20*Iphone2IpadScale
            }
            else{
                return 20
            }
        }
    }
    //13
    var fromFontSize : CGFloat{
        if isIpad{
            return 13*Iphone2IpadScale
        }
        else{
            return 13
        }
    }
    var contentLineSapcing : CGFloat {
        get{
            if isIpad{
                return 20*Iphone2IpadScale
            }
            else{
                return 10
            }
        }
    }
    var contentHeadingSapcing : CGFloat{
        get{
            if isIpad{
                return 20*Iphone2IpadScale
            }
            else{
                return 20
            }
        }
    }
    let contentFontColor = UIColor.gray
    /*-------------底部-------------*/
        //流式布局
    var collectionView : UICollectionView?
    //属性
    let cellsIdentifier = "collectionCell"
    static let cellWidth : CGFloat = 60
    static let cellLength : CGFloat = 80
    let insetHeight : CGFloat = 30
    let secInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
    let collectionViewBackgroundColor = UIColor.red
    //cell大小
    var cellsSize : CGSize{
        get{
            if isIpad{
                return CGSize.init(width: 60*Iphone2IpadIamgeScale, height: 80*Iphone2IpadIamgeScale)
            }
            else{
                return CGSize.init(width: 60/414*ScreenWidth, height: 80/414*ScreenWidth)
            }
        }
    }
    //image size
    var imageSize : CGSize{
        get{
            if isIpad{
                return CGSize.init(width: 60*Iphone2IpadIamgeScale, height: 60*Iphone2IpadIamgeScale)
            }
            else{
                return CGSize.init(width: 60/414*ScreenWidth, height: 60/414*ScreenWidth)
            }
        }
    }
    //cell列边距
    var cellRow : CGFloat{
        get{
            if isIpad{
                return 30*Iphone2IpadIamgeScale
            }
            else{
                return 20/414*ScreenWidth
            }
        }
    }
    //cell 行边距
    var cellLine : CGFloat{
        get{
            if isIpad{
                return 0
            }
            else{
                return 0
            }
        }
    }
    //cell 的边距
    var cellInset : UIEdgeInsets{
        get{
            let insetValue : CGFloat = 10
            if isIpad{
                return UIEdgeInsets.init(top: insetValue*Iphone2IpadScale, left: insetValue*Iphone2IpadScale, bottom: insetValue*Iphone2IpadScale, right: 0)
            }
            else{
                return UIEdgeInsets.init(top: insetValue, left: insetValue, bottom: insetValue, right: 0)
            }
        }
    }
    /*-------------退出按钮-------------*/
        //退出按钮
    var footButton: UIButton?
    //属性 50
    var footButtonFontSize : CGFloat{
        get{
            if isIpad{
                return 100
            }
            else{
                return 50
            }
        }
    }
    
    
    /*-------------页面设置-------------*/
    public let initBackgroundColor = UIColor.init(white: 1, alpha: 0.8)
    public let presentBackgroundColor = UIColor.init(white: 1, alpha: 0.8)
    func widgetsPrepare(){
        //设置控件的属性
    /*-------------顶部-------------*/
        //日期lbl
        dayInMonthLabel = UILabel()
        dayInMonthLabel!.sizeToFit()
        dayInMonthLabel!.textAlignment = .center
        dayInMonthLabel?.font = UIFont.systemFont(ofSize: dayFontSize)
        dayInMonthLabel?.layer.masksToBounds = true
        self.addSubview(dayInMonthLabel!)
        //线lbl
        borderLabel = UILabel()
        borderLabel?.backgroundColor = UIColor.black
        self.addSubview(borderLabel!)
        //星期lbl
        dayInWeekLabel = UILabel()
        dayInWeekLabel!.sizeToFit()
        dayInWeekLabel!.textAlignment = .left
        dayInWeekLabel!.font = UIFont.systemFont(ofSize: smallFontSize)
        self.addSubview(dayInWeekLabel!)
        //当前温度
        currenTempLabel = UILabel()
        currenTempLabel!.sizeToFit()
        currenTempLabel!.textAlignment = .left
        currenTempLabel!.font = UIFont.systemFont(ofSize: smallFontSize)
        self.addSubview(currenTempLabel!)
        //今日温度
        tempRangeLabel = UILabel()
        tempRangeLabel!.sizeToFit()
        tempRangeLabel!.textAlignment = .left
        tempRangeLabel!.font = UIFont.systemFont(ofSize: smallFontSize)
        self.addSubview(tempRangeLabel!)
        
    /*-------------中间-------------*/
        //标题lbl
        titleLabel = UILabel()
        titleLabel!.sizeToFit()
        titleLabel?.text = "「 一言 」"
        titleLabel!.textAlignment = .center
        titleLabel?.textColor = contentFontColor
        titleLabel!.font = UIFont.systemFont(ofSize: titleFontSize)
        titleLabel?.isUserInteractionEnabled = true
        let tapTitle = UITapGestureRecognizer.init(target: self, action: #selector(open))
        titleLabel?.addGestureRecognizer(tapTitle)
        self.addSubview(titleLabel!)
        //内容lbl
            //内容lbl的textalignment 需要根据内容的长度去改变
            //字体默认大小
            //不需要sizetofit 因为宽度等于屏幕宽度
        contentLabel = UILabel()
        //contentLabel?.text = "加载不粗来啊，轻触重试"
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapLabel))
        contentLabel?.isUserInteractionEnabled = true
        contentLabel?.addGestureRecognizer(tap)
        contentLabel?.numberOfLines = 0
        contentLabel?.lineBreakMode = .byWordWrapping
        contentLabel?.textColor = contentFontColor
        contentLabel?.font = UIFont.systemFont(ofSize: contenFontSize)
        self.addSubview(contentLabel!)
        //来源lbl
        fromLabel = UILabel()
        fromLabel!.textAlignment = .right
        fromLabel!.font = UIFont.systemFont(ofSize: fromFontSize)
        fromLabel?.textColor = contentFontColor
        self.addSubview(fromLabel!)
    /*-------------底部-------------*/
        //流式布局
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 15
//        layout.sectionInset = secInset
        self.collectionView = UICollectionView.init(frame: CGRect.init(), collectionViewLayout: layout)
        self.collectionView?.backgroundColor = nil
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.addSubview(self.collectionView!)
        //register
        self.collectionView?.register(TCCollectionViewCell.self, forCellWithReuseIdentifier: cellsIdentifier)
        /*-------------退出按钮-------------*/
    //退出按钮
        footButton = UIButton()
        footButton?.setTitle("×", for: .normal)
        footButton?.setTitleColor(UIColor.black, for: .normal)
        footButton!.titleLabel?.font = UIFont.systemFont(ofSize: footButtonFontSize)
        footButton!.addTarget(self, action: #selector(footButtonPressed), for: .touchUpInside)
        self.addSubview(footButton!)
        
        self.mask = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.mask?.alpha = 1
        self.mask?.backgroundColor = UIColor.white
        self.addSubview(self.mask!)
    }
    func widgetsAddMas(){
        //给控件添加约束
        self.mask?.snp.makeConstraints({ (make) in
            make.size.equalToSuperview()
        })
        /*-------------顶部-------------*/
        //日期lbl
        dayInMonthLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self).offset(compactHeigh+AlertStatusBarHeight)
            make.left.equalTo(self).offset(compactWidth)
        })
        //那根线lbl
        borderLabel?.snp.makeConstraints({ (make) in
            make.height.equalTo(dayInMonthLabel!)
            make.width.equalTo(1)
            make.top.equalTo(dayInMonthLabel!)
            make.left.equalTo((dayInMonthLabel?.snp.right)!).offset(10)
        })
        //星期lbl
        dayInWeekLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((borderLabel?.snp.right)!).offset(5)
            make.top.equalTo(dayInMonthLabel!)
        })
        //当前温度lbl
        currenTempLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(dayInWeekLabel!)
            make.centerY.equalTo(dayInMonthLabel!)
        })
        //今日温度范围lbl
        tempRangeLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(dayInWeekLabel!)
            make.bottom.equalTo(dayInMonthLabel!)
        })
        
        /*-------------中间-------------*/
        contentLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-ScreenHeight/20)
            make.width.equalTo(ScreenWidth-compactWidth*2)
        })
        titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo((contentLabel?.snp.top)!).offset(-15)
        })
        fromLabel?.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo((contentLabel?.snp.bottom)!).offset(20)
            //make.bottomMargin.equalTo(10)
            //make.bottom.lessThanOrEqualTo(collectionView!.snp_top)
        })
        /*-------------退出按钮-------------*/
        //退出按钮
        footButton?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        })
        /*-------------底部-------------*/
//        let height : CGFloat
//        if isIpad {
//            height = ScreenHeight/4
//        }
//        else{
//            height = 220
//        }
        //流式布局
        collectionView?.snp.makeConstraints({ (make) in
            make.bottom.equalTo((footButton?.snp.top)!).offset(20)
            //宽度等于cells的宽度 加上列边距 加上cell的边距
            make.width.equalTo(cellsSize.width*4+cellRow*3+cellInset.left*2*2)
            //make.width.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            //高度等于cells的高度 加上行边距 加上cell的边距
            make.height.equalTo(cellsSize.height*2+cellLine+cellInset.top*2*2)
        })
        print(ScreenWidth,ScreenHeight,cellsSize.width,cellsSize.height)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        //页面设置
        self.backgroundColor = initBackgroundColor
        self.models.loadData {
            self.giveDataToView()
        }
        self.widgetsPrepare()
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.widgetsAddMas()
    }
    @objc func footButtonPressed() ->Void{
        self.removeFromSuperview()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not be implemented")
    }
    //MARK: - 给view赋值
    func giveDataToView(){
        /* 上
         var dayInMonthLabel : UILabel?
         //星期lbl
         var dayInWeekLabel : UILabel?
         //当前温度lbl
         var currenTempLabel : UILabel?
         //今日温度范围lbl
         var tempRangeLabel : UILabel?
         */
        
        self.dayInMonthLabel?.text = self.models.dateInfoSource?.dayInMonth
        self.dayInWeekLabel?.text = self.models.dateInfoSource?.dayInWeek
        
        currenTempLabel?.attributedText = self.models.weatherDataSource?.currentTemp
        tempRangeLabel?.text = self.models.weatherDataSource?.tempRangeAndStatus
        
        contentLabel?.text = self.models.yiYanDataSource?.content
        contentLabel?.textAlignment = self.models.yiYanDataSource?.textAlign ?? .center
        fromLabel?.text = self.models.yiYanDataSource?.from
        
        
//        //让-4变色
//        let targetStr = self.models.weatherDataSource?.currentTemp
//        let attr :NSMutableAttributedString = NSMutableAttributedString.init(string: targetStr!)
//        let hightlightStr :String = "-4"
//        let theRange = targetStr!.range(of: hightlightStr)
//        let theNSRange = NSRange(theRange!, in: targetStr!)
//        attr.addAttribute(.foregroundColor, value: UIColor.blue, range: theNSRange)
//
//        self.currenTempLabel?.attributedText = attr
        //self.currenTempLabel?.text = self.models.weatherDataSource?.currentTemp

//        let index :NSInteger = self.models.yiYanDataSource?.presentAt ?? 0
//        self.contentLabel?.text = self.models.yiYanDataSource?.contents[index].content
//        self.contentLabel?.textAlignment = (self.models.yiYanDataSource?.contents[index].textAlign) ?? .center
//        let paraStyle = NSMutableParagraphStyle()
//        paraStyle.lineSpacing = contentLineSapcing
//        paraStyle.headIndent = contentHeadingSapcing
////        let attributeStr = NSMutableAttributedString.init(string: (self.contentLabel?.text)!, attributes: [NSAttributedString.Key.paragraphStyle:paraStyle])
////        self.contentLabel?.attributedText = attributeStr
//        self.fromLabel?.text = self.models.yiYanDataSource?.contents[index].from
        
        //        let index = fcModel?.yiYanDataSource?.presentAt
        //        fcView?.titleLabel?.text = fcModel?.yiYanDataSource?.Title
        //        fcView?.contentLabel?.text = fcModel?.yiYanDataSource?.contents[index!].content
        //        fcView?.fromLabel?.text = fcModel?.yiYanDataSource?.contents[index!].from
        // 下
        
    }
    @objc func tapLabel(){
        if contentLabel?.text == "电波无法到达～轻触重试"{
            self.models.loadData {
                self.giveDataToView()
            }
        }
        else{
            self.models.gettingYiyan {
                self.contentLabel?.text = self.models.yiYanDataSource?.content
                self.contentLabel?.textAlignment = self.models.yiYanDataSource?.textAlign ?? .center
                self.fromLabel?.text = self.models.yiYanDataSource?.from
            }
        }
    }
    @objc func open(){
        let url = URL.init(string: "https://hitokoto.cn/")
        UIApplication.shared.open(url!, options: [ : ], completionHandler: nil)
    }
    
    
    
    //MARK: - collectionview datasource协议内容
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //print("numberofsections")
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("numberofIntems")
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cells : TCCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsIdentifier, for: indexPath) as! TCCollectionViewCell
        if indexPath == [1,0] || indexPath == [1,3]{
            cells.isHidden = true
        }
        else{
            let cellsName : String = collecitionDataArray[indexPath.section][indexPath.row]
            cells.lbl?.text = cellsName
            let img = SVGKImage.init(named: "\(cellsName).svg")
            img?.size = imageSize
            cells.imageView?.image = img?.uiImage
        }
        return cells
    }
    //MARK: - collectionview delegateFlowLayout协议内容
    //每个cells的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellsSize
    }
    //cells之间的行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellLine
    }
    //cells之间的列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellRow
    }
    //cells群上下左右的边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return cellInset
    }

    
    

}
