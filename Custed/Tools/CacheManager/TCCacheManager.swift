//
//  TCCacheManager.swift
//  FileManager
//
//  Created by faker on 2019/4/6.
//  Copyright © 2019 no. All rights reserved.
//

import UIKit
import Foundation
class TCCacheManager: NSObject {
    static let shared = TCCacheManager()
    let ImagePath:String
    let ArchivePath:String
    let DictionaryPath:String
    override init() {
        /*在libarary/Caches目录下创建三个文件夹
            一个Image储存图片资源
            一个Archive储存归档的文件
            一个Dictionary储存dictionary对象数据（plist）
         */
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        ImagePath = path.strings(byAppendingPaths: ["Caches/Image"])[0]
        ArchivePath = path.strings(byAppendingPaths: ["Caches/Archive"])[0]
        DictionaryPath = path.strings(byAppendingPaths: ["Caches/Dictionary"])[0]
        //print(ImagePath)
        let fileDefault = FileManager.default
        //print(ImagePath)
        if  fileDefault.fileExists(atPath: ImagePath) == false{
            do {
                try fileDefault.createDirectory(atPath: ImagePath, withIntermediateDirectories: false, attributes: [:])
            }
            catch{
                print("create dictionary error :\(error)")
            }
            
        }
        if  fileDefault.fileExists(atPath: ArchivePath) == false{
            do {
                try fileDefault.createDirectory(atPath: ArchivePath, withIntermediateDirectories: false, attributes: [:])
            }
            catch{
                print("create dictionary error :\(error)")
            }
        }
        if  fileDefault.fileExists(atPath: DictionaryPath) == false{
            do {
                try fileDefault.createDirectory(atPath: DictionaryPath, withIntermediateDirectories: false, attributes: [:])
            }
            catch{
                print("create dictionary error :\(error)")
            }
        }
    }
    /* 处理图片缓存 */
    //存
    func saveImage(image:UIImage,name:String){
        let imagePath = (ImagePath as NSString).strings(byAppendingPaths: [name])[0]
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        if FileManager.default.fileExists(atPath: imagePath) == false{
            if FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil){
                print("image saved")
            }
        }
    }
    func removeImage(){
        do{
            try FileManager.default.removeItem(atPath: ImagePath)
            try FileManager.default.createDirectory(atPath: ImagePath, withIntermediateDirectories: true, attributes: nil)
        }
        catch{
            print("remove Item error: \(error)")
        }
    }
    /// Description:Archiving object to native
    ///
    /// - Parameters:
    ///   - object: The object that need to archive
    ///   - name: The file name to store
    func archive(object:NSObject,name:String) -> Void{
        let path = (ArchivePath as NSString).strings(byAppendingPaths: [name])[0]
        print(path)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: true)
            FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
        }catch{
            print("\(name):\(error)")
        }
    }
    /// Description: Unarchiving
    ///
    /// - Parameter name: The file name of unarchiving target
    /// - Returns: Got error or file not exists return nil  or return unarchived object
    func unarchive(name:String) -> NSObject?{
        let path = (ArchivePath as NSString).strings(byAppendingPaths: [name])[0]
        let value:NSObject
        if FileManager.default.fileExists(atPath: path){
            do {
                let data = FileManager.default.contents(atPath: path)
                value = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as! NSObject

            }
            catch{
                print("\(name):\(error)")
                return nil
            }
            return value
        }
        return nil
    }
    
    
    //plist
    
    /// Description:获取三个文件下的所有文件
    ///
    /// - Returns: [文件夹名:[文件名]]
    private func gettingItemsOfCachesFolder() -> [String:[String]]?{
        guard let ImageContents = try? FileManager.default.subpathsOfDirectory(atPath: ImagePath) else {return nil }
        guard let DicContents = try? FileManager.default.subpathsOfDirectory(atPath: DictionaryPath) else { return nil }
        guard let ArchiveContents = try? FileManager.default.subpathsOfDirectory(atPath: ArchivePath) else { return nil }
        let contents = [ImagePath:ImageContents,DictionaryPath:DicContents,ArchivePath:ArchiveContents]
        return contents
    }
    /// Description:获取缓存大小
    ///
    /// - Returns: 返回缓存大小(MB)，保留两位小数
    func gettingCachesSize() -> Double{
        var totalSize:Double = 0.0
        guard let contents = self.gettingItemsOfCachesFolder() else { return 0.0 }
        for (Path,folder) in contents{
            for item in folder{
                if item.first != "."{
                    let itemPath = (Path as NSString).strings(byAppendingPaths: [item])[0]
                    //print(itemPath)
                    let itemSize = try? (FileManager.default.attributesOfItem(atPath: itemPath)[FileAttributeKey.size] as! Double)
                    //很奇怪 我除1024不对，好像默认是1000
                    totalSize += itemSize!/1000.0/1000.0
                }
            }
        }
        return (totalSize * 1000.0).rounded()/1000.0
    }
    
    /// Description:清空缓存
    func emptyCaches() -> Void{
        do{
            try FileManager.default.removeItem(atPath: ImagePath)
            try FileManager.default.removeItem(atPath: ArchivePath)
            try FileManager.default.removeItem(atPath: DictionaryPath)
            try FileManager.default.createDirectory(atPath: ImagePath, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(atPath: ArchivePath, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(atPath: DictionaryPath, withIntermediateDirectories: true, attributes: nil)
        }
        catch{
            print("remove Item error: \(error)")
        }
    }
    func test1(Dic:Bool){
        do {
            let item = try FileManager.default.attributesOfItem(atPath: ImagePath)
            let size = item[FileAttributeKey.size] as! Double
            let totalSize = size/1000.0/1000.0
            print((totalSize * 1000.0).rounded()/1000.0)
        }
        catch{
            print("\(error)")
        }
    }
}
