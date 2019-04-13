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
class TCScheduleModel: NSObject {
    func convertSectionRuleTime(dateStr : String) ->[Int]{
        let datef = DateFormatter.init()
        datef.dateFormat = "HH:mm"
        let str = datef.date(from: dateStr) ?? datef.date(from: "00:00")
        let datec = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: 3600*8)!, from: str!)
        return [datec.hour!,datec.minute!]
    }
    func getScheduleData(isRemote:Bool=false,completedDo:@escaping ()->Void) -> Void{
        //URLCache.shared.removeAllCachedResponses()
        let headers = [
            "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
            "if-none-match":"W/\"5cadebde-174e\"",
            //            "if-modified-since":"Wed, 10 Apr 2019 13:13:02 GMT"
            //            "cookies": "184$e237aa7dde2bdfcb21bbe05056f6c536785b5b106541ba212506e98c7c508ced$acd71361"
        ]
        //"custed-token=\(TCUserManager.shared.getTokenValue() ?? "")"
        
        let url1 = "https://app.cust.edu.cn/schedule"
        let url = URL.init(string: url1)
//        let config = URLSessionConfiguration.default
//        config.requestCachePolicy = .reloadIgnoringLocalCacheData
//        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
//        let sesson = SessionManager(configuration: config)
//        let request = NSMutableURLRequest.init(url: url!, cachePolicy: .reloadIgnoringLocalCacheData,timeoutInterval: .init(10))
//        request.addValue("W/\"5cadebde-174e\"", forHTTPHeaderField: "if-none-match")
//        do{
//            var urlRequest = try URLRequest.init(url: url!, method: .get, headers: headers)
//            URLRequest.CachePolicy.reloadIgnoringCacheData
//        }catch{
//
//        }
        let config = URLSessionConfiguration.ephemeral
        let session = Alamofire.SessionManager(configuration:config)
        //let response = session.request(url!,headers:headers)
        DispatchQueue.global().async {
            print(Thread.current)
            let response = Alamofire.SessionManager.default.request(url1,headers:headers).response { (DefaultDataResponse) in
                debugPrint(DefaultDataResponse)
                print(DefaultDataResponse.response?.statusCode)
                //print(DefaultDataResponse.response?.statusCode)
                //let status = DefaultDataResponse.response?.allHeaderFields["status"]
                //print(status)
                //            print(etag)
                //            UserDefaults.standard.setValue(etag, forKey: "etag")
                //print(DefaultDataResponse.data)
                //            let str = String.init(data: DefaultDataResponse.data!, encoding: String.Encoding.utf8)
                //            print(str)
                //        }
                //          debugPrint(response)
                //        //print(response)
            }
            debugPrint(response)
        }
        DispatchQueue.global().async {
            print(Thread.current)
            let response = Alamofire.request(url1,headers:headers).response { (DefaultDataResponse) in
                debugPrint(DefaultDataResponse)
                print(DefaultDataResponse.response?.statusCode)
                //print(DefaultDataResponse.response?.statusCode)
                //let status = DefaultDataResponse.response?.allHeaderFields["status"]
                //print(status)
                //            print(etag)
                //            UserDefaults.standard.setValue(etag, forKey: "etag")
                //print(DefaultDataResponse.data)
                //            let str = String.init(data: DefaultDataResponse.data!, encoding: String.Encoding.utf8)
                //            print(str)
                //        }
                //          debugPrint(response)
                //        //print(response)
            }
            debugPrint(response)
        }
    }
}
