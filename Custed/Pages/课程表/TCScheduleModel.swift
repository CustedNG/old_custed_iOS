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
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.ScheduleForWeeks = aDecoder.decodeObject(forKey: "SFK") as! Dictionary<Int, [Int : [Int : lesson]]>
        self.currentWeeks = aDecoder.decodeInteger(forKey: "currentWeeks")
        self.schedule = aDecoder.decodeObject(forKey: "schedule") as! [Int : [String]]
        self.semester = aDecoder.decodeObject(forKey: "semester") as! String
    }
    override init() {
        self.ScheduleForWeeks = Dictionary<Int,[Int:[Int:lesson]]>()
        self.currentWeeks = 0
        self.schedule = Dictionary<Int,[String]>()
        self.semester = ""
        super.init()
    }
    
    //week:[day:[[start_section:lesson]]]
    var ScheduleForWeeks:[Int:[Int:[Int:lesson]]]
    var currentWeeks:Int
    //第几周：【几月，几日，几日】
    var schedule:[Int:[String]]
    var semester:String
}
class TCScheduleModel: NSObject{
    var model:Schedule?
    var data:dataAfterParsing = dataAfterParsing.init()
    var archivedFileName:String = "schedule.archiver"
    private let weekdays:NSArray = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
    func convertSectionRuleTime(dateStr : String) ->[Int]{
        let datef = DateFormatter.init()
        datef.dateFormat = "HH:mm"
        let str = datef.date(from: dateStr) ?? datef.date(from: "00:00")
        let datec = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: 3600*8)!, from: str!)
        return [datec.hour!,datec.minute!]
    }
    func getScheduleData(isRemote:Bool=false,completedDo:@escaping ()->Void) -> Void{

        //URLCache.shared.removeAllCachedResponses()
        gettingEtag(completedDo: { (isGttingDataFromRemote) in
            if isGttingDataFromRemote == true{
                //URLCache.shared.removeAllCachedResponses()
                var url = "https://beta.tusi.site/app/v1/cust/jwgl/schedule/"
                if isRemote == true{
                    url = "https://beta.tusi.site/app/v1/cust/jwgl/schedule/remote"
                }
                let headers = [
                    "accept": "application/vnd.toast+json"
                ]
                let response = Alamofire.request(url,headers:headers).response{ (DefaultDataResponse) in
                    //debugPrint(DefaultDataResponse)
                    guard DefaultDataResponse.response?.statusCode == 200 else{
                        TCToast.showWithMessage(DefaultDataResponse.error.debugDescription)
                        return
                    }
                    do{
                        let decoder = JSONDecoder()
                        self.model = try decoder.decode(Schedule.self, from: DefaultDataResponse.data!)
                        let responseHeaders = DefaultDataResponse.response?.allHeaderFields as! [String:String]
                        let Url = DefaultDataResponse.request?.url
                        let cookies = HTTPCookie.cookies(withResponseHeaderFields: responseHeaders, for: Url!)
                        HTTPCookieStorage.shared.setCookies(cookies, for: Url!, mainDocumentURL: nil)
                        self.parseData()
                        completedDo()
                    }catch{
                        print("\(error)")
                    }
                }
                
                debugPrint(response)
            }
            else{
//                self.model = (TCCacheManager.shared.unarchive(name: self.archivedFileName) as! Schedule)
//                self.parseData()
//                completedDo()
//                return
                self.data = TCCacheManager.shared.unarchive(name: self.archivedFileName) as! dataAfterParsing
                completedDo()
            }
            
        })
        
        
        
    }
    func gettingData()->Void{
    }
    /// Description:Getting etag
    ///
    /// - Returns:if statusCode == 200 return true ==304 return false
    func gettingEtag(completedDo:@escaping (Bool)->Void)->Void{
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
                debugPrint(DefaultDataResponse)
                UserDefaults.standard.setValue(etag, forKey: "Etag")
                flag = true
                completedDo(flag)
            }
            else{
                flag = false
                completedDo(flag)
            }
        }
        
    }
    func parseData()->Void{
        for (_,value) in (self.model?.data.table.lessons)!{
                if value.lesson_type == 2{
                    value.color = UIColor.init(red: 0.851, green: 0.314, blue: 0.475, alpha: 1.0)
                }
                if value.lesson_name == ""{
                    let subject_uid = value.subject_uid
                    for (subjectKey,subjectValue) in (self.model?.data.table.subjects)!{
                        if subject_uid == subjectKey{
                            value.lesson_name = subjectValue.subject_name
                            value.color = subjectValue.color
                        }
                    }
                }
                print(value.lesson_name)
                for week in value.weeks{
                    if self.data.ScheduleForWeeks[week] == nil {
                        self.data.ScheduleForWeeks[week] = [value.week_day:[value.start_section:value]]
                    }
                    else if self.data.ScheduleForWeeks[week]![value.week_day] == nil{
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
