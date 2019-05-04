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
import Foundation
/// Description:KeyChain for sensitive data ,plist for user preferences
class TCUserManager: NSObject {
    static let shared = TCUserManager()
    private let datecompare:DateComponentsFormatter = DateComponentsFormatter.init()
    var filePath:String
    var cookiesDic : [String:String]?
    
    private var _isLogin:Bool
    public var isLogin:Bool{
        get{
            return _isLogin
        }
    }
    override init() {
        //Libarary/Preferences/
        filePath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString).strings(byAppendingPaths: ["Preferences"])[0]
        self._isLogin = false //default is false
        super.init()
        self.datecompare.unitsStyle = .positional
        self.datecompare.allowedUnits = [.second]
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
        UserDefaults.standard.removeObject(forKey: "Etag")
        UserDefaults.standard.removeSuite(named: "gradeEtag")
        TCCacheManager.shared.emptyCaches()
        self._isLogin = false
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
            // clear away cookies after request, because cookies are required to this request
            if HTTPCookieStorage.shared.cookies != nil{
                for i in HTTPCookieStorage.shared.cookies!{
                    HTTPCookieStorage.shared.deleteCookie(i)
                }
            }
        }
    }
    func logIn(id:String,pass:String,completedDo:((String)->Void)?=nil ) -> Void {
        let headers = [
            "accept": "application/vnd.toast+json",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let para = [
            "cust_id":id,
            "cust_pass":pass
        ]
        print(id,pass)
        let url = "https://beta.tusi.site/app/v1/user/session"
        let response = Alamofire.SessionManager.ephemeral.request(url, method: .post, parameters: para, encoding: URLEncoding.default,headers: headers).response { (response) in
            guard response.response?.statusCode == 200 else{
                completedDo?("请求错误")
                //debugPrint(response)
                return
            }
            let nowDate = Date.init(timeIntervalSinceNow: 0)
            //let json = JSON(response.data!)
            //debugPrint(response)
            KeychainWrapper.defaultKeychainWrapper.set(id, forKey: "Username")
            KeychainWrapper.defaultKeychainWrapper.set(pass, forKey: "Password")
            let headerFields = response.response?.allHeaderFields as? [String: String]
            self.cookiesDic = headerFields
            let Url = response.request?.url
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields!, for: Url!)
            HTTPCookieStorage.shared.setCookies(cookies, for: Url!, mainDocumentURL:nil)
            UserDefaults.standard.setValue(nowDate, forKey: "lastDate")
            UserDefaults.standard.setValue(true, forKey: "isLogin")
            self._isLogin = true
            let resultStr = "请求成功"
            print("----拿到token了")
            completedDo?(resultStr)
        }
        debugPrint(response)
        
    }
    func getTokenValue() ->String?{
        let value = UserDefaults.standard.string(forKey: "custed-token")
        return value
    }
    func updateTakenValueValidTime(){
        if KeychainWrapper.defaultKeychainWrapper.string(forKey: "Username") == nil{
            return
        }
        //let lateDate = UserDefaults.standard.value(forKey: "lastDate")
        
        //if cookies had expired,for that,the value of HTTPCookieStorage.shared.cookies will be []
        print(HTTPCookieStorage.shared.cookies)
        if HTTPCookieStorage.shared.cookies == [] {
            print("正在拿token")
            let id = KeychainWrapper.defaultKeychainWrapper.string(forKey: "Username")!
            let pass = KeychainWrapper.defaultKeychainWrapper.string(forKey: "Password")!
            self.logIn(id: id, pass: pass)
        }
    }
}

