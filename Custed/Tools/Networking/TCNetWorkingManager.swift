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
import Foundation
import SwiftKeychainWrapper
class TCNetWorkingManager: NSObject {
    static let shared:TCNetWorkingManager = TCNetWorkingManager()
    private let datecompare:DateComponentsFormatter = DateComponentsFormatter.init()
    override init() {
        self.datecompare.unitsStyle = .positional
        self.datecompare.allowedUnits = [.second]
    }
//    func request(
//        url:URLConvertible,
//        method:HTTPMethod = .get,
//        parameters:Parameters? = nil,
//        encoding:ParameterEncoding = URLEncoding.default,
//        headers:HTTPHeaders=[
//        "accept": "application/vnd.toast+json",
//        "custed-token" : UserDefaults.standard.value(forKey: "custed-token") as! String
//        ],
//        responseQueue : DispatchQueue = DispatchQueue.main,
//        completeDo:@escaping ()->Void)
//        -> DataRequest{
//
//            let response = Alamofire.request(url, method: method, parameters: parameters, encoding: encoding,headers: headers).responseJSON(queue:responseQueue) { (response) in
//                completeDo()
//            }
//            return response
//        }
    func gettingTakenID() -> String {
        //判断session有没有过期，如果过期重新获取
//        UserDefaults.standard.value(forKey: "cust")
        let lateDate = UserDefaults.standard.value(forKey: "lastDate")
        //print(lateDate)
        var tokenID:String = ""
        if lateDate == nil{
            //没date数据
            let id = KeychainWrapper.defaultKeychainWrapper.string(forKey: "Username")!
            let pass = KeychainWrapper.defaultKeychainWrapper.string(forKey: "Password")!
            self.updateOrGettingID(id: id, pass: pass,completedDo: { (token) in
                tokenID = token
                //print(token)
            })
        }
        else{
            //有date数据，有的话就不用做操作了，没有重新拉
            let str = datecompare.string(from: lateDate as! Date, to: Date())!
            let str2 = str.replacingOccurrences(of: ",", with: "")
            let interval = Int(str2)
            if interval! >= 259000{
                self.updateOrGettingID(id: KeychainWrapper.defaultKeychainWrapper.string(forKey: "Username")!, pass: KeychainWrapper.defaultKeychainWrapper.string(forKey: "Password")!,completedDo: { (token) in
                    tokenID = token
                    //print(token)
                })
            }
            else{
                tokenID = UserDefaults.standard.value(forKey: "custed-token") as! String
            }
        }
        //print(tokenID)
        return tokenID
    }
    func updateOrGettingID(id:String,pass:String,completedDo:((String)->Void)?=nil ) -> Void {
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
            guard response.response?.statusCode == 200 else{
                completedDo?(JSON(response.data!)["msg"].string ?? "请求错误")
                return
            }
            let nowDate = Date()
            let json = JSON(response.data!)
            //debugPrint(response)
            UserDefaults.standard.setValue(json["data"]["token_value"].stringValue, forKey: "custed-token")
            UserDefaults.standard.setValue(nowDate, forKey: "lastDate")
            let resultStr = "请求成功"
            completedDo?(resultStr)
            
        }
    }
    
//    func logOut() -> Void {
//        <#function body#>
//    }
    
}
