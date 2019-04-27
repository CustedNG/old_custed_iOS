//
//  TCAccountModel.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class Info:NSObject,NSCoding,NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    var sex:String?
    var university:String?
    var major:String?
    var realname:String?
    var student_id:Int?
    var cid:Int?
    var college:String?
    var role:String?
    var cust_id:String?
    var avatar:String?
    var reg_time:String?
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.sex, forKey: "sex")
        aCoder.encode(self.university, forKey: "university")
        aCoder.encode(self.major, forKey: "major")
        aCoder.encode(self.realname, forKey: "realname")
        aCoder.encode(self.student_id, forKey: "student_id")
        aCoder.encode(self.cid, forKey: "cid")
        aCoder.encode(self.college, forKey: "college")
        aCoder.encode(self.role, forKey: "role")
        aCoder.encode(self.cust_id, forKey: "cust_id")
        aCoder.encode(self.avatar, forKey: "avatar")
        aCoder.encode(self.reg_time, forKey: "reg_time")
    }
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.sex = aDecoder.decodeObject(forKey: "sex") as? String
        self.university = aDecoder.decodeObject(forKey: "university") as? String
        self.major = aDecoder.decodeObject(forKey: "major") as? String
        self.realname = aDecoder.decodeObject(forKey: "realname") as? String
        self.student_id = aDecoder.decodeObject(forKey: "student_id") as? Int
        self.cid = aDecoder.decodeObject(forKey: "cid") as? Int
        self.college = aDecoder.decodeObject(forKey: "college") as? String
        self.role = aDecoder.decodeObject(forKey: "role") as? String
        self.cust_id = aDecoder.decodeObject(forKey: "cust_id") as? String
        self.avatar = aDecoder.decodeObject(forKey: "avatar") as? String
        self.reg_time = aDecoder.decodeObject(forKey: "reg_time") as? String
    }
}

class TCAccountModel: NSObject {
    var info:Info?
    let archiveName = "Account.archiver"
    override init() {
        super.init()
        
        //request()
    }
    func gettingInfo(completedDo:@escaping () -> Void){
        //如果有缓存 拉缓存
        if TCCacheManager.shared.archiveExist(name: archiveName){
            self.info = TCCacheManager.shared.unarchive(name: archiveName) as? Info
            completedDo()
            return
        }
        self.info = Info()
        let header = ["accept": "application/vnd.toast+json"]
        let url = "https://beta.tusi.site/app/v1/user/info/"
        let response = Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default , headers: header) .response{ (response) in
            guard response.response?.statusCode == 200 else{
                print("信息请求失败")
                return
            }
            
            let json = JSON(response.data!)
            //print(response.data!)
            //print(json)
            self.info?.sex = json["data"]["sex"].stringValue
            self.info?.university = json["data"]["university"].stringValue
            self.info?.major = json["data"]["major"].stringValue
            self.info?.realname = json["data"]["realname"].stringValue
            self.info?.student_id = json["data"]["student_id"].intValue
            self.info?.cid = json["data"]["cid"].intValue
            self.info?.college = json["data"]["college"].stringValue
            self.info?.role = json["data"]["role"].stringValue
            self.info?.cust_id = json["data"]["cust_id"].stringValue
            DispatchQueue.global(qos: .background).async {
                TCCacheManager.shared.softArchive(object: self.info!, name: self.archiveName)
            }
            completedDo()
            
        }
        debugPrint(response)
    }

}
