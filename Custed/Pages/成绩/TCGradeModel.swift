//
//  TCGradeModel.swift
//  Custed
//
//  Created by faker on 2019/3/27.
//  Copyright © 2019 Toast. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
class TCGradeModel: NSObject {
    var grade:Grade?
    var lastSemester:String = "1"
    private var archiverFileName = "grade.archiver"
    private var IntToString = [
        "1":"第一学期",
        "2":"第二学期",
        "3":"第三学期",
        "4":"第四学期",
        "5":"第五学期",
        "6":"第六学期",
        "7":"第七学期",
        "8":"第八学期",
    ]
    //var model:GradeModel!
    //var classForLevel:[Int:GradeExams]!
    /// Description: getting etag and judge whether need to refresh from remote
    ///
    /// - Parameter needFresh: completed do
    func WhetherNeedRefresh(_ needFresh:@escaping (Bool)->() )->Void{
        let header = [
            "accept": "*/*",
            "if-none-match": UserDefaults.standard.string(forKey: "gradeEtag") ?? ""
        ]
        let url = "https://app.cust.edu.cn/static/js/3.26061f5637ceece094e6.js"
        Alamofire.SessionManager.ephemeral.request(url, method: .get, parameters: nil,headers: header).response { (response) in
            if response.response?.statusCode == Optional(200){
                let etag = response.response?.allHeaderFields["Etag"] as? String
                UserDefaults.standard.setValue(etag, forKey: "gradeEtag")
                needFresh(true)
            }
            else{
                needFresh(false)
                //needFresh(true)
            }
            
        }
    }
    func forceToUpdate(completedDo:@escaping (Bool)->Void){
        let header = ["accept": "application/vnd.toast+json"]
        let url = "https://beta.tusi.site/app/v1/cust/jwgl/grade/remote"
        Alamofire.SessionManager.timeOut.request(url,headers:header).response { (DefaultDataResponse) in
            guard DefaultDataResponse.response?.statusCode == 200 else {
                print(DefaultDataResponse.response?.statusCode)
                completedDo(false)
                return
            }
            let decode = JSONDecoder()
            do {
                self.grade = try decode.decode(Grade.self, from: DefaultDataResponse.data!)
            }catch{
                print("\(error)")
            }
            self.parseData()
            completedDo(true)
        }
    }
    func getData(isremote:Bool=false,completedDo:@escaping (Bool)->Void ){
        self.WhetherNeedRefresh { (needFresh) in
            // request
            self.grade = TCCacheManager.shared.codableUnarchive(name: self.archiverFileName, as: Grade.self)
            if needFresh == true || self.grade == nil{
                let header = ["accept": "application/vnd.toast+json"]
                let url:String
                if isremote == true{
                    url = "https://beta.tusi.site/app/v1/cust/jwgl/grade/remote"
                }
                else{
                    url = "https://beta.tusi.site/app/v1/cust/jwgl/grade"
                }
                let group = DispatchGroup.init()
                let requestQueue = DispatchQueue.global()
                group.enter()
                let response = Alamofire.SessionManager.timeOut.request(url, headers: header).response(queue:requestQueue, completionHandler: { (DefaultDataResponse) in
                    guard DefaultDataResponse.response?.statusCode == 200 else {
                        print(DefaultDataResponse.response?.statusCode)
                        DispatchQueue.main.async {
                            completedDo(false)
                        }
                        return
                    }
                    let decode = JSONDecoder()
                    do {
                        self.grade = try decode.decode(Grade.self, from: DefaultDataResponse.data!)
                    }catch{
                        print("\(error)")
                    }
                    //print(self.grade.data)
                    self.parseData()
                    print("request and parsing done")
//                    completedDo()
                    group.leave()
                })
                debugPrint(response)

                group.notify(queue: requestQueue, execute: {
                    let index:String = self.grade?.lastSemester ?? "1"
                    let header = ["accept": "application/vnd.toast+json"]
                    let url = "https://beta.tusi.site/app/v1/cust/jwgl/grade/rank/"+index
                    Alamofire.SessionManager.timeOut.request(url, method: .get, headers: header) .response(completionHandler: { (response) in
                        let decoder = JSONDecoder()
                        do{
                            self.grade?.rankings = try decoder.decode(gradeRanking.self, from: response.data!)
                        }catch{
                            print("\(error)")
                        }
                        print("ranking request done")
                        requestQueue.async {
                            TCCacheManager.shared.codableArchive(object: self.grade, name: self.archiverFileName)
                        }
                        completedDo(true)
                    })
                })
            }
            else{
                completedDo(true)
            }
        }
    }
    private func parseData(){
        //var classifiedExams = [String:[GradeExams]]()
        // classify exams depend on level
        var maxLevel = 0
        for (key,_) in (self.grade?.data.levels)!{
            self.grade?.data.levels[key]?.description = self.IntToString[key]
        }
        for item in self.grade!.data.exams{
            let index = String(item.level)
            //print(item.pass)
            if item.level > maxLevel{
                maxLevel = item.level
            }
            if self.grade!.data.levels[index]?.exams == nil{
                self.grade!.data.levels[index]?.exams = [GradeExams]()
            }
            self.grade!.data.levels[index]?.exams!.append(item)
        }
        self.grade?.lastSemester = "\(maxLevel)"
        //print(lastSemester)
    }
}
