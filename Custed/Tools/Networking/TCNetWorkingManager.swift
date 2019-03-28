//
//  TCNetWorkingManager.swift
//  Custed
//
//  Created by faker on 2019/3/28.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class TCNetWorkingManager: NSObject {
    static let shared:TCNetWorkingManager = TCNetWorkingManager()
    private let datecompare:DateComponentsFormatter = DateComponentsFormatter.init()
    override init() {
        self.datecompare.unitsStyle = .positional
        self.datecompare.allowedUnits = [.second]
    }
    func settingTakenID(id:String,pass:String) -> Void {
        //判断session有没有过期，如果过期重新获取
        let lateDate = UserDefaults.standard.value(forKey: "lastDate")
        if lateDate == nil{
            //没date数据
            self.updateOrGettingID(id: id, pass: pass)
        }
        else{
            //有date数据，有的话就不用做操作了，没有重新拉
            let interval = Int(datecompare.string(from: lateDate as! Date, to: Date())!)
            if interval! >= 259000{
                self.updateOrGettingID(id: id, pass: pass)
            }
        }
    }
    private func updateOrGettingID(id:String,pass:String) -> Void {
        let headers = [
            "accept": "application/vnd.toast+json",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let para = [
            "cust_id":id,
            "cust_pass":pass
        ]
        let url = "https://beta.tusi.site/app/v1/user/session"
        Alamofire.request(url, method: .post, parameters: para, encoding: URLEncoding.default,headers: headers).responseJSON { (response) in
            guard response.result.isSuccess else{
                print("session接口错误",JSON(response.data!)["msg"])
                return
            }
            let nowDate = Date()
            let json = JSON(response.data!)
            UserDefaults.standard.setValue(json["data"]["token_value"].stringValue, forKey: "token_name")
            UserDefaults.standard.setValue(nowDate, forKey: "lastDate")
        }
    }
    
}
