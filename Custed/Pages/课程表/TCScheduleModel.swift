//
//  TCScheduleModel.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
class dataAfterParsing:NSObject,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ScheduleForWeeks,forKey: "SFK")
        aCoder.encode(currentWeeks,forKey: "currentWeeks")
        aCoder.encode(schedule,forKey: "schedule")
        aCoder.encode(semester,forKey: "semester")
        aCoder.encode(lessonColorIndex,forKey: "lessonColorIndex")
        aCoder.encode(semesterStartTime,forKey: "semesterStartTime")
        aCoder.encode(weeksCount,forKey: "weeksCount")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.ScheduleForWeeks = aDecoder.decodeObject(forKey: "SFK") as! Dictionary<Int, [Int : [Int : lesson]]>
        self.currentWeeks = aDecoder.decodeInteger(forKey: "currentWeeks")
        self.schedule = aDecoder.decodeObject(forKey: "schedule") as! [Int : [String]]
        self.semester = aDecoder.decodeObject(forKey: "semester") as! String
        self.lessonColorIndex = aDecoder.decodeObject(forKey: "lessonColorIndex") as! [String:Int]
        self.semesterStartTime = aDecoder.decodeObject(forKey: "semesterStartTime") as? Date
        self.weeksCount = aDecoder.decodeInteger(forKey: "weeksCount")
        
    }
    override init() {
        self.ScheduleForWeeks = Dictionary<Int,[Int:[Int:lesson]]>()
        self.currentWeeks = 0
        self.schedule = Dictionary<Int,[String]>()
        self.semester = ""
        self.weeksCount = 0
        self.lessonColorIndex = [String:Int]()
        super.init()
    }
    
    //week:[day:[[start_section:lesson]]]
    var ScheduleForWeeks:[Int:[Int:[Int:lesson]]]
    var currentWeeks:Int
    //第几周：【几月，几日，几日】
    var schedule:[Int:[String]] //
    var semester:String //标题的那个学期
    var lessonColorIndex:[String:Int] //课程名字：颜色表中的index
    var semesterStartTime:Date? //学期开始的时间
    var weeksCount:Int //这个学期有多少周
}
class TCScheduleModel: NSObject{
    var model:Schedule?
    var data:dataAfterParsing = dataAfterParsing.init()
    var othersColor : UIColor = UIColor.init(red: 0.851, green: 0.314, blue: 0.475, alpha: 1.0)
    var colorArray = [
        UIColor.FromRGB(RGB: 0xc49d62),
        UIColor.FromRGB(RGB: 0xb2bbb8),
        UIColor.FromRGB(RGB: 0xa1aaa7),
        UIColor.FromRGB(RGB: 0x6e7d66),
        UIColor.FromRGB(RGB: 0xbc9e7a),
        UIColor.FromRGB(RGB: 0x8eab8f),
        UIColor.FromRGB(RGB: 0x99544f),
        UIColor.FromRGB(RGB: 0x894d45),
        UIColor.FromRGB(RGB: 0x86ada8),
        UIColor.FromRGB(RGB: 0xaf8c64),
        UIColor.FromRGB(RGB: 0x714b4a),
        UIColor.FromRGB(RGB: 0xb1735a),
        UIColor.FromRGB(RGB: 0x6b707c),
        UIColor.FromRGB(RGB: 0xafbba5),
        UIColor.FromRGB(RGB: 0x7c7774),
        UIColor.FromRGB(RGB: 0xbcb2a8),
        UIColor.FromRGB(RGB: 0x6e6458),
        UIColor.FromRGB(RGB: 0xa88476),
        UIColor.FromRGB(RGB: 0x3a466e),
        UIColor.FromRGB(RGB: 0x6b707c),
        UIColor.FromRGB(RGB: 0xb08670)
    ]
    var weeks = [
        "第一周",
        "第二周",
        "第三周",
        "第四周",
        "第五周",
        "第六周",
        "第七周",
        "第八周",
        "第九周",
        "第十周",
        "第十一周",
        "第十二周",
        "第十三周",
        "第十四周",
        "第十五周",
        "第十六周",
        "第十七周",
        "第十八周",
        "第十九周",
        "第二十周",
        "第二十一周",
        "第二十二周",
        "第二十三周",
        "第二十四周"
    ]
    var archivedFileName:String = "schedule.archiver"
    private let weekdays:NSArray = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
    func convertSectionRuleTime(dateStr : String) ->[Int]{
        let datef = DateFormatter.init()
        datef.dateFormat = "HH:mm"
        let str = datef.date(from: dateStr) ?? datef.date(from: "00:00")
        let datec = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: 3600*8)!, from: str!)
        return [datec.hour!,datec.minute!]
    }
    /// Description: Calling this function in every viewdidload called
    ///
    /// - Parameters:
    ///   - completedDo:
    func getScheduleData(completedDo:@escaping ()->Void) -> Void{
        var flag:Bool = false
        gettingEtag(completedDo: { (isGttingDataFromRemote) in
            if isGttingDataFromRemote == true{
                let queue = DispatchQueue.global(qos: .default)
                let group = DispatchGroup.init()
//                queue.sync {
//                    //TCUserManager.shared.updateTakenValueValidTime()
//                }
                group.enter()
                queue.sync {
                    let url = "https://beta.tusi.site/app/v1/cust/jwgl/schedule/"
                    let headers = [
                        "accept": "application/vnd.toast+json"
                    ]
                    Alamofire.SessionManager.timeOut.request(url,headers:headers).response(queue: queue, completionHandler:{ DefaultDataResponse in
                        //debugPrint(DefaultDataResponse)
                        guard DefaultDataResponse.response?.statusCode == 200 else{
                            if TCCacheManager.shared.archiveExist(name: self.archivedFileName) == true{
                                self.data = TCCacheManager.shared.unarchive(name: self.archivedFileName) as! dataAfterParsing
                            }
                            else{
                                DispatchQueue.main.async {
                                    TCToast.showWithMessage("网络异常～\(DefaultDataResponse.response?.statusCode)")
                                }
                                
                            }
                            //                            completedDo()
                            group.leave()
                            return
                        }
                        do{
                            let decoder = JSONDecoder()
                            print(true)
                            self.model = try decoder.decode(Schedule.self, from: DefaultDataResponse.data!)
                            let responseHeaders = DefaultDataResponse.response?.allHeaderFields as! [String:String]
                            let Url = DefaultDataResponse.request?.url
                            //let cookies = HTTPCookie.cookies(withResponseHeaderFields: responseHeaders, for: Url!)
                            //print(cookies)
                            //HTTPCookieStorage.shared.setCookies(cookies, for: Url!, mainDocumentURL: nil)
                            let now = Date.init(timeIntervalSinceNow: 0)
                            UserDefaults.standard.setValue(now, forKey: "lastDate")
                            UserDefaults.standard.synchronize()
                            self.parseData()
                            flag = true
                            group.leave()
                            //重用了
                        }catch{
                            print("\(error)")
                            group.leave()
                        }
                    })
                    
                    group.notify(queue: queue, execute: {
                        if flag == true{
                            DispatchQueue.main.sync {
                                completedDo()
                            }
                        }
                        
                    })
                    
                }
            }
            else{
                if TCCacheManager.shared.archiveExist(name: self.archivedFileName) == true{
                    self.data = TCCacheManager.shared.unarchive(name: self.archivedFileName) as! dataAfterParsing
                }
                else{
                    TCToast.showWithMessage("获取缓存失败")
                    return
                }
                completedDo()
            }
            
        })}
    /// Description:Getting etag
    ///
    /// - Returns:if statusCode == 200 return true ==304 return false
    func gettingEtag(completedDo:@escaping (Bool)->Void)->Void{
//        completedDo(true)
//        return
        if NetworkReachabilityManager()?.isReachable == false{
            completedDo(false)
            return
        }
        var flag:Bool = true
        let headers = [
            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
            "if-none-match":UserDefaults.standard.string(forKey: "Etag") ?? ""
        ]
        let url1 = "https://app.cust.edu.cn/schedule"
        Alamofire.SessionManager.ephemeral.request(url1,headers:headers).response { (DefaultDataResponse) in
            if DefaultDataResponse.response?.statusCode == Optional(200){
                let etag:String = DefaultDataResponse.response?.allHeaderFields["Etag"] as! String
                //debugPrint(DefaultDataResponse)
                UserDefaults.standard.setValue(etag, forKey: "Etag")
                flag = true
                print("判断完etag了")
                completedDo(flag)
            }
            else{
                flag = false
                print("判断完etag了")
                completedDo(flag)
            }
        }
        
    }
    /// Description: force to update from remote
    ///
    /// - Parameter completedDo: do after completed
    func forceUpdate(completedDo:@escaping (Bool)->Void){
        let url = "https://beta.tusi.site/app/v1/cust/jwgl/schedule/remote"
        let headers = [
            "accept": "application/vnd.toast+json"
        ]
        let res = Alamofire.SessionManager.timeOut.request(url,headers:headers).response { (DefaultDataResponse) in
            debugPrint(DefaultDataResponse)
            guard DefaultDataResponse.response?.statusCode == 200 else{
                TCToast.showWithMessage("网络异常～\(String(describing: DefaultDataResponse.response?.statusCode))")
                completedDo(false)
                return
            }
            do{
                let decoder = JSONDecoder()
                self.model = try decoder.decode(Schedule.self, from: DefaultDataResponse.data!)
                //print(DefaultDataResponse.request?.allHTTPHeaderFields)
                //print(DefaultDataResponse.response?.statusCode)
                //print(DefaultDataResponse.data!)
                //let responseHeaders = DefaultDataResponse.response?.allHeaderFields as! [String:String]
                //let Url = DefaultDataResponse.request?.url
                //let cookies = HTTPCookie.cookies(withResponseHeaderFields: responseHeaders, for: Url!)
                //print(cookies)
                //HTTPCookieStorage.shared.setCookies(cookies, for: Url!, mainDocumentURL: nil)
                let now = Date.init(timeIntervalSinceNow: 0)
                UserDefaults.standard.setValue(now, forKey: "lastDate")
                UserDefaults.standard.synchronize()
                self.parseData()
                completedDo(true)
            }catch{
                print("\(error)")
            }
        }
        print(HTTPCookieStorage.shared.cookies)
        debugPrint(res)
    }
    func parseData()->Void{
        self.data.lessonColorIndex = [String:Int]()
        var index:Int = .random(in: 0..<20)
        self.data.weeksCount = self.model!.data.table.weeks_count
        for i in 1...self.data.weeksCount{
            self.data.ScheduleForWeeks[i] = [ Int:[Int:lesson]]()
        }
        for (_,value) in (self.model?.data.table.lessons)!{
            //找名字和找颜色
            if value.lesson_name == ""{
                let subject_uid = value.subject_uid
                if subject_uid != ""{
                    value.lesson_name = (self.model?.data.table.subjects[subject_uid]!.subject_name)!
                }
                
                if self.data.lessonColorIndex[value.lesson_name] == nil{
                    self.data.lessonColorIndex[value.lesson_name] = index%20
                    index += 1
                }
            }
            //找时间
            value.start_time = (self.model?.data.section_rules[String(value.lesson_type)]?.rules[String(value.start_section)]!.start_time)!
            value.end_time = (self.model?.data.section_rules[String(1)]?.rules[String(value.end_section)]!.end_time)!
            //整出每周的课表
            for week in value.weeks{
                if self.data.ScheduleForWeeks[week]![value.week_day] == nil{
                    self.data.ScheduleForWeeks[week]![value.week_day] = [value.start_section:value]
                }
                else{
                    self.data.ScheduleForWeeks[week]![value.week_day]![value.start_section] = value
                }
            }
        }
        let datef = DateFormatter.init()
        datef.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let str = datef.date(from: self.model?.data.table.start_date ?? "")
        self.data.semesterStartTime = str!
        var datec = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: 3600*8)!, from: str!)
        let nowDate = Date.init(timeIntervalSinceNow: 0)
        let nowDateC = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: 3600*8)! , from: nowDate)
        //print(datec.description)
        for i in 0..<(self.model?.data.table.weeks_count)!*7{
            let week = i/7+1
            let month = "\(datec.month ?? 0)"
            let day = "\(datec.day ?? 0)日"
            if datec.month == nowDateC.month && datec.day == nowDateC.day{
                data.currentWeeks = week
            }
            if self.data.schedule[week] == nil{
                //加？？ 只是为了防止option的出现
                self.data.schedule[week] = [month,day]
            }
            else{
                self.data.schedule[week]!.append(day)
            }
            let date = Date.init(timeInterval: 3600*24, since: datec.date!)
            datec = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: 3600*8)!, from: date)
        }
        data.semester = self.model?.data.table.name ?? "nil"
        DispatchQueue.global(qos: .background).async {
            TCCacheManager.shared.hardArchive(object: self.data, name: self.archivedFileName)
        }
        
    }
    
}
