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
struct yiYanContent {
    var content : String?
    var from : String?
    var textAlign :NSTextAlignment?
}
struct yiYan {
    var Title : String?
    var contents : [yiYanContent] = [yiYanContent.init()]
    var presentAt : NSInteger?
}
//时间和星期model
struct dateInfo {
    var dayInWeek : String?
    var dayInMonth : String?
}
//天气model
struct weather {
    var updateTime : DateComponents?
    var currentTemp : String?
    //变色的长度 也就是当前温度的数值长度
    var highlightLength : Int?
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
        // 加载信息
    }
    
    
    
    
    //获取数据并赋值
    func loadData(completedo:@escaping ()->Void) -> Bool {
        /*
         https://hitokoto.cn
         {
         "id": 3879,
         "hitokoto": "当老天都不肯放过你的时候,不管怎么努力也都是徒劳......你说呢?",
         "type": "c",
         "from": "赤印Plus 不存在的圣诞节",
         "creator": "神子少女A",
         "created_at": "1537041231"
         }
         */
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
        Alamofire.request("https://v1.hitokoto.cn/?charset=UTF-8").responseJSON(queue: requestQueue){ (response) in
            guard response.result.isSuccess else{
                //请求错误
                print("请求错误")
                queueGroup.leave()
                return
            }
            //print(Thread.current.description)
            let jsonData = String(data: response.data!, encoding: String.Encoding.utf8)
            //print("data:\(jsonData ?? "no")")
            let json = JSON(parseJSON: jsonData!)
            //赋值
            var contentStr:String = ""
            let rawContenStr : String = json["hitokoto"].stringValue
            self.yiYanDataSource?.contents[0].textAlign = NSTextAlignment.center
            if rawContenStr.count >= 17{
                self.yiYanDataSource?.contents[0].textAlign = NSTextAlignment.left
                contentStr.append("\t")
            }
            contentStr.append(rawContenStr)
            self.yiYanDataSource?.presentAt = 0
            self.yiYanDataSource?.Title = "「一言」"
            self.yiYanDataSource?.contents[0].content = contentStr
            self.yiYanDataSource?.contents[0].from = "-- 「\(json["from"].stringValue)」"
            queueGroup.leave()
        }
        // 长春citycode:101060101
        //天气接口 http://t.weather.sojson.com/api/weather/city/101060101
        /*
         "8"
         "星期五"
         "当前气温-6°C"
         "低温-2°C - 高温12°C - 晴"
         */
        queueGroup.enter()
        requestQueue.async(group:queueGroup){
            Alamofire.request("http://t.weather.sojson.com/api/weather/city/101060101").responseJSON(queue:requestQueue) { (response) in
                guard response.result.isSuccess else{
                    //请求错误
                    print("错误")
                    queueGroup.leave()
                    return
                }
                let json = JSON(response.result.value!)
                self.weatherDataSource = weather.init()
                //let updateTimeString = json["cityInfo"]["updateTime"].string ?? "莫得值"
                //print("updatetime:\(updateTimeString)")
                let nowTemp = json["data"]["wendu"].string ?? "莫得值"
                //print("nowTemp:\(nowTemp)")
                let length = nowTemp.lengthOfBytes(using: String.Encoding.utf8)
                let nowTempString:String = "当前气温\(nowTemp)°C"
                //赋值
                //print("现在的温度:",nowTempString)
                self.weatherDataSource?.currentTemp = nowTempString
                self.weatherDataSource?.highlightLength = length
                //获取最高温、最低位和天气状况
                let highTemp = json["data"]["forecast"][0]["high"].string ?? "莫得值"
                let highTempInt = self.convertToInt(highTemp)
                let lowTemp = json["data"]["forecast"][0]["low"].string ?? "莫得值"
                let lowTempInt = self.convertToInt(lowTemp)
                let weatherType = json["data"]["forecast"][0]["type"].string ?? "莫得值"
                //print("high:\(highTempInt )low:\(lowTempInt),type:\(weatherType) ")
                let tempRangeAndStatusString = "低温:\(lowTempInt)°C - 高温:\(highTempInt) - \(weatherType)"
                //赋值
                self.weatherDataSource?.tempRangeAndStatus = tempRangeAndStatusString
                //print("string:\(tempRangeAndStatusString)")
                queueGroup.leave()
            }
        }
        queueGroup.notify(queue: requestQueue) {
            //切换到主队列 刷新UI
            DispatchQueue.main.async {
                completedo()
            }
        }
        
            
        
        return true
    }
    //点击标签之后 重新拉取一言数据
    func loadingYiyan(completedDo: @escaping ()->Void){
        Alamofire.request("https://v1.hitokoto.cn/?charset=UTF-8").responseJSON{ (response) in
            guard response.result.isSuccess else{
                //请求错误
                print("请求错误")
                var nowIndex = (self.yiYanDataSource?.presentAt)!
                if nowIndex < (self.yiYanDataSource?.contents.count)! - 1{
                    nowIndex += 1
                }
                else{
                    nowIndex = 0
                }
                self.yiYanDataSource?.presentAt = nowIndex
                completedDo()
                return
            }
            //print(Thread.current.description)
            let jsonData = String(data: response.data!, encoding: String.Encoding.utf8)
            //print("data:\(jsonData ?? "no")")
            let json = JSON(parseJSON: jsonData!)
            //赋值
            let presentIndex = (self.yiYanDataSource?.presentAt)! + 1
            var textAlign = NSTextAlignment.center
            let rawContentStr = json["hitokoto"].stringValue
            var contentStr:String = ""
            if rawContentStr.count >= 17{
                textAlign = NSTextAlignment.left
                contentStr.append("\t")
            }
            contentStr.append(rawContentStr)
            self.yiYanDataSource?.presentAt = presentIndex
            let content = contentStr
            let from = "-- 「\(json["from"].stringValue)」"
            self.yiYanDataSource?.contents.append(yiYanContent.init(content: content, from: from, textAlign: textAlign))
            completedDo()
        }
    }
    func convertToInt(_ str:String) -> Int {
        //数据原型 ”高温 1.0℃“ 转换成 1
        var target = str
        target.removeLast()
        target.removeFirst(3)
        let doubleTarget : Double = Double(target) ?? 0.0
        let intTarget : Int = Int(doubleTarget)
        return intTarget
    }
    
}
