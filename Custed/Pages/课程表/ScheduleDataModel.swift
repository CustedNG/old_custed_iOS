//
//  ScheduleDataModel.swift
//  Custed
//
//  Created by faker on 2019/4/11.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import UIKit
class Schedule:NSObject,Codable,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    var code:Int
    var msg:String
    var data:scheduleData
    var runtime:Float
    enum CodingKeys:String,CodingKey {
        case code
        case msg
        case data
        case runtime
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(code,forKey: CodingKeys.code.rawValue)
        aCoder.encode(msg,forKey: CodingKeys.msg.rawValue)
        aCoder.encode(data,forKey: CodingKeys.data.rawValue)
        aCoder.encode(runtime,forKey: CodingKeys.runtime.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.code = aDecoder.decodeInteger(forKey: CodingKeys.code.rawValue)
        self.msg = aDecoder.decodeObject(forKey: CodingKeys.msg.rawValue) as! String
        self.data = aDecoder.decodeObject(of: scheduleData.self, forKey: CodingKeys.data.rawValue)!
        self.runtime = aDecoder.decodeFloat(forKey: CodingKeys.runtime.rawValue)
    }
}
class scheduleData:NSObject,Codable,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    var ver:String
    var table:scheduleTable
    var section_rules:[String:SectionRules]
    enum CodingKeys:String,CodingKey {
        case ver
        case table
        case section_rules
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ver,forKey: CodingKeys.ver.rawValue)
        aCoder.encode(table,forKey: CodingKeys.table.rawValue)
        aCoder.encode(section_rules,forKey: CodingKeys.section_rules.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.ver = aDecoder.decodeObject(forKey: CodingKeys.ver.rawValue) as! String
        self.table = aDecoder.decodeObject(of: scheduleTable.self, forKey: CodingKeys.table.rawValue)!
        self.section_rules = aDecoder.decodeObject(forKey: CodingKeys.section_rules.rawValue) as! [String:SectionRules]
    }
}
class scheduleTable:NSObject,Codable,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    var name:String
    var level:Int
    var lessons:[String:lesson]
    var subjects:[String:subject]
    var start_date:String
    var school_name:String
    var weeks_count:Int
    var start_timestamp:Double
    enum CodingKeys:String,CodingKey {
        case name
        case level
        case lessons
        case subjects
        case start_date
        case school_name
        case weeks_count
        case start_timestamp
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name,forKey: CodingKeys.name.rawValue)
        aCoder.encode(level,forKey: CodingKeys.level.rawValue)
        aCoder.encode(lessons,forKey: CodingKeys.lessons.rawValue)
        aCoder.encode(subjects,forKey: CodingKeys.subjects.rawValue)
        aCoder.encode(start_date,forKey: CodingKeys.start_date.rawValue)
        aCoder.encode(school_name,forKey: CodingKeys.school_name.rawValue)
        aCoder.encode(weeks_count,forKey: CodingKeys.weeks_count.rawValue)
        aCoder.encode(start_timestamp,forKey: CodingKeys.start_timestamp.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as! String
        self.level = aDecoder.decodeInteger(forKey: CodingKeys.level.rawValue)
        self.lessons = aDecoder.decodeObject(forKey: CodingKeys.lessons.rawValue) as! [String:lesson]
        self.subjects = aDecoder.decodeObject(forKey: CodingKeys.subjects.rawValue) as! [String:subject]
        self.start_date = aDecoder.decodeObject(forKey: CodingKeys.start_date.rawValue) as! String
        self.school_name = aDecoder.decodeObject(forKey: CodingKeys.school_name.rawValue) as! String
        self.weeks_count = aDecoder.decodeInteger(forKey: CodingKeys.weeks_count.rawValue)
        self.start_timestamp = aDecoder.decodeDouble(forKey: CodingKeys.start_timestamp.rawValue)
    }
    
}
class lesson:NSObject,Codable,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    var term:Int
    var year:Int
    var weeks:[Int]
    var classes:[String]
    var week_day:Int
    var location:String
    var raw_weeks:String
    var end_section:Int
    var lesson_hash:String
    var lesson_name:String
    var lesson_type:Int
    var raw_classes:String
    var student_num:Int
    var subject_uid:String
    var teacher_name:String
    var start_section:Int
    var canShow:Bool = false
    var start_time:String = ""
    var end_time:String = ""
    enum CodingKeys:String,CodingKey {
        case term
        case year
        case weeks
        case classes
        case week_day
        case location
        case raw_weeks
        case end_section
        case lesson_hash
        case lesson_name
        case lesson_type
        case raw_classes
        case student_num
        case subject_uid
        case teacher_name
        case start_section
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(term,forKey: CodingKeys.term.rawValue)
        aCoder.encode(year,forKey: CodingKeys.year.rawValue)
        aCoder.encode(weeks,forKey: CodingKeys.weeks.rawValue)
        aCoder.encode(classes,forKey: CodingKeys.classes.rawValue)
        aCoder.encode(week_day,forKey: CodingKeys.week_day.rawValue)
        aCoder.encode(location,forKey: CodingKeys.location.rawValue)
        aCoder.encode(raw_weeks,forKey: CodingKeys.raw_weeks.rawValue)
        aCoder.encode(end_section,forKey: CodingKeys.end_section.rawValue)
        aCoder.encode(lesson_hash,forKey: CodingKeys.lesson_hash.rawValue)
        aCoder.encode(lesson_name,forKey: CodingKeys.lesson_name.rawValue)
        aCoder.encode(lesson_type,forKey: CodingKeys.lesson_type.rawValue)
        aCoder.encode(raw_classes,forKey: CodingKeys.raw_classes.rawValue)
        aCoder.encode(student_num,forKey: CodingKeys.student_num.rawValue)
        aCoder.encode(subject_uid,forKey: CodingKeys.subject_uid.rawValue)
        aCoder.encode(teacher_name,forKey: CodingKeys.teacher_name.rawValue)
        aCoder.encode(start_section,forKey: CodingKeys.start_section.rawValue)
        
        aCoder.encode(start_time,forKey: "start_time")
        aCoder.encode(end_time,forKey: "end_time")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.term = aDecoder.decodeInteger(forKey: CodingKeys.term.rawValue)
        self.year = aDecoder.decodeInteger(forKey: CodingKeys.year.rawValue)
        self.weeks = aDecoder.decodeObject(forKey: CodingKeys.weeks.rawValue) as! [Int]
        self.classes = aDecoder.decodeObject(forKey: CodingKeys.classes.rawValue) as! [String]
        self.week_day = aDecoder.decodeInteger(forKey: CodingKeys.week_day.rawValue)
        self.location = aDecoder.decodeObject(forKey: CodingKeys.location.rawValue) as! String
        self.raw_weeks = aDecoder.decodeObject(forKey: CodingKeys.raw_weeks.rawValue) as! String
        self.end_section = aDecoder.decodeInteger(forKey: CodingKeys.end_section.rawValue)
        self.lesson_hash = aDecoder.decodeObject(forKey: CodingKeys.lesson_hash.rawValue) as! String
        self.lesson_name = aDecoder.decodeObject(forKey: CodingKeys.lesson_name.rawValue) as! String
        self.lesson_type = aDecoder.decodeInteger(forKey: CodingKeys.lesson_type.rawValue)
        self.raw_classes = aDecoder.decodeObject(forKey: CodingKeys.raw_classes.rawValue) as! String
        self.student_num = aDecoder.decodeInteger(forKey: CodingKeys.student_num.rawValue)
        self.subject_uid = aDecoder.decodeObject(forKey: CodingKeys.subject_uid.rawValue) as! String
        self.teacher_name = aDecoder.decodeObject(forKey: CodingKeys.teacher_name.rawValue) as! String
        self.start_section = aDecoder.decodeInteger(forKey: CodingKeys.start_section.rawValue)
        
        self.start_time = aDecoder.decodeObject(forKey: "start_time") as! String
        self.end_time = aDecoder.decodeObject(forKey: "end_time") as! String
    }
}
class subject:NSObject,Codable,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    var is_exam:Bool
    var subject_uid:String
    var subject_name:String
    enum CodingKeys:String,CodingKey {
        case is_exam
        case subject_uid
        case subject_name
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(is_exam,forKey: CodingKeys.is_exam.rawValue)
        aCoder.encode(subject_uid,forKey: CodingKeys.subject_uid.rawValue)
        aCoder.encode(subject_name,forKey: CodingKeys.subject_name.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.is_exam = aDecoder.decodeBool(forKey: CodingKeys.is_exam.rawValue)
        self.subject_uid = aDecoder.decodeObject(forKey: CodingKeys.subject_uid.rawValue) as! String
        self.subject_name = aDecoder.decodeObject(forKey: CodingKeys.subject_name.rawValue) as! String
        //self.color = UIColor.RandomColor()
    }
}
class SectionRules:NSObject,Codable,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    var rules:[String:rule]
    var type:Int
    enum CodingKeys:String,CodingKey{
        case rules = "rule"
        case type
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(rules,forKey: CodingKeys.rules.rawValue)
        aCoder.encode(type,forKey: CodingKeys.type.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.rules = aDecoder.decodeObject(forKey: CodingKeys.rules.rawValue) as! [String:rule]
        self.type = aDecoder.decodeInteger(forKey: CodingKeys.type.rawValue)
    }
}
class rule:NSObject,Codable,NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    //    "section":1,
    //    "end_time":"08:45",
    //    "start_time":"08:00"
    var section:Int
    var end_time:String
    var start_time:String
    private enum CodingKeys:String,CodingKey{
        case section
        case end_time
        case start_time
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(section,forKey: CodingKeys.section.rawValue)
        aCoder.encode(end_time,forKey: CodingKeys.end_time.rawValue)
        aCoder.encode(start_time,forKey: CodingKeys.start_time.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.section = aDecoder.decodeInteger(forKey: CodingKeys.section.rawValue)
        self.end_time = aDecoder.decodeObject(forKey: CodingKeys.end_time.rawValue) as! String
        self.start_time = aDecoder.decodeObject(forKey: CodingKeys.start_time.rawValue) as! String
    }
    
    
    
    
    
}

