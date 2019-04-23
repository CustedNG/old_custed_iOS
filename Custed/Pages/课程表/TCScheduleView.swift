//
//  TCScheduleVIew.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SVGKit
protocol ScheduleViewProtocol:class,UICollectionViewDataSource {
    func clickCells(collectionView:UICollectionView,cell:cellsForScheduleView,index:IndexPath)
    func AlertCancel()
}
class TCScheduleView: UIView,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (ScreenWidth-15-3*7)/7, height: itemHeighe)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0{
            return UIEdgeInsets.init(top: 0, left: 15, bottom: 5, right: 3)
        }
        return UIEdgeInsets.init(top: 0, left: 15, bottom: 5, right: 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        collectionView.flashScrollIndicators()
//        print("content:",collectionView.contentScaleFactor)
//        print("cone",collectionView.scrollIndicatorInsets)
//        print(cell?.frame.origin)
//        print(collectionView.layoutAttributesForItem(at: indexPath))
        print(collectionView.contentOffset)
        self.delegate?.clickCells(collectionView:collectionView,cell: cell as! cellsForScheduleView, index: indexPath)
    }
    weak var delegate:ScheduleViewProtocol?
    var dayInWeekLabels = Array<UILabel>()
    var dayInMonthLabels = Array<UILabel>()
    var classSchedule:UICollectionView!
    let cellsIdentifier = "classScheduleCells"
    let headerIdentifier = "headers"
    let headerLabelWidth:CGFloat = (ScreenWidth-15)/7
    let headerLabelheight:CGFloat = 22.0
    let collectionViewHeight:CGFloat = ScreenHeight - NavigationHeight - 2*22.0 - TabBarHeight - StatusBarheight
    var itemHeighe:CGFloat = (ScreenHeight - NavigationHeight - 2*22.0 - TabBarHeight - StatusBarheight - 5*5 - 2)/6
    
    //(ScreenHeight-NavigationHeight-2*22.0-TabBarHeight-2*5)/6
    var showedCellFrame:CGRect!
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("no")
    }
    func widgetsPrepare(){
        let array = ["周一","周二","周三","周四","周五","周六","周日"]
        let bordFontSize:CGFloat = 13*ScreenWidth/414
        let firstElementWidth:CGFloat = 15.0
        print(itemHeighe)
        let headerBackgroundColor = UIColor.init(displayP3Red: 0.929, green: 0.961, blue: 0.996, alpha: 1.0)
        for i in 0..<8{
            let DIWLabel = UILabel()
            let DIMLabel = UILabel()
            dayInMonthLabels.append(DIMLabel)
            dayInWeekLabels.append(DIWLabel)
            self.addSubview(DIWLabel)
            self.addSubview(DIMLabel)
            DIMLabel.textAlignment = .center
            DIMLabel.backgroundColor = headerBackgroundColor
            DIMLabel.font = UIFont.systemFont(ofSize: bordFontSize)
            
            DIWLabel.textAlignment = .center
            DIWLabel.backgroundColor = headerBackgroundColor
            DIWLabel.font = UIFont.boldSystemFont(ofSize: bordFontSize)
            if i == 0{
                DIWLabel.frame = CGRect.init(x: 0, y: 0, width:firstElementWidth, height: headerLabelheight)
                DIMLabel.frame = CGRect.init(x: 0, y: headerLabelheight, width: firstElementWidth, height: headerLabelheight)
                DIMLabel.text = "月"
                continue
            }
            DIWLabel.text = array[i-1]
            DIWLabel.frame = CGRect.init(x: firstElementWidth+CGFloat(i-1)*headerLabelWidth, y: 0.0, width: headerLabelWidth, height: headerLabelheight)
            
            DIMLabel.frame = CGRect.init(x: firstElementWidth+CGFloat(i-1)*headerLabelWidth, y: headerLabelheight, width: headerLabelWidth, height: headerLabelheight)
        }
        
        
        //课表
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        classSchedule = UICollectionView.init(frame: CGRect.init(x: 0, y: headerLabelheight*2, width: ScreenWidth, height: collectionViewHeight), collectionViewLayout: layout)
        classSchedule.register(cellsForScheduleView.self, forCellWithReuseIdentifier: cellsIdentifier)
        classSchedule.flashScrollIndicators()
        classSchedule.backgroundColor = UIColor.white
        if itemHeighe <= 80{
            itemHeighe = 80
        }
        let slide = headerForClassSchedule.init(itemsHeight: itemHeighe, viewHeight: collectionViewHeight)
        classSchedule.addSubview(slide)
        slide.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        classSchedule.delegate = self
        classSchedule.dataSource = delegate
        self.addSubview(classSchedule)
        
    }
    @objc func cancelAlert(){
        print("cancel")
        self.delegate?.AlertCancel()
    }
    @objc func arrowButtonClicked(){
        print("clicked")
    }

}
