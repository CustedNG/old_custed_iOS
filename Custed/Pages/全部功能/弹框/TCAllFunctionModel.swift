//
//  TCAllFunctionModel.swift
//  Custed
//
//  Created by faker on 2019/3/6.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

// 一言model
struct yiYan {
    var Title : String?
    var content : String?
    var from : String?
    var textAlign :NSTextAlignment?
}
//时间和星期model
struct dateInfo {
    var dayInWeek : String?
    var dayInMonth : String?
}
//天气model
struct weather {
    var currentTemp : NSMutableAttributedString?
    var tempRangeAndStatus : String?
}
class TCAllFunctionModel: NSObject {
    var yiYanDataSource :yiYan?
    var weatherDataSource :weather?
    var dateInfoSource :dateInfo?
    
    override init() {
        super.init()
        self.yiYanDataSource = yiYan.init()
        self.dateInfoSource = dateInfo.init()
        self.weatherDataSource = weather.init()
        // 加载信息
    }
    
    
    
    
    //获取数据并赋值
    func loadData(completedo:@escaping ()->Void) -> Void {
        let queueGroup = DispatchGroup()
        let requestQueue = DispatchQueue.global(qos: .default)
        requestQueue.async(group:queueGroup) {
            let weekdays:NSArray = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
            let date = Date()
            let calender = Calendar.current
            let dateComponent = calender.dateComponents(in: TimeZone.init(secondsFromGMT: 3600*8)!, from: date)
            
            let dayInWeekString = weekdays[dateComponent.weekday!-1]
            let dayInMonthString = String.init(format: "%d", dateComponent.day!)
            
            //赋值
            self.dateInfoSource?.dayInMonth = dayInMonthString
            self.dateInfoSource?.dayInWeek = dayInWeekString as? String
        }
        queueGroup.enter()
        self.gettingYiyan(queue: requestQueue) {
            queueGroup.leave()
        }
        queueGroup.enter()
        requestQueue.async(group:queueGroup){        Alamofire.request("https://beta.tusi.site/app/v1/etc/weather",headers:["accept": "application/vnd.toast+json"]).responseJSON(queue:requestQueue) { (response) in
            guard response.result.isSuccess else{
                //请求错误
                self.yiYanDataSource?.content = "电波无法到达～轻触重试"
                queueGroup.leave()
                return
            }
            let json = JSON(response.data!)
            let currentTemp = json["data"]["weather"]["wendu"].stringValue
            let currentTempStr = "当前温度 \(currentTemp) ℃"
            let currenAttr = NSMutableAttributedString.init(string: currentTempStr)
            currenAttr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.FromRGB(RGB: 0x65AEF4), range: NSRange.init(location: 5, length: currentTemp.count))
            self.weatherDataSource?.currentTemp = currenAttr
            let highTemp = json["data"]["weather"]["forecast"]["weather"][0]["high"].stringValue
            let lowTemp = json["data"]["weather"]["forecast"]["weather"][0]["low"].stringValue
            let status = json["data"]["weather"]["forecast"]["weather"][0]["day"]["type"].stringValue
            self.weatherDataSource?.tempRangeAndStatus = "\(highTemp) - \(lowTemp) \(status)"
            //debugPrint(response)
            queueGroup.leave()
            }
        }
        queueGroup.notify(queue: requestQueue) {
            //切换到主队列 刷新UI
            DispatchQueue.main.async {
                completedo()
            }
        }
    }
    //点击标签之后 重新拉取一言数据
//    func loadingYiyan(completedDo: @escaping ()->Void){
//        Alamofire.request("https://v1.hitokoto.cn/?charset=UTF-8").responseJSON{ (response) in
//            guard response.result.isSuccess else{
//                //请求错误
//                print("请求错误")
//                completedDo()
//                return
//            }
//            debugPrint(response)
//            //print(Thread.current.description)
//            let jsonData = String(data: response.data!, encoding: String.Encoding.utf8)
//            //print("data:\(jsonData ?? "no")")
//            let json = JSON(parseJSON: jsonData!)
//            //赋值
////            let presentIndex = (self.yiYanDataSource?.presentAt)! + 1
//            var textAlign = NSTextAlignment.center
//            let rawContentStr = json["hitokoto"].stringValue
//            var contentStr:String = ""
//            if rawContentStr.count >= 17{
//                textAlign = NSTextAlignment.left
//                contentStr.append("\t")
//            }
////            contentStr.append(rawContentStr)
////            self.yiYanDataSource?.presentAt = presentIndex
////            let content = contentStr
////            let from = "-- 「\(json["from"].stringValue)」"
////            self.yiYanDataSource?.contents.append(yiYanContent.init(content: content, from: from, textAlign: textAlign))
//            completedDo()
//        }
//    }
    func convertToInt(_ str:String) -> Int {
        //数据原型 ”高温 1.0℃“ 转换成 1
        var target = str
        target.removeLast()
        target.removeFirst(3)
        let doubleTarget : Double = Double(target) ?? 0.0
        let intTarget : Int = Int(doubleTarget)
        return intTarget
    }
    
    
    func gettingYiyan(queue:DispatchQueue=DispatchQueue.main ,completedDo: @escaping () -> Void) -> Void {
        let headers = ["accept": "application/vnd.toast+json"]
        Alamofire.request("https://beta.tusi.site/app/v1/etc/hitokoto",headers: headers).responseJSON(queue:queue){ (response) in
            guard response.result.isSuccess else{
                //请求错误
                completedDo()
                return
            }
            //let jsonData = String(data: response.data!, encoding: String.Encoding.utf8)
            let json = JSON(response.data!)
            //赋值
            var contentStr : String = "\t\t"
            let rawContenStr : String = json["data"]["hitokoto"].stringValue
            if rawContenStr.count >= 15{
                self.yiYanDataSource?.textAlign = .left
                contentStr.append(rawContenStr)
            }
            else{
                self.yiYanDataSource?.textAlign = .center
                contentStr = rawContenStr
            }
            self.yiYanDataSource?.content = contentStr
            self.yiYanDataSource?.from = "——「\(json["data"]["from"].stringValue)」"
            completedDo()
        }
    }
    
}
