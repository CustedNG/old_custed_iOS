//
//  TCUserManager.swift
//  Custed
//
//  Created by faker on 2019/4/7.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Alamofire
import SwiftyJSON
/// Description:KeyChain for sensitive data ,plist for user preferences
class TCUserManager: NSObject {
    static let shared = TCUserManager()
    var filePath:String
    override init() {
        //Libarary/Preferences/
        filePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString).strings(byAppendingPaths: ["Preferences"])[0]
        super.init()
    }
    //plist operation
    func write(dictionary:NSDictionary,name:String) -> Void{
        let fullName = name+".plist"
        let path = (filePath as NSString).strings(byAppendingPaths: [fullName])[0]
        dictionary.write(toFile: path, atomically:true)
        print(path)
    }
    func read(name:String) -> NSDictionary?{
        let fullPath = (filePath as NSString).strings(byAppendingPaths: [name+".plist"])[0]
        return NSDictionary.init(contentsOfFile: fullPath)
    }

    //keyChain
    func logOut() -> Void{
        //清除本地的用户缓存
        KeychainWrapper.defaultKeychainWrapper.removeAllKeys()
        UserDefaults.standard.removeObject(forKey: "isLogin")
        UserDefaults.standard.removeObject(forKey: "custed-token")
        UserDefaults.standard.removeObject(forKey: "lastDate")
        //delete preferences
        let url = "https://beta.tusi.site/app/v1/user/session"
        let header = ["accept": "application/vnd.toast+json"]
        Alamofire.request(url, method: .delete, parameters: nil, headers: header).response { (response) in
            if response.response?.statusCode == 200{
                TCToast.showWithMessage("退出成功")
            }
            else if response.response?.statusCode == 403{
                TCToast.showWithMessage("会话不存在或已注销")
            }
        }
    }
//    func logIn(Username:String,password:String) -> Void {
//        KeychainWrapper.defaultKeychainWrapper.set(Username, forKey: "Username")
//        KeychainWrapper.defaultKeychainWrapper.set(password, forKey: "Password")
//    }
    func logIn(id:String,pass:String,completedDo:((String)->Void)?=nil ) -> Void {
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
                //TCToast.showWithMessage("session接口请求错误:\(JSON(response.data!)["msg"].stringValue)")
                completedDo?(JSON(response.data!)["msg"].string ?? "请求错误")
                return
            }
            let nowDate = Date()
            let json = JSON(response.data!)
            //debugPrint(response)
            UserDefaults.standard.setValue(true, forKey: "isLogin")
            KeychainWrapper.defaultKeychainWrapper.set(id, forKey: "Username")
            KeychainWrapper.defaultKeychainWrapper.set(pass, forKey: "Password")
            UserDefaults.standard.setValue(json["data"]["token_value"].stringValue, forKey: "custed-token")
            UserDefaults.standard.setValue(nowDate, forKey: "lastDate")
            let resultStr = "请求成功"
            completedDo?(resultStr)
            
        }
    }
    
}
