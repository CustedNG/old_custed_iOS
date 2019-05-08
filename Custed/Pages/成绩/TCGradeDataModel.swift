//
//  TCGradeDataModel.swift
//  Custed
//
//  Created by faker on 2019/5/2.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
struct Grade:Codable {
    var code:Int
    var msg:String
    var data:GradeData
    //var runtime:CGFloat
    var lastSemester:String?
    //rangkings  "semester":ranking
    var rankings:gradeRanking?
}
/*
 {
 "code": 200,
 "msg": "ok",
 "data": {
 "college": {
 "total": 6,
 "rank": 4
 },
 "faculty": {
 "total": 3,
 "rank": 2
 },
 "major": {
 "total": 3,
 "rank": 2
 }
 },
 "runtime": 0.006871938705444336
 }
 */
struct gradeRanking:Codable {
    var code:Int
    var msg:String
    var data:gradeRankingData
    //var runtime:CGFloat
}
struct gradeRankingData:Codable {
    var college:gradeRankAndTotal
    var faculty:gradeRankAndTotal
    var major:gradeRankAndTotal
}
struct gradeRankAndTotal:Codable {
    var total:Int
    var rank:Int
}
struct GradeData : Codable {
    var version : String
    var exams : [GradeExams]
    var total : GradeTotal
    var years : [String:CGFloat]
    var levels : [String:GradeLevels]
    var personal_info : GradePersonalInfo
}
struct GradePersonalInfo:Codable {
    var major:String
    var realname:String
    var class_num:String
    var student_id:String
}
struct GradeLevels:Codable {
    var point:CGFloat
    var credit:CGFloat
    var all_num:Int
    var calc_point:CGFloat
    var powerpoint:CGFloat
    var required_num:Int
    var required_point:CGFloat
    var required_credit:CGFloat
    var required_powerpoint:CGFloat
    //that's the additional field that API didn't offered.Adding a question mark to prevent crash after request completed
    var exams:[GradeExams]?
    var description:String?
    enum CodingKeys:String,CodingKey {
        case point
        case credit
        case all_num
        case calc_point
        case powerpoint
        case required_num
        case required_point
        case required_credit
        case required_powerpoint
        case exams
        case description
    }
    
}
struct GradeTotal:Codable {
    var all:Int
    var nop:Int
    var pass:Int
    var point:CGFloat
    var credit:CGFloat
}
struct GradeExams:Codable {
    var hash:String
    var mark:Int
    var name:String
    var pass:String
    var type:String
    var hours:Int
    var level:Int
    var point:CGFloat
    var credit:CGFloat
    var remarks:String
    var raw_mark:String
    var required:String
//    enum CodingKeys:String,CodingKey {
//        case hash
//        case mark
//        case name
//        case pass
//        case type
//        case hours
//        case level
//        case point
//        case credit
//        case remarks
//        case raw_mark
//        case required
//    }
}

