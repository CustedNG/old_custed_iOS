//
//  AlertTableView.swift
//  Custed
//
//  Created by faker on 2019/4/22.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
protocol AlertTableViewProtocol:class{
    func clickAlertCells(with:Int)
}
class AlertTableView: UITableView,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil{
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        cell!.textLabel?.text = dataArray[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.alertDelegate?.clickAlertCells(with: indexPath.row)
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.alertDelegate?.clickAlertCells(with: indexPath.row)
        return nil
    }
    let visibleFrame:CGRect
    let onsetFrame:CGRect
    weak var alertDelegate: AlertTableViewProtocol?
    private let dataArray:Array<String>
    private let identifier="cellsForAlert"
    init(dataSouce:Array<String>) {
        visibleFrame = CGRect.init(x: ScreenWidth*2/3, y: StatusBarheight+NavigationHeight, width: ScreenWidth/3, height: CGFloat(dataSouce.count*40))
        dataArray = dataSouce
        onsetFrame = CGRect.init(x: ScreenWidth*2/3, y: StatusBarheight+NavigationHeight, width: ScreenWidth/3, height: 0)
        super.init(frame: onsetFrame, style: .plain)
        self.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        self.delegate = self
        self.dataSource = self
        self.isScrollEnabled = false
        self.rowHeight = 40
        self.backgroundColor = UIColor.white
        
    }
    
    func Show(){
        let window:UIWindow = ((UIApplication.shared.delegate?.window)!)!
        //这一行是为了防止课程表中，课程详情弹出的时候，自身也能被点击
        //其实这个类不应该写的，但是我之前没想好，又当条懒狗，所以把自身的层级关系放到下面，以后这个类一定要改。
        window.insertSubview(self, at: 1)
        self.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.visibleFrame
        })
    }
    func Hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.onsetFrame
        }) { (no) in
            self.isHidden = false
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
